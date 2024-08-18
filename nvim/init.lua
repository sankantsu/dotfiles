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

local environ = vim.loop.os_environ()
local local_plugin_dev = environ["NVIM_LOCAL_PLUGIN_DEV"] and true or false

require("lazy").setup({
    -- basic editing
    "tpope/vim-surround",
    "tpope/vim-commentary",
    "tpope/vim-repeat",
    "junegunn/vim-easy-align",
    -- motions
    "ggandor/leap.nvim",
    -- textobj
    { "kana/vim-textobj-user", dependencies = { "kana/vim-textobj-entire" } },
    -- colorschem
    "EdenEast/nightfox.nvim",
    -- status line
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons", opt = true },
    },
    -- git
    "lewis6991/gitsigns.nvim",
    "sindrets/diffview.nvim",
    {
        "pwntester/octo.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim",
            "nvim-tree/nvim-web-devicons",
        },
        cmd = "Octo",
    },
    -- visual support
    { "lukas-reineke/indent-blankline.nvim" },
    -- autopair
    { "windwp/nvim-autopairs", opts = {} },
    -- filer
    {
        "stevearc/oil.nvim",
        opts = {},
        -- Optional dependencies
        dependencies = { "echasnovski/mini.icons" },
        -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
    },
    -- UI
    {
        "nvim-telescope/telescope.nvim",
        dev = false,
        name = "telescope.nvim",
        branch = "master",
        dependencies = { "nvim-lua/plenary.nvim" },
    },
    { "LukasPietzschmann/telescope-tabs", dependencies = { "telescope.nvim" } },
    { "nvim-telescope/telescope-file-browser.nvim", dependencies = { "telescope.nvim", "nvim-lua/plenary.nvim" } },
    {
        "sankantsu/telescope-zenn.nvim",
        dev = local_plugin_dev,
        dependencies = { "telescope.nvim" },
    },
    {
        "sankantsu/telescope-heading.nvim",
        dev = local_plugin_dev,
        dependencies = { "telescope.nvim" },
    },
    -- 'nvim-telescope/telescope-ui-select.nvim',
    "stevearc/dressing.nvim",
    -- tree-sitter
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
    -- lsp
    "neovim/nvim-lspconfig",
    {
        "williamboman/mason.nvim",
        build = ":MasonUpdate", -- :MasonUpdate updates registry contents
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
    "nvimtools/none-ls.nvim",

    -- language specific
    { "sankantsu/satysfi.nvim", dev = local_plugin_dev },
    "kaarmu/typst.vim",
    -- completion
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/vim-vsnip",
    "hrsh7th/cmp-vsnip",
    "hrsh7th/cmp-emoji",
    "hrsh7th/cmp-nvim-lsp-signature-help",

    -- denops
    "vim-denops/denops.vim",
    -- ddc
    -- conflicts with nvim-cmp
    -- 'Shougo/ddc.vim',
    -- 'Shougo/ddc-ui-native',
    -- 'Shougo/ddc-filter-matcher_head',
    -- 'Shougo/ddc-filter-sorter_rank',
    -- skk
    { "vim-skk/skkeleton", dependencies = { "vim-denops/denops.vim" } },
    { "rinx/cmp-skkeleton", dependencies = { "hrsh7th/nvim-cmp", "vim-skk/skkeleton" } },
    -- migemo search
    "lambdalisue/kensaku.vim",
    "lambdalisue/kensaku-search.vim",
}, { -- lazy config
    dev = {
        path = "~/git",
    },
})

-- colorscheme ----------------------

require("nightfox").setup({
    options = {
        transparent = true,
    },
})
vim.cmd("colorscheme nightfox")

-- options ----------------------

-- line number
vim.opt.number = true
vim.opt.numberwidth = 2

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
vim.opt.clipboard:prepend({ "unnamedplus" })

-- search setting
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- command-line completion
vim.opt.wildmenu = true
vim.opt.wildmode = "list:longest,full"

