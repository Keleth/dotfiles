require'nvim-treesitter.configs'.setup {
	ensure_installed = {'bash', 'cpp', 'java', 'python', 'lua', 'javascript'},
	sync_install = false,
	auto_install = true,
	highlight = {
		enable = true,
	},
}
