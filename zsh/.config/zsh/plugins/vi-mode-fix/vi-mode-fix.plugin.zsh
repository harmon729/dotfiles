#!/usr/bin/env zsh

# fix(vi-mode): re-render cursor after exisiting visual mode (ohmyzsh#11705) #13597
function _vi-mode-set-cursor-shape-for-keymap() {
  [[ "$VI_MODE_SET_CURSOR" = true ]] || return
  local _shape=0
  case "${1:-${VI_KEYMAP:-main}}" in
    main)        _shape=$VI_MODE_CURSOR_INSERT ;;
    viins)       _shape=$VI_MODE_CURSOR_INSERT ;;
    isearch)     _shape=$VI_MODE_CURSOR_INSERT ;;
    command)     _shape=$VI_MODE_CURSOR_INSERT ;;
    vicmd)       _shape=$VI_MODE_CURSOR_NORMAL ;;
    visual)      _shape=$VI_MODE_CURSOR_VISUAL ;;
    visual-line) _shape=$VI_MODE_CURSOR_VISUAL ;;
    viopp)       _shape=$VI_MODE_CURSOR_OPPEND ;;
    *)           _shape=0 ;;
  esac
  printf $'\e[%d q' "${_shape}"
}
function zle-line-pre-redraw() {
  if [[ "$REGION_ACTIVE" -eq 0 && ("$VI_KEYMAP" == visual || "$VI_KEYMAP" == visual-line) ]]; then
    typeset -g VI_KEYMAP=$KEYMAP
    _vi-mode-set-cursor-shape-for-keymap "$VI_KEYMAP"
  elif [[ "$REGION_ACTIVE" -eq 1 && "$VI_KEYMAP" != "visual" ]]; then
    typeset -g VI_KEYMAP=visual
    _vi-mode-set-cursor-shape-for-keymap "$VI_KEYMAP"
  elif [[ "$REGION_ACTIVE" -eq 2 && "$VI_KEYMAP" != "visual-line" ]]; then
    typeset -g VI_KEYMAP=visual-line
    _vi-mode-set-cursor-shape-for-keymap "$VI_KEYMAP"
  fi
}
zle -N zle-line-pre-redraw
