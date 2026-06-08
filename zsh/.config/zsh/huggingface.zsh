#!/usr/bin/env zsh

# huggingface_hub downloads deadlock in this WSL env when going through the
# Windows Clash proxy (172.22.16.1:7897, TUN/fake-ip).
#
# Root cause: the Hub is Xet-backed and hf-xet (Rust) downloads each file with an
# ADAPTIVE concurrency controller that ramps parallel byte-range GETs up to ~64.
# Clash can't sustain that many tunnels to transfer.xethub.hf.co and cuts them
# ("peer closed connection without sending TLS close_notify"), so the transfer
# stalls to 0 and the process hangs. `--max-workers` does NOT help — it's
# file-level; Xet's parallelism is internal to the Rust client.
#
# Fix: disable Xet -> huggingface_hub falls back to legacy single-stream LFS
# (one resumable connection). Verified: steady ~10 MB/s, 2 connections, no stalls.
export HF_XET_HIGH_PERFORMANCE=1
export HF_HUB_DOWNLOAD_TIMEOUT=30   # stalled read aborts in 30s and auto-resumes
export HF_XET_NUM_CONCURRENT_RANGE_GETS=8

