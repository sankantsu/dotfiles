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
  -- colorschem
  "EdenEast/nightfox.nvim",
  -- status line
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons', opt = true }
  },
  -- visual support
  { "lukas-reineke/indent-blankline.nvim" },
  -- UI
  { "nvim-telescope/telescope.nvim", dev = false, name = "telescope.nvim", branch = "master", dependencies = { "nvim-lua/plenary.nvim" } },
  { "LukasPietzschmann/telescope-tabs", dependencies = { "telescope.nvim" } },
  { "nvim-telescope/telescope-file-browser.nvim", dependencies = { "telescope.nvim", "nvim-lua/plenary.nvim" } },
  { "sankantsu/telescope-zenn.nvim", dev = true, dependencies = { "telescope.nvim", } },
  { dir = "~/git/telescope-heading.nvim", dev = true, dependencies = { "telescope.nvim" } },
  -- 'nvim-telescope/telescope-ui-select.nvim',
  'stevearc/dressing.nvim',
  -- tree-sitter
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},
  -- 'nvim-treesitter/playground',
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
    dev = false,
    dependencies = {
      "neovim/nvim-lspconfig",
      "SmiteshP/nvim-navic",
      "MunifTanjim/nui.nvim",
      -- "numToStr/Comment.nvim",        -- Optional
      "telescope.nvim", -- Optional
    },
  },
  -- "nvimdev/lspsaga.nvim",
  -- completion
  "hrsh7th/nvim-cmp",
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/vim-vsnip",
  "hrsh7th/cmp-vsnip",
  "hrsh7th/cmp-emoji",
  -- denops
  'vim-denops/denops.vim',
  -- ddc
  -- conflicts with nvim-cmp
  -- 'Shougo/ddc.vim',
  -- 'Shougo/ddc-ui-native',
  -- 'Shougo/ddc-filter-matcher_head',
  -- 'Shougo/ddc-filter-sorter_rank',
  -- skk
  { 'vim-skk/skkeleton', dependencies = { "vim-denops/denops.vim" }, },
  { 'rinx/cmp-skkeleton', dependencies = { 'hrsh7th/nvim-cmp', 'vim-skk/skkeleton' }, },
}, { -- lazy config
  dev = {
    path = "~/git",
  }
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

-- close quickfix
vim.keymap.set("n", "<leader>cc", ":cclose<CR>")

-- redraw
vim.keymap.set("n", "<leader>rr", ":redraw!<CR>")

-- reset filetype
vim.keymap.set("n", "<leader>sf", ":call ResetFileType()<CR>")

-- clear screen and stop highlighting
vim.keymap.set("n", "<ESC><ESC>", ":<C-u>nohlsearch<CR><C-l>", { silent = true })

-- get ascii value
vim.keymap.set("n", "<leader>ga", "ga")

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
" function! FoldColumnToggle()
"     if &foldcolumn
" 	setlocal foldcolumn=0
"     else
" 	setlocal foldcolumn=3
"     endif
" endfunction

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
    lualine_x = { "filetype", },
    lualine_y = { },
  },
  options = {
    section_separators = { left = "", right = "" },
    -- globalstatus = true,
  },
})

-- indent blankline

require("ibl").setup { }

-- telescope ----------------------

local telescope = require('telescope')
local builtin = require('telescope.builtin')
local actions = require "telescope.actions"

telescope.setup({
  defaults = {
    -- qflist_previewer = require("telescope.previewers").qflist.new,
    layout_strategy = "vertical",
    layout_config = {
      horizontal = { preview_cutoff = 0 },
      vertical = {
        height = function(_, _, max_lines) return max_lines end,
        preview_cutoff = 0,
        preview_height = 8,
        -- scroll_speed = 1,
      },
    },
    preview = {
      ls_short = true,
    },
    mappings = {
      n = {
        ["<esc>"] = false,
        ["q"] = actions.close,

        ["<C-d>"] = actions.results_scrolling_down,
        ["<C-u>"] = actions.results_scrolling_up,

        ["<C-h>"] = actions.preview_scrolling_left,
        ["<C-j>"] = actions.preview_scrolling_down,
        ["<C-k>"] = actions.preview_scrolling_up,
        ["<C-l>"] = actions.preview_scrolling_right,

        ["P"] = actions.cycle_previewers_next,
      },
    },
  },
  pickers = {
    help_tags = {
      -- previewer = require("config.buffer_previewer").heading_previewer(),
    },
  },
  extensions = {
    heading = {
      picker_opts = {
        sorting_strategy = "ascending",
        use_section_number = true,
        previewer = require("config.buffer_previewer").heading_previewer(),
      },
    },
    zenn = {
      -- slug_display_length = 10,
    },
    file_browser = {
      depth = 2,
      -- display_stat = false,
    },
    -- ["ui-select"] = {
    --   require("telescope.themes").get_dropdown {}
    -- }
  },
})
require("telescope").load_extension "file_browser"
-- require("telescope").load_extension "ui-select"
-- telescope.load_extension("zenn")
telescope.load_extension("heading")

vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
-- vim.keymap.set('n', '<leader>ff', telescope.extensions.file_browser.file_browser, { noremap = true })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>fz', telescope.extensions.zenn.article_picker, {})
vim.keymap.set('n', '<leader>fd', telescope.extensions.heading.heading, {})
vim.keymap.set('n', '<leader>ft', require("telescope-tabs").list_tabs, {})

-- treesitter

require("nvim-treesitter.configs").setup {
  highlight = {
    enable = true,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gs",
      node_incremental = "gs",
      scope_incremental = "gS",
      node_decremental = "gm",
    },
  },
  indent = {
    enable = true,
  },
}

-- LSP (language server)

require("mason").setup()
require('mason-lspconfig').setup_handlers({ function(server)
  require('lspconfig')[server].setup {}
end })

-- keyboard shortcut
local attach_lsp_mappings = function ()
  local set = function(mode, lhs, rhs)
    vim.keymap.set(mode, lhs, rhs, { buffer = true })
  end
  set('n', 'K',  '<cmd>:lua vim.lsp.buf.hover()<CR>')
  set('n', 'g=', '<cmd>:lua vim.lsp.buf.format()<CR>')
  set('n', 'gr', '<cmd>:lua vim.lsp.buf.references()<CR>')
  set('n', 'gd', '<cmd>:lua vim.lsp.buf.definition()<CR>')
  set('n', 'gD', '<cmd>:lua vim.lsp.buf.declaration()<CR>')
  -- set('n', 'gi', '<cmd>:lua vim.lsp.buf.implementation()<CR>')
  -- set('n', 'gt', '<cmd>:lua vim.lsp.buf.type_definition()<CR>')
  set('n', 'gn', '<cmd>:lua vim.lsp.buf.rename()<CR>')
  set('n', 'ga', '<cmd>:lua vim.lsp.buf.code_action()<CR>')
  set('n', 'ge', '<cmd>:lua vim.diagnostic.open_float()<CR>')
  set('n', 'g]', '<cmd>:lua vim.diagnostic.goto_next()<CR>')
  set('n', 'g[', '<cmd>:lua vim.diagnostic.goto_prev()<CR>')
end

vim.api.nvim_create_autocmd("LspAttach", {
  desc = "Attach keymappings for LSP functionalities",
  callback = attach_lsp_mappings,
})

-- LSP handlers
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, { virtual_text = false }
)
-- Reference highlight
-- vim.cmd [[
-- set updatetime=500
-- highlight LspReferenceText  cterm=underline ctermfg=1 ctermbg=8 gui=underline guifg=#A00000 guibg=#104040
-- highlight LspReferenceRead  cterm=underline ctermfg=1 ctermbg=8 gui=underline guifg=#A00000 guibg=#104040
-- highlight LspReferenceWrite cterm=underline ctermfg=1 ctermbg=8 gui=underline guifg=#A00000 guibg=#104040
-- augroup lsp_document_highlight
--   autocmd!
--   autocmd CursorHold,CursorHoldI * lua vim.lsp.buf.document_highlight()
--   autocmd CursorMoved,CursorMovedI * lua vim.lsp.buf.clear_references()
-- augroup END
-- ]]

-- require("lspsaga").setup()

-- breadcrumb
require('nvim-navic').setup {
  lsp = {
    auto_attach = true,
  },
  highlight = true,
}

require('nvim-navbuddy').setup {
  window = {
    size = { height = "40%", width = "100%" },
    position = { row = "100%", col = "50%" },
  },
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
    { name = "emoji", option = { insert = true }, },
    { name = "skkeleton" },
  },
  -- view = {
  --   entries = "native", -- recommended setting of cmp-skkeleton?
  -- },
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

-- skk

vim.cmd [[
call skkeleton#config({ 'globalJisyo': '~/.skk/SKK-JISYO.L' })
imap <C-j> <Plug>(skkeleton-enable)
cmap <C-j> <Plug>(skkeleton-enable)

call skkeleton#register_kanatable("rom", {
  \ "ca": ["か"],
  \ "cu": ["く"],
  \ "co": ["こ"],
  \ "xn": ["ん"],
  \ })
]]

-- ddc configuration for skkeleton
-- vim.cmd [[
-- call ddc#custom#patch_global('ui', 'native')
-- call ddc#custom#patch_global('sources', ['skkeleton'])
-- call ddc#custom#patch_global('sourceOptions', {
--     \   '_': {
--     \     'matchers': ['matcher_head'],
--     \     'sorters': ['sorter_rank']
--     \   },
--     \   'skkeleton': {
--     \     'mark': 'skkeleton',
--     \     'matchers': ['skkeleton'],
--     \     'sorters': [],
--     \     'minAutoCompleteLength': 2,
--     \     'isVolatile': v:true,
--     \   },
--     \ })
-- call ddc#enable()
-- ]]
