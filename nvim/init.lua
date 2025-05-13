require("config.lazy")
require("mini.files").setup()
require("mini.git").setup()
require("catppuccin").setup({
    flavour = "frappe"
})
require("luasnip")

local lsp_conf = require("lspconfig")

lsp_conf.clangd.setup({
    --capabilities = lsp_cap,
    cmd = {"clangd", '--background-index', '--clang-tidy', '--log=verbose'},
    init_options = {
        fallbackFlags = { '-std=c++17' },
    },
})

vim.lsp.enable("clangd")

vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function()
    local bufmap = function(mode, lhs, rhs)
      local opts = {buffer = true}
      vim.keymap.set(mode, lhs, rhs, opts)
    end

    -- Displays hover information about the symbol under the cursor
    bufmap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>')

    -- Jump to the definition
    bufmap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>')

    -- Jump to declaration
    bufmap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>')

    -- Lists all the implementations for the symbol under the cursor
    bufmap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>')

    -- Jumps to the definition of the type symbol
    bufmap('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>')

    -- Lists all the references
    bufmap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>')

    -- Displays a function's signature information
    bufmap('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>')

    -- Renames all references to the symbol under the cursor
    bufmap('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>')

    -- Selects a code action available at the current cursor position
    bufmap('n', '<F3>', '<cmd>lua vim.lsp.buf.code_action()<cr>')

    -- Show diagnostics in a floating window
    bufmap('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')

    -- Move to the previous diagnostic
    bufmap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>')

    -- Move to the next diagnostic
    bufmap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>')
  end
})

local groupID = vim.api.nvim_create_augroup("ZachGroup", {})
vim.api.nvim_clear_autocmds({ group = groupID })

vim.cmd.colorscheme("catppuccin")

vim.g.mapleader = "\\"
vim.keymap.set("n", "<leader>b", function() print("derp") end)
vim.keymap.set("n", "<leader>e", "<Cmd>lua MiniFiles.open() <CR>")

vim.o.smartcase = true
vim.o.ignorecase = true
vim.o.hlsearch = false

vim.b.expandtab = true
vim.bo.expandtab = true
vim.wo.wrap = false
vim.wo.number = true
vim.wo.relativenumber = true

--↵
vim.opt.listchars = { space = '·', eol = '$', tab = '>~' }
vim.opt.list=true

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.git_files, { desc = 'Telescope find files' })
--vim.keymap.set('n', '<leader>fg', builtin.git_files, { desc = 'Telescope live grep' }) --i dont know how this works
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fg', builtin.grep_string, { desc = 'Telescope live grep' })

vim.keymap.set('n', '<F4>', function() 
    if( string.sub(vim.fn.expand('%'),-4,-1) == ".cpp" )
        then
            vim.cmd { cmd = "edit", args = { vim.fn.expand("%<")..".h" } }
        elseif( string.sub(vim.fn.expand('%'),-2,-1) == ".h" )
            then
                vim.cmd { cmd = "edit", args = { vim.fn.expand("%<")..".cpp" } }
            else 
                print("Where are you? moron.")
            end
end )

vim.api.nvim_create_user_command("W", "w", {})
vim.api.nvim_create_user_command("Wq", "wq", {})
vim.api.nvim_create_user_command("WQ", "wq", {})
vim.api.nvim_create_user_command("Wa", "wa", {})
vim.api.nvim_create_user_command("WA", "wa", {})

--vim.cmd('cd %:p:h')
function get_git_root()
    --local dot_git_path2 = vim.fn.finddir(".git", vim.fn.expand("%:p:h"))
    local dot_git_path = vim.fn.finddir(".git", ".;")
    if( dot_git_path == "")
            then
                    dot_git_path = vim.fn.expand("%:p:h")
            end
            --local butts = vim.fn.fnamemodify(dot_git_path, ":p:h")
            --print(dot_git_path.."-=-".."||||"..butts)
            return vim.fn.fnamemodify(dot_git_path, ":p:h:h")
end

vim.api.nvim_create_user_command("CdGitRoot", function()
    vim.api.nvim_set_current_dir(get_git_root())
end , {})


