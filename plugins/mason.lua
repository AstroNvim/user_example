-- customize mason plugins
---@type LazySpec
local plugins = {
	{
		"williamboman/mason-lspconfig.nvim",
		---@param opts MasonLspconfigSettings
		opts = function(_, opts)
			---@diagnostic disable-next-line
			opts.ensure_installed =
				require("astronvim.utils").list_insert_unique(
					opts.ensure_installed,
					{
						-- "lua_ls",
					}
				)
		end,
	},
	{
		"jay-babu/mason-null-ls.nvim",
		---@param opts MasonNullLsSettings
		opts = function(_, opts)
			opts.ensure_installed =
				require("astronvim.utils").list_insert_unique(
					opts.ensure_installed,
					{
						-- "prettier",
						-- "stylua",
					}
				)
		end,
	},
	{
		"jay-babu/mason-nvim-dap.nvim",
		---@param opts MasonNvimDapSettings
		opts = function(_, opts)
			opts.ensure_installed =
				require("astronvim.utils").list_insert_unique(
					opts.ensure_installed,
					{
						-- "python",
					}
				)
		end,
	},
}
return plugins
