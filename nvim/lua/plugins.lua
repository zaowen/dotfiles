return {
	{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },
	{ 'echasnovski/mini.nvim', version = false },
	{
		'nvim-telescope/telescope.nvim', tag = '0.1.8',
		dependencies = { 'nvim-lua/plenary.nvim' }
	},
	{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate", enabled = true},
	{
		"neovim/nvim-lspconfig", -- REQUIRED: for native Neovim LSP integration
		lazy = false, -- REQUIRED: tell lazy.nvim to start this plugin at startup
		dependencies = {
			-- main one
			{ "ms-jpq/coq_nvim", branch = "coq" },

			-- 9000+ Snippets
			{ "ms-jpq/coq.artifacts", branch = "artifacts" },

			-- lua & third party sources -- See https://github.com/ms-jpq/coq.thirdparty
			-- Need to **configure separately**
			{ 'ms-jpq/coq.thirdparty', branch = "3p" }
			-- - shell repl
			-- - nvim lua api
			-- - scientific calculator
			-- - comment banner
			-- - etc
		},
		init = function()
			vim.g.coq_settings = {
				auto_start = true, -- if you want to start COQ at startup
				-- Your COQ settings here
			}
		end,
		config = function()
			-- Your LSP settings here
		end,
	}
}