vim.api.nvim_create_autocmd({"BufEnter"}, {
    group = groupID,
    pattern = { "*" },
    callback = function()
            local root = get_git_root()
	    vim.api.nvim_set_current_dir(root)
    end 
})

vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
	group = groupID,
        pattern = { "*.cpp", "*.h" },
        callback = function()
                print("BUFFER ENTER")
                vim.b.tabstop = 4
                vim.b.shiftwidth = 4
                vim.b.expandtab = true
                vim.bo.tabstop = 4
                vim.bo.shiftwidth = 4
                vim.bo.expandtab = true
        end 
})

-- herp().derp()
function its_not_a_pointer_idiot()
    local a = vim.api.nvim_win_get_cursor(0)
    local char = string.sub(vim.api.nvim_get_current_line(), a[2]+1, a[2]+1)
    if( char == "." )
        then
	     local cmd = vim.api.nvim_replace_termcodes('xi-><ESC>', true, false, true)
	    vim.api.nvim_feedkeys( cmd, 'n', true)
    elseif( char == ">" ) 
    then
	    local char2 = string.sub(vim.api.nvim_get_current_line(), a[2], a[2])
	    if( char2 == "-" ) then
		    local cmd = vim.api.nvim_replace_termcodes('xhxi.<ESC>', true, false, true)
		    vim.api.nvim_feedkeys( cmd, 'n', true)
    	end
    elseif( char == "-" ) 
    then
	    local char2 = string.sub(vim.api.nvim_get_current_line(), a[2]+2, a[2]+2)
	    if( char2 == ">" ) then
		    local cmd = vim.api.nvim_replace_termcodes('xxi.<ESC>', true, false, true)
		    vim.api.nvim_feedkeys( cmd, 'n', true)
    	end
    else 
                print("Non Supported, IDIDOTH")
end
    end

vim.keymap.set('n', '<leader>`', its_not_a_pointer_idiot, { desc = 'perform obvious common swap on operator' })

vim.keymap.set('n', '<leader>r', "<CMD>source %<CR>", { desc = 'reload' })

vim.opt.completeopt = {'menu', 'menuone', 'noselect'}

require('luasnip.loaders.from_vscode').lazy_load()

local cmp = require('cmp')
local luasnip = require('luasnip')

local select_opts = {behavior = cmp.SelectBehavior.Select}

vim.o.signcolumn = "yes:1"

--auto complete setup
cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end
  },
  sources = {
    {name = 'path'},
    {name = 'nvim_lsp', keyword_length = 1},
    {name = 'buffer', keyword_length = 3},
    {name = 'luasnip', keyword_length = 2},
  },
  window = {
    documentation = cmp.config.window.bordered()
  },
  formatting = {
    fields = {'menu', 'abbr', 'kind'},
    format = function(entry, item)
      local menu_icon = {
        nvim_lsp = 'λ',
        luasnip = '⋗',
        buffer = 'Ω',
        path = '🖫',
      }

      item.menu = menu_icon[entry.source.name]
      return item
    end,
  },
  mapping = {
    ['<Up>'] = cmp.mapping.select_prev_item(select_opts),
    ['<Down>'] = cmp.mapping.select_next_item(select_opts),

    ['<C-p>'] = cmp.mapping.select_prev_item(select_opts),
    ['<C-n>'] = cmp.mapping.select_next_item(select_opts),

    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),

    ['<C-e>'] = cmp.mapping.abort(),
    ['<C-y>'] = cmp.mapping.confirm({select = true}),
    ['<CR>'] = cmp.mapping.confirm({select = false}),

    ['<C-f>'] = cmp.mapping(function(fallback)
      if luasnip.jumpable(1) then
        luasnip.jump(1)
      else
        fallback()
      end
    end, {'i', 's'}),

    ['<C-b>'] = cmp.mapping(function(fallback)
      if luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, {'i', 's'}),

    ['<Tab>'] = cmp.mapping(function(fallback)
      local col = vim.fn.col('.') - 1

      if cmp.visible() then
        cmp.select_next_item(select_opts)
      elseif col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        fallback()
      else
        cmp.complete()
      end
    end, {'i', 's'}),

    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item(select_opts)
      else
        fallback()
      end
    end, {'i', 's'}),
  },
})

