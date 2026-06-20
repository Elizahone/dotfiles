vim.pack.add({
    {
        src = "https://github.com/saghen/blink.cmp"
    },
})

require('blink.cmp').setup({
  keymap = {
    preset = 'none',
    ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
    ['<C-g>'] = { 'hide', 'fallback' },
    ['<C-y>'] = { 'select_and_accept', 'fallback' },

    ['<Up>'] = { 'select_prev', 'fallback' },
    ['<Down>'] = { 'select_next', 'fallback' },
    ['<C-p>'] = { 'select_prev', 'fallback_to_mappings' },
    ['<C-n>'] = { 'select_next', 'fallback_to_mappings' },

    ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
    ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },

    ['<Tab>'] = { 'snippet_forward', 'fallback' },
    ['<S-Tab>'] = { 'snippet_backward', 'fallback' },

    ['<C-k>'] = { 'show_signature', 'hide_signature', 'fallback' },
    ['<C-u>'] = { 'scroll_signature_up', 'fallback' },
    ['<C-d>'] = { 'scroll_signature_down', 'fallback' },
},
  appearance = {
    nerd_font_variant = 'mono'
  },
  completion = {
    documentation = { auto_show = true },

  menu = {
      -- Don't automatically show the completion menu
      auto_show = true,

      -- nvim-cmp style menu
      draw = {
        columns = {
          { "label", "label_description", gap = 1 },
          { "kind_icon", "kind" }
        },
      }
    },

    -- Show documentation when selecting a completion item
  documentation = { auto_show = true, auto_show_delay_ms = 500 },
  },
  sources = {
    default = { 'lsp', 'path', 'snippets', 'buffer' },
  },
  fuzzy = {
    implementation = "lua"
  },
  signature = { enabled = true },
})
