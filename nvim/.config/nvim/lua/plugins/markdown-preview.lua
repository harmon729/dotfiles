return {
  -- markdown-preview
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = "cd app && npm install && git restore .",
    lazy = true,

    config = function()
      -- set to true, nvim will open the preview window after entering the Markdown buffer
      -- default: false
      vim.g.mkdp_auto_start = true

      -- set to true, the nvim will auto close current preview window when changing
      -- from Markdown buffer to another buffer
      -- default: true
      vim.g.mkdp_auto_close = true

      -- set to true, Vim will refresh Markdown when saving the buffer or
      -- when leaving insert mode. Default false is auto-refresh Markdown as you edit or
      -- move the cursor
      -- default: false
      vim.g.mkdp_refresh_slow = false

      -- set to true, the MarkdownPreview command can be used for all files,
      -- by default it can be use in Markdown files only
      -- default: false
      vim.g.mkdp_command_for_global = false

      -- set to true, the preview server is available to others in your network.
      -- By default, the server listens on localhost (127.0.0.1)
      -- default: false
      vim.g.mkdp_open_to_the_world = true

      -- use custom IP to open preview page.
      -- Useful when you work in remote Vim and preview on local browser.
      -- For more details see: https://github.com/iamcco/markdown-preview.nvim/pull/9
      -- default empty
      vim.g.mkdp_open_ip = "47.84.43.169"
      -- vim.g.mkdp_host = "0.0.0.0"

      -- use a custom port to start server or empty for random
      vim.g.mkdp_port = "8080"

      -- specify browser to open preview page
      -- for path with space
      -- valid: `/path/with\ space/xxx`
      -- invalid: `/path/with\\ space/xxx`
      -- default: ''
      -- vim.g.mkdp_browser = ""

      -- set to true, echo preview page URL in command line when opening preview page
      -- default is false
      vim.g.mkdp_echo_preview_url = true

      -- a custom Vim function name to open preview page
      -- this function will receive URL as param
      -- default is empty
      vim.g.mkdp_browserfunc = ""

      -- options for Markdown rendering
      -- mkit: markdown-it options for rendering
      -- katex: KaTeX options for math
      -- uml: markdown-it-plantuml options
      -- maid: mermaid options
      -- disable_sync_scroll: whether to disable sync scroll, default false
      -- sync_scroll_type: 'middle', 'top' or 'relative', default value is 'middle'
      --   middle: means the cursor position is always at the middle of the preview page
      --   top: means the Vim top viewport always shows up at the top of the preview page
      --   relative: means the cursor position is always at relative positon of the preview page
      -- hide_yaml_meta: whether to hide YAML metadata, default is true
      -- sequence_diagrams: js-sequence-diagrams options
      -- content_editable: if enable content editable for preview page, default: v:false
      -- disable_filename: if disable filename header for preview page, default: false
      vim.g.mkdp_preview_options = {
        mkit = {},
        katex = {},
        uml = {},
        maid = {},
        disable_sync_scroll = false,
        sync_scroll_type = "middle",
        hide_yaml_meta = true,
        sequence_diagrams = {},
        flowchart_diagrams = {},
        content_editable = false,
        disable_filename = false,
        toc = {},
      }

      -- use a custom Markdown style. Must be an absolute path
      -- like '/Users/username/markdown.css' or expand('~/markdown.css')
      vim.g.mkdp_markdown_css = ""

      -- use a custom highlight style. Must be an absolute path
      -- like '/Users/username/highlight.css' or expand('~/highlight.css')
      vim.g.mkdp_highlight_css = ""

      -- preview page title
      -- ${name} will be replace with the file name
      vim.g.mkdp_page_title = "「${name}」"

      -- use a custom location for images
      -- vim.g.mkdp_images_path = "/home/harmon/.markdown_images"
      -- vim.g.mkdp_images_path = "./"

      -- set default theme (dark or light)
      -- By default the theme is defined according to the preferences of the system
      vim.g.mkdp_theme = "dark"

      -- combine preview window
      -- default: false
      -- if enable it will reuse previous opened preview window when you preview markdown file.
      -- ensure to set vim.g.mkdp_auto_close = false if you have enable this option
      vim.g.mkdp_combine_preview = false

      -- auto refetch combine preview contents when change markdown buffer
      -- only when g:mkdp_combine_preview is true
      vim.g.mkdp_combine_preview_auto_refresh = true
    end,
  },
}
