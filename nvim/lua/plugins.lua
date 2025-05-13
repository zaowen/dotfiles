return {
	--colors
	{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },
	--general file picker
	{ 'echasnovski/mini.nvim', version = '*'},
	--git project file picker
	{
		'nvim-telescope/telescope.nvim', tag = '0.1.8',
		dependencies = { 'nvim-lua/plenary.nvim', }
	},
	--highlighting
	{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate", enabled = true},
	--all of this is for error reporting and auto complete
	{"neovim/nvim-lspconfig" },
	{"hrsh7th/nvim-cmp" },
	{"hrsh7th/cmp-nvim-lsp" },
	{"L3MON4D3/luasnip" },
}
