---@type LazySpec
local plugins = {
	"nvim-treesitter/nvim-treesitter",
	---@param opts TSConfig
	opts = function(_, opts)
		opts.ensure_installed = require("astronvim.utils").list_insert_unique(
			---@diagnostic disable-next-line
			opts.ensure_installed,
			{
				"make",
				"gitignore",
				"git_config",
				"passwd",
				"rasi",
				"scss",
			}
		)
	end,
}
return plugins
