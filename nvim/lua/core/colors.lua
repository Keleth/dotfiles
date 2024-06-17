vim.opt.termguicolors = true

function SetColor(color) 
	color = color or "catppuccin-latte"
	vim.cmd.colorscheme(color)

--	vim.api.nvim_set_hl(0, "Normal", {bg = "#cccccc"})
--	vim.api.nvim_set_hl(0, "LineNr", {bg = "none"})
end

SetColor()