-- default filetype for *.tex
vim.g.tex_flavor = "latex"

-- accept at character in control word
vim.g.tex_stylish = 1

-- digraphs ----------------------

-- easy to remember digraphs for "あいうえお" and `、。`
vim.cmd([[
digraph aa 12354  "あ
digraph ii 12356  "い
digraph uu 12358  "う
digraph ee 12360  "え
digraph oo 12362  "お
digraph AA 12450  "ア
digraph II 12452  "イ
digraph UU 12454  "ウ
digraph EE 12456  "エ
digraph OO 12458  "オ
digraph xa 12353  "ぁ
digraph xi 12355  "ぃ
digraph xu 12357  "ぅ
digraph xe 12359  "ぇ
digraph xo 12361  "ぉ
digraph xA 12449  "ァ
digraph xI 12451  "ィ
digraph xU 12453  "ゥ
digraph xE 12455  "ェ
digraph xO 12457  "ォ
digraph ,, 12289  "、
digraph .. 12290  "。
]])

-- key mappings ----------------------

-- leader key ----------------------
vim.g.mapleader = ","
vim.g.maplocalleader = "\\"

-- motions
vim.keymap.set({ "n", "x" }, "+", ",")

-- left-right motions
vim.keymap.set({ "n", "x" }, "<space>h", "^")
vim.keymap.set({ "n", "x" }, "<space>l", "$")

-- "f" command with digraphs
vim.keymap.set({ "n", "x", "o" }, "<space>f", "f<C-k>")

-- up-down motions (display-line)
vim.keymap.set({ "n", "v" }, "<C-n>", "gj")
vim.keymap.set({ "n", "v" }, "<C-p>", "gk")

-- page-top page-bottom
-- vim.keymap.set({ "n", "v" }, "H", "H")
-- vim.keymap.set({ "n", "v" }, "L", "L")

-- move aroung buffer list
vim.keymap.set("n", "[b", ":<C-u>bprev<CR>")
vim.keymap.set("n", "]b", ":<C-u>bnext<CR>")

-- move around quickfix list
vim.keymap.set("n", "[c", ":<C-u>cprev<CR>")
vim.keymap.set("n", "]c", ":<C-u>cnext<CR>")

-- move around tab pages
vim.keymap.set("n", "<C-h>", ':<C-u>execute "tabprevious " . v:count1<CR>', { silent = true })
vim.keymap.set("n", "<C-l>", "@=SwitchTab()<CR>", { silent = true })

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

-- close quickfix
vim.keymap.set("n", "<leader>cc", ":cclose<CR>")

-- redraw
vim.keymap.set("n", "<leader>rr", ":redraw!<CR>")

-- reset filetype
vim.keymap.set("n", "<leader>sf", ":call ResetFileType()<CR>")

-- clear screen and stop highlighting
vim.keymap.set("n", "<ESC><ESC>", ":<C-u>nohlsearch<CR><C-l>", { silent = true })

-- migemo search
vim.keymap.set("c", "<CR>", "<Plug>(kensaku-search-replace)<CR>")

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
vim.cmd([[execute "set cedit=\<C-q>"]])

-- emacs style editing
vim.keymap.set("c", "<C-f>", "<Right>")
vim.keymap.set("c", "<C-b>", "<Left>")
vim.keymap.set("c", "<C-a>", "<C-b>")

-- recall command line history
vim.keymap.set("c", "<C-p>", "<Up>")
vim.keymap.set("c", "<C-n>", "<Down>")
vim.keymap.set("c", "<Up>", "<C-p>")
vim.keymap.set("c", "<Down>", "<C-n>")

-- bbreviations ----------------------

