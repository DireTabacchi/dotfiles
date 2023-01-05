" ------- BEGIN PLUGINS =====================
call plug#begin('~/.vim/plugged')
" ------- Themes ============================
Plug 'arcticicestudio/nord-vim'
Plug 'dracula/vim', {'as':'dracula'}
Plug 'chriskempson/tomorrow-theme/'
Plug 'morhetz/gruvbox'
Plug 'ayu-theme/ayu-vim'
" ------- LSP & Autocomplete ================
Plug 'williamboman/nvim-lsp-installer'
Plug 'rust-lang/rust.vim'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
Plug 'simrat39/rust-tools.nvim'
Plug 'ray-x/lsp_signature.nvim'
" ------- Syntax ============================
Plug 'ziglang/zig.vim'
Plug 'bfrg/vim-cpp-modern'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'frazrepo/vim-rainbow'
" ------- Other =============================
" Plug 'chrisbra/ChangesPlugin'
Plug 'fladson/vim-kitty'
Plug 'ThePrimeagen/vim-be-good'
call plug#end()
" ------- END PLUGINS =======================

let &t_ut=''
syntax enable
set number
set relativenumber
set background=dark
set tabstop=4
set shiftwidth=4
set expandtab
set showcmd
set autoindent
set laststatus=2
set termguicolors
set colorcolumn=101
colorscheme dire

autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" set completeopt=menu,menuone,noselect,noinsert

filetype plugin indent on
" Rust options
let g:rust_recommended_stype = 1
let g:rustfmt_command='/home/nate/.cargo/bin/rustfmt'
let g:rustfmt_autosave = 1
let g:rustfmt_emit_files = 1

au FileType c,cpp call rainbow#load()

lua <<EOF
vim.opt.completeopt = "menu,menuone,noinsert,noselect"

-- Setup cmp
local cmp = require("cmp")
local bufopts = { noremap=true, silent=true, buffer=bufnr}
-- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
cmp.setup({
    mapping = cmp.mapping.preset.insert({
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<Tab>"] = cmp.mapping.select_next_item(),
    }),
    snippet = {
        expand = function(args)
            require("vsnip").lsp_expand(args.body)
        end,
    },
    sources = {
        { name = "nvim_lsp" },
        { name = "vsnip" },
        { name = "path" },
        { name = "nvim-lsp-signature-help" },
    }, {
        { name = "buffer" },
    },
})

-- Setup buffer-local keymaps/options for LSP buffers
local capabilities =
require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
local lsp_attach = function(client, buf)
    vim.api.nvim_buf_set_option(buf, "formatexpr", "v:lua.vim.lsp.formatexpr()")
    vim.api.nvim_buf_set_option(buf, "omnifunc", "v:lua.vim.lsp.omnifunc")
    vim.api.nvim_buf_set_option(buf, "tagfunc", "v:lua.vim.lsp.tagfunc")
    -- Enable completion triggered by <c-x><c-o>

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  --local bufopts = { noremap=true, silent=true, buffer=bufnr }
  --vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  --vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  --vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  --vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  --vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  --vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  --vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  --vim.keymap.set('n', '<space>wl', function()
  --  print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  --end, bufopts)
  --vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  --vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  --vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  --vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  --vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

-- Setup rust_analyzer via rust-tools.nvim
require("rust-tools").setup({
    server = {
        capabilities = capabilities,
        on_attach = lsp_attach,
    },
    inlay_hints = {
        right_align = true,
    },
})

cfg = {
  debug = false, -- set to true to enable debug logging
  log_path = vim.fn.stdpath("cache") .. "/lsp_signature.log", -- log dir when debug is on
  -- default is  ~/.cache/nvim/lsp_signature.log
  verbose = false, -- show debug line number

  bind = true, -- This is mandatory, otherwise border config won't get registered.
               -- If you want to hook lspsaga or other signature handler, pls set to false
  doc_lines = 10, -- will show two lines of comment/doc(if there are more than two lines in doc, will be truncated);
                 -- set to 0 if you DO NOT want any API comments be shown
                 -- This setting only take effect in insert mode, it does not affect signature help in normal
                 -- mode, 10 by default

  max_height = 12, -- max height of signature floating_window
  max_width = 80, -- max_width of signature floating_window
  noice = false, -- set to true if you using noice to render markdown
  wrap = true, -- allow doc/signature text wrap inside floating_window, useful if your lsp return doc/sig is too long
  
  floating_window = true, -- show hint in a floating window, set to false for virtual text only mode

  floating_window_above_cur_line = true, -- try to place the floating above the current line when possible Note:
  -- will set to true when fully tested, set to false will use whichever side has more space
  -- this setting will be helpful if you do not want the PUM and floating win overlap

  floating_window_off_x = 1, -- adjust float windows x position.
  floating_window_off_y = 0, -- adjust float windows y position. e.g -2 move window up 2 lines; 2 move down 2 lines

  close_timeout = 2000, -- close floating window after ms when last parameter is entered
  fix_pos = false,  -- set to true, the floating window will not auto-close until finish all parameters
  hint_enable = true, -- virtual hint enable
  hint_prefix = "--,^^,*> ",
  hint_scheme = "String",
  hi_parameter = "LspSignatureActiveParameter", -- how your parameter will be highlight
  handler_opts = {
    border = "none"   -- double, rounded, single, shadow, none
  },

  always_trigger = true, -- sometime show signature on new line or in middle of parameter can be confusing, set it to false for #58

  auto_close_after = nil, -- autoclose signature float win after x sec, disabled if nil.
  extra_trigger_chars = {}, -- Array of extra characters that will trigger signature completion, e.g., {"(", ","}
  zindex = 200, -- by default it will be on top of all floating windows, set to <= 50 send it to bottom

  padding = '', -- character to pad on left and right of signature can be ' ', or '|'  etc

  transparency = nil, -- disabled by default, allow floating win transparent value 1~100
  shadow_blend = 36, -- if you using shadow as border use this set the opacity
  shadow_guibg = 'Black', -- if you using shadow as border use this set the color e.g. 'Green' or '#121315'
  timer_interval = 200, -- default timer check interval set to lower value if you want to reduce latency
  toggle_key = '<C-k>', -- toggle signature on and off in insert mode,  e.g. toggle_key = '<M-x>'

  select_signature_key = nil, -- cycle to next signature, e.g. '<M-n>' function overloading
  move_cursor_key = nil, -- imap, use nvim_set_current_win to move cursor between current win and floating
}

require("nvim-lsp-installer").setup()

local lspconfig = require('lspconfig')
local servers = { 'clangd', 'zls' }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = lsp_attach,
    capabilities = capabilities,
    require('lsp_signature').setup(cfg, bufnr)
  }
end

require'lsp_signature'.setup(cfg, bufnr) -- no need to specify bufnr if you don't use toggle_key

local sign = function(opts)
    vim.fn.sign_define(opts.name, {
        texthl = opts.name,
        text = opts.text,
        numhl = ''
    })
end

require('lspconfig.ui.windows').default_options = {
    border = _border
}

sign({name = "DiagnosticSignError", text = '\u{2689}'})
sign({name = "DiagnosticSignWarn", text = "\u{2689}"})
sign({name = "DiagnosticSignInfo", text = '\u{2689}'})
sign({name = "DiagnosticSignHint", text = '\u{2687}'})

EOF
