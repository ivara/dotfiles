-- Blink.cmp: Fast, modern completion
-- https://github.com/saghen/blink.cmp
return {
  {
    'saghen/blink.cmp',
    version = '1.*',
    event = 'InsertEnter',
    dependencies = {
      'rafamadriz/friendly-snippets', -- Optional: community snippets
    },
    opts = {
      keymap = {
        preset = 'super-tab',
        ['<C-y>'] = { 'select_and_accept', 'fallback' },
        ['<CR>'] = { 'accept', 'fallback' },
      },
      appearance = {
        use_nvim_cmp_as_default = false,
        nerd_font_variant = 'mono',
      },
      completion = {
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 200,
          window = { border = 'rounded' },
        },
        menu = {
          border = 'rounded',
          winhighlight = 'Normal:BlinkCmpMenu,FloatBorder:BlinkCmpMenuBorder,CursorLine:PmenuSel,Search:None',
          draw = {
            columns = { { 'kind_icon' }, { 'label', 'label_description', gap = 1 } },
          },
        },
        ghost_text = { enabled = true },
      },
      signature = {
        enabled = true,
        window = { border = 'rounded' },
      },
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },
    },
  },
}