-- horizontal line
vim.cmd([[iabbrev #- ----------------------]])

-- Vimscript functions ----------------------

vim.cmd([[
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
]])

-- motions

-- leap ----------------------

require("leap").create_default_mappings()

vim.api.nvim_set_hl(0, "LeapMatch", { fg = "green", bold = true, underline = true, nocombine = true })
require("leap").opts.highlight_unlabeled_phase_one_targets = true

require("leap").opts.equivalence_classes = {
    " \t\r\n",
    "aあア",
    "iいイ",
    "uうウ",
    "eえエ",
    "oおオ",
    "kかきくけこカキクケコ",
    "sさしすせそサシスセソ",
    "tたちつてとタチツテト",
    "nなにぬねのナニヌネノ",
}

-- easy align ----------------------

vim.keymap.set("v", "ga", "<Plug>(EasyAlign)")

-- status line ----------------------

require("lualine").setup({
    sections = {
        lualine_c = {
            "filename",
            {
                "navic",
                color_correction = nil,
                navic_opts = nil,
            },
        },
        lualine_x = { "filetype" },
        lualine_y = {},
    },
    options = {
        section_separators = { left = "", right = "" },
        -- globalstatus = true,
    },
})

-- git ----------------------

-- octo

if vim.fn.executable("gh") == 1 then
    require("octo").setup({
        enable_builtin = true,
    })
end

-- git signs

require("gitsigns").setup({
    on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map("n", "]c", gs.next_hunk)
        map("n", "[c", gs.prev_hunk)

        -- Actions
        map("n", "<leader>hs", gs.stage_hunk)
        map("n", "<leader>hr", gs.reset_hunk)
        map("v", "<leader>hs", function()
            gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end)
        map("v", "<leader>hr", function()
            gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end)
        map("n", "<leader>hp", gs.preview_hunk)
        map("n", "<leader>hb", function()
            gs.blame_line({ full = true })
        end)

        -- Text object
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
    end,
})

-- indent blankline ----------------------

require("ibl").setup({})

-- autopair ----------------------

require("nvim-autopairs").setup({})

-- filer ----------------------

require("oil").setup({
    use_default_keymaps = false,
    keymaps = {
        ["g?"] = "actions.show_help",
        ["<CR>"] = "actions.select",
        ["<C-t>"] = { "actions.select", opts = { tab = true }, desc = "Open the entry in new tab" },
        ["<C-p>"] = "actions.preview",
        ["<C-c>"] = "actions.close",
        ["-"] = "actions.parent",
        ["_"] = "actions.open_cwd",
        ["`"] = "actions.cd",
        ["~"] = { "actions.cd", opts = { scope = "tab" }, desc = ":tcd to the current oil directory" },
        ["gs"] = "actions.change_sort",
        ["gx"] = "actions.open_external",
        ["g."] = "actions.toggle_hidden",
        ["g\\"] = "actions.toggle_trash",
    },
})

-- telescope ----------------------

local telescope = require("telescope")
local builtin = require("telescope.builtin")
local actions = require("telescope.actions")

telescope.setup({
    defaults = {
        -- qflist_previewer = require("telescope.previewers").qflist.new,
        layout_strategy = "vertical",
        layout_config = {
            horizontal = { preview_cutoff = 0 },
            vertical = {
                height = function(_, _, max_lines)
                    return max_lines
                end,
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
            mappings = {
                -- ["n"] = {
                --   ["c"] = { require("telescope").extensions.file_browser.actions.create, nowait = true },
                -- },
            },
        },
        -- ["ui-select"] = {
        --   require("telescope.themes").get_dropdown {}
        -- }
    },
})
require("telescope").load_extension("file_browser")
-- require("telescope").load_extension "ui-select"
-- telescope.load_extension("zenn")
telescope.load_extension("heading")

vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
vim.keymap.set("n", "<leader>fz", telescope.extensions.zenn.article_picker, {})
vim.keymap.set("n", "<leader>fd", telescope.extensions.heading.heading, {})
vim.keymap.set("n", "<leader>ft", require("telescope-tabs").list_tabs, {})

-- language specific

require("satysfi-nvim").setup()

-- treesitter ----------------------

require("nvim-treesitter.configs").setup({
    -- ensure_installed = {
    --   "satysfi",
    -- },
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
})

-- LSP (language server) ----------------------

require("mason").setup({
    registries = {
        "github:sankantsu/satysfi-mason-registry",
        "github:mason-org/mason-registry",
    },
    log_level = vim.log.levels.DEBUG,
})

require("mason-lspconfig").setup({
    -- ensure_installed = { "lua_ls", "satysfi_ls", },
})
require("mason-lspconfig").setup_handlers({
    function(server)
        require("lspconfig")[server].setup({})
    end,
})

-- language specific settings

require("null-ls").setup({
    sources = {
        require("null-ls").builtins.formatting.stylua,
    },
})

-- see: https://minerva.mamansoft.net/Notes/%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB%E3%81%8C%E4%BF%9D%E5%AD%98%E3%81%95%E3%82%8C%E3%81%9F%E3%82%89%E8%87%AA%E5%8B%95%E3%83%95%E3%82%A9%E3%83%BC%E3%83%9E%E3%83%83%E3%83%88+(nvim-lspconfig)
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(event)
        vim.api.nvim_create_autocmd("BufWritePre", {
            pattern = { "*.rs", "*.lua" },
            callback = function()
                vim.lsp.buf.format({
                    buffer = event.buf,
                    async = false,
                })
            end,
        })
    end,
})

-- keyboard shortcut
local attach_lsp_mappings = function()
    local set = function(mode, lhs, rhs)
        vim.keymap.set(mode, lhs, rhs, { buffer = true })
    end
    set("n", "K", vim.lsp.buf.hover)
    set("n", "g=", vim.lsp.buf.format)
    set("n", "gr", vim.lsp.buf.references)
    set("n", "gd", vim.lsp.buf.definition)
    set("n", "gD", vim.lsp.buf.declaration)
    -- set('n', 'gi', vim.lsp.buf.implementation)
    -- set('n', 'gt', vim.lsp.buf.type_definition)
    set("n", "gn", vim.lsp.buf.rename)
    set("n", "ga", vim.lsp.buf.code_action)
    set("n", "ge", vim.diagnostic.open_float)
    set("n", "g]", vim.diagnostic.goto_next)
    set("n", "g[", vim.diagnostic.goto_prev)
end

vim.api.nvim_create_autocmd("LspAttach", {
    desc = "Attach keymappings for LSP functionalities",
    callback = attach_lsp_mappings,
})

-- LSP handlers
-- vim.lsp.handlers["textDocument/definition"] = function (_, result)
--   print(vim.inspect(result))
-- end
vim.lsp.handlers["textDocument/publishDiagnostics"] =
    vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, { virtual_text = false })
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
require("nvim-navic").setup({
    lsp = {
        auto_attach = true,
    },
    highlight = true,
})

require("nvim-navbuddy").setup({
    window = {
        size = { height = "40%", width = "100%" },
        position = { row = "100%", col = "50%" },
    },
    lsp = {
        auto_attach = true,
    },
})

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
        { name = "emoji", option = { insert = true } },
        { name = "skkeleton" },
        { name = "nvim_lsp_signature_help" },
    },
    -- view = {
    --   entries = "native", -- recommended setting of cmp-skkeleton?
    -- },
    mapping = cmp.mapping.preset.insert({
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-l>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<C-f>"] = cmp.mapping.scroll_docs(1),
        ["<C-b>"] = cmp.mapping.scroll_docs(-1),
    }),
    experimental = {
        ghost_text = true,
    },
})

-- skk ----------------------

vim.cmd([[
call skkeleton#config({ 'globalDictionaries': ['~/.skk/SKK-JISYO.L'] })
imap <C-j> <Plug>(skkeleton-enable)
cmap <C-j> <Plug>(skkeleton-enable)

call skkeleton#register_kanatable("rom", {
  \ "ca": ["か"],
  \ "cu": ["く"],
  \ "co": ["こ"],
  \ "xn": ["ん"],
  \ })
]])

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
