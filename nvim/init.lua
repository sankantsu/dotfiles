local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.runtimepath:prepend(lazypath)

require("lazy").setup({
  -- basic editing
  "tpope/vim-surround",
  "tpope/vim-commentary",
  "tpope/vim-repeat",
  "junegunn/vim-easy-align",
  -- textobj
  { "kana/vim-textobj-user", dependencies = { "kana/vim-textobj-entire" } },
  -- markdown syntax
  "preservim/vim-markdown",
  -- colorschem
  "EdenEast/nightfox.nvim",
  -- status line
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons', opt = true }
  },
  -- visual support
  { "lukas-reineke/indent-blankline.nvim" },
  -- fuzzy finder
  { 'nvim-telescope/telescope.nvim', branch = 'master', dependencies = { 'nvim-lua/plenary.nvim' } },
  -- { "nvim-telescope/telescope-file-browser.nvim", dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" } },
  { "sankantsu/telescope-zenn.nvim", dependencies = { "nvim-telescope/telescope.nvim", } },
  { 'crispgm/telescope-heading.nvim', dependencies = { 'nvim-telescope/telescope.nvim' } },
  -- tree-sitter
  {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},
  -- lsp
  "neovim/nvim-lspconfig",
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate" -- :MasonUpdate updates registry contents
  },
  "williamboman/mason-lspconfig.nvim",
  { "SmiteshP/nvim-navic", dependencies = "neovim/nvim-lspconfig" },
  {
    "SmiteshP/nvim-navbuddy",
    dependencies = {
      "neovim/nvim-lspconfig",
      "SmiteshP/nvim-navic",
      "MunifTanjim/nui.nvim",
      -- "numToStr/Comment.nvim",        -- Optional
      "nvim-telescope/telescope.nvim" -- Optional
    },
  },
  -- completion
  "hrsh7th/nvim-cmp",
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/vim-vsnip",
  "hrsh7th/cmp-vsnip",
  "hrsh7th/cmp-emoji",
})

-- line number
vim.opt.number = true
vim.opt.numberwidth = 2

-- status line setting
-- vim.opt.laststatus = 2
-- vim.opt.statusline = "%f\ %y\ %m\ %=\ %l,%c/%L"

-- display last line as much as possible (do not replace to '@')
-- vim.opt.display:append { "lastline" }

-- show bracket match
vim.opt.showmatch = true
vim.opt.matchtime = 2

-- allow backspacing over autoindent, line breaks, and start of insertiton
vim.opt.backspace = "indent,eol,start"

-- indent, tab
vim.opt.autoindent = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 8
vim.opt.softtabstop = 2
vim.opt.smarttab = true
vim.opt.expandtab = true

-- always use system clipboard
vim.opt.clipboard:prepend { "unnamedplus" }

-- search setting
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- command-line completion
vim.opt.wildmenu = true
vim.opt.wildmode = "list:longest,full"

-- toggle paste mode
vim.opt.pastetoggle = "<F12>"

-- default filetype for *.tex
vim.g.tex_flavor = "latex"

-- accept at character in control word
vim.g.tex_stylish = 1

-- key mappings ----------------------

-- leader key ----------------------
vim.g.mapleader = ","
vim.g.maplocalleader = "\\"

vim.keymap.set("n", "+", ",")

-- left-right motions
vim.keymap.set({"n", "v"}, "H", "^")
vim.keymap.set({"n", "v"}, "L", "$")

-- up-down motions
vim.keymap.set("n", "<C-n>", "gj")
vim.keymap.set("n", "<C-p>", "gk")

-- other motions
vim.keymap.set("n", "<C-h>", "H")
vim.keymap.set("n", "<C-l>", "L")

-- move aroung buffer list
vim.keymap.set("n", "[b", ":<C-u>bprev<CR>")
vim.keymap.set("n", "]b", ":<C-u>bnext<CR>")

-- move around quickfix list
vim.keymap.set("n", "[c", ":<C-u>cprev<CR>")
vim.keymap.set("n", "]c", ":<C-u>cnext<CR>")

-- move around tab pages
vim.keymap.set("n", "[t", ':<C-u>execute "tabprevious " . v:count1<CR>', { silent = true })
vim.keymap.set("n", "]t", "@=SwitchTab()<CR>", { silent = true })

-- make & command to remember flags
vim.keymap.set("n", "&", ":&&<CR>")
vim.keymap.set("x", "&", ":&&<CR>")

-- normal mode ----------------------

-- disable rarely used 2line deletion
vim.keymap.set("n", "dj", "<nop>")
vim.keymap.set("n", "dk", "<nop>")

-- don't use register when delete a character
vim.keymap.set("n", "x", '"_x')

-- yank until the end of the line
vim.keymap.set("n", "Y", "y$")

-- Delete current line except line break
vim.keymap.set("n", "<Leader>d", "0D")

-- toggle fold column
-- vim.keymap.set("n", "<leader>f", ":call FoldColumnToggle()<CR>")

-- redraw
vim.keymap.set("n", "<leader>rr", ":redraw!<CR>")

-- reset filetype
vim.keymap.set("n", "<leader>sf", ":call ResetFileType()<CR>")

-- clear screen and stop highlighting
vim.keymap.set("n", "<ESC><ESC>", ":<C-u>nohlsearch<CR><C-l>", { silent = true })

-- insert mode ----------------------

-- move forward/backword (emacs style)
vim.keymap.set("i", "<C-f>", "<Right>")
vim.keymap.set("i", "<C-b>", "<Left>")

-- insert expression
vim.keymap.set("i", "<C-g><C-e>", "<C-r>=")

-- break undo sequence when inserting new line
vim.keymap.set("i", "<CR>", "<C-g>u<CR>")

