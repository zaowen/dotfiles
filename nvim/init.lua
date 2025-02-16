require("config.lazy")
require("mini.files").setup()
require("mini.git").setup()
require("catppuccin").setup({
    flavour = "frappe"
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