-- command line mode ----------------------

-- invoke command line window
vim.cmd [[execute "set cedit=\<C-q>"]]

-- emacs style editing
vim.keymap.set("c", "<C-f>", "<Right>")
vim.keymap.set("c", "<C-b>", "<Left>")
vim.keymap.set("c", "<C-a>", "<C-b>")

-- recall command line history
vim.keymap.set("c", "<C-p>", "<Up>")
vim.keymap.set("c", "<C-n>", "<Down>")
vim.keymap.set("c", "<Up>", "<C-p>")
vim.keymap.set("c", "<Down>", "<C-n>")

-- abbreviations ----------------------

-- horizontal line
vim.cmd [[iabbrev #- ----------------------]]

-- Vimscript functions ----------------------

vim.cmd [[
function! FoldColumnToggle()
    if &foldcolumn
	setlocal foldcolumn=0
    else
	setlocal foldcolumn=3
    endif
endfunction

function! ResetFileType()
    let ft = &filetype
    execute "set filetype=" . ft
endfunction

function! SwitchTab()
    " when current tabpage is last tabpage, switch to first tab
    if tabpagenr() == tabpagenr('$')
        tabfirst
    else
        tabnext
    endif
endfunction
]]

-- easy align ----------------------

vim.keymap.set("v", "ga", "<Plug>(EasyAlign)")

-- colorscheme ----------------------

require("nightfox").setup({
    options = {
        transparent = true,
    }
})
vim.cmd("colorscheme nightfox")

-- status line ----------------------

require("lualine").setup({
  sections = {
    lualine_c = {
      "filename",
      {
        "navic",
        color_correction = nil,
        navic_opts = nil
      },
    },
  },
  options = {
    section_separators = { left = "", right = "" },
  },
})

-- visual support ----------------------

require("indent_blankline").setup {
  -- for example, context is off by default, use this to turn it on
  show_current_context = true,
  show_current_context_start = true,
}

-- telescope ----------------------

local telescope = require('telescope')
local builtin = require('telescope.builtin')
local actions = require "telescope.actions"

telescope.setup({
  defaults = {
    layout_config = {
      horizontal = { preview_cutoff = 0 },
    },
    preview = {
      ls_short = true,
    },
    mappings = {
      n = {
        ["<esc>"] = false,
        ["q"] = actions.close,
        ["<C-u>"] = actions.results_scrolling_up,
        ["<C-d>"] = actions.results_scrolling_down,

        ["<PageUp>"] = actions.preview_scrolling_up,
        ["<PageDown>"] = actions.preview_scrolling_down,

        ["P"] = actions.cycle_previewers_next,
      },
    },
  },
  extensions = {
    heading = {
      picker_opts = {
        sorting_strategy = "ascending",
      },
    },
    zenn = {
      -- slug_display_length = 10,
    },
    -- file_browser = {
    --   depth = 2,
    --   display_stat = false,
    -- },
  },
})
-- require("telescope").load_extension "file_browser"
-- telescope.load_extension("zenn")
telescope.load_extension("heading")

vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
-- vim.keymap.set('n', '<leader>ff', telescope.extensions.file_browser.file_browser, { noremap = true })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>fz', telescope.extensions.zenn.article_picker, {})
vim.keymap.set('n', '<leader>fd', telescope.extensions.heading.heading, {})

-- LSP (language server)

require("mason").setup()
require('mason-lspconfig').setup_handlers({ function(server)
  local capabilities = require("cmp_nvim_lsp").default_capabilities()
  require('lspconfig')[server].setup(capabilities)
end })

-- keyboard shortcut
vim.keymap.set('n', 'K',  '<cmd>lua vim.lsp.buf.hover()<CR>')
vim.keymap.set('n', 'gf', '<cmd>lua vim.lsp.buf.formatting()<CR>')
vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
vim.keymap.set('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
vim.keymap.set('n', 'gn', '<cmd>lua vim.lsp.buf.rename()<CR>')
vim.keymap.set('n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<CR>')
vim.keymap.set('n', 'ge', '<cmd>lua vim.diagnostic.open_float()<CR>')
vim.keymap.set('n', 'g]', '<cmd>lua vim.diagnostic.goto_next()<CR>')
vim.keymap.set('n', 'g[', '<cmd>lua vim.diagnostic.goto_prev()<CR>')

-- LSP handlers
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, { virtual_text = false }
)
-- Reference highlight
vim.cmd [[
set updatetime=500
highlight LspReferenceText  cterm=underline ctermfg=1 ctermbg=8 gui=underline guifg=#A00000 guibg=#104040
highlight LspReferenceRead  cterm=underline ctermfg=1 ctermbg=8 gui=underline guifg=#A00000 guibg=#104040
highlight LspReferenceWrite cterm=underline ctermfg=1 ctermbg=8 gui=underline guifg=#A00000 guibg=#104040
augroup lsp_document_highlight
  autocmd!
  autocmd CursorHold,CursorHoldI * lua vim.lsp.buf.document_highlight()
  autocmd CursorMoved,CursorMovedI * lua vim.lsp.buf.clear_references()
augroup END
]]

-- breadcrumb
require('nvim-navic').setup {
  lsp = {
    auto_attach = true,
  },
  highlight = true,
}

require('nvim-navbuddy').setup {
  lsp = {
    auto_attach = true,
  },
}

-- completion
local cmp = require("cmp")
cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  sources = {
    { name = "nvim_lsp" },
    -- { name = "buffer" },
    -- { name = "path" },
    { name = "emoji" , option = { insert = true }, },
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ['<C-l>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm { select = true },
  }),
  experimental = {
    ghost_text = true,
  },
})
