local icons = require("user.icons")
local is_tty = require("user.utils.helper").is_tty

---@type LazySpec
local plugins = {
	{ "max397574/better-escape.nvim", enabled = false },

	-- replacing null-ls with none-ls
	{ "jose-elias-alvarez/null-ls.nvim", enabled = false },
	{
		-- source: https://github.com/AstroNvim/AstroNvim/blob/271c9c3f71c2e315cb16c31276dec81ddca6a5a6/lua/plugins/lsp.lua#L57-L68
		"nvimtools/none-ls.nvim",
		dependencies = {
			{
				"jay-babu/mason-null-ls.nvim",
				cmd = { "NullLsInstall", "NullLsUninstall" },
				opts = { handlers = {} },
			},
		},
		event = "User AstroFile",
		opts = function()
			return { on_attach = require("astronvim.utils.lsp").on_attach }
		end,
	},

	{
		"goolord/alpha-nvim",
		opts = function(_, opts)
			-- customize the dashboard header
			opts.section.header.val = {
				" █████  ███████ ████████ ██████   ██████",
				"██   ██ ██         ██    ██   ██ ██    ██",
				"███████ ███████    ██    ██████  ██    ██",
				"██   ██      ██    ██    ██   ██ ██    ██",
				"██   ██ ███████    ██    ██   ██  ██████",
				" ",
				"    ███    ██ ██    ██ ██ ███    ███",
				"    ████   ██ ██    ██ ██ ████  ████",
				"    ██ ██  ██ ██    ██ ██ ██ ████ ██",
				"    ██  ██ ██  ██  ██  ██ ██  ██  ██",
				"    ██   ████   ████   ██ ██      ██",
			}

			local astro_alpha_button = require("astronvim.utils").alpha_button

			---@param keybind string
			---@param icon string
			---@param title string
			local button = function(keybind, icon, title)
				icon = is_tty() and "*" or icon
				return astro_alpha_button(keybind, icon .. title)
			end

			opts.section.buttons.val = {
				button("LDR S l", "", "  Last Session  "),
				button("LDR f o", "󰈙", "  Recents  "),
				button("LDR S f", "", "  Find Recent sessions"),
				button("LDR f p", "", "  Open Project  "),
				button("LDR p c", "", "  Config  "),
			}

			return opts
		end,
	},
	{
		"nvim-treesitter",
		---@type TSConfig
		---@diagnostic disable-next-line
		opts = {
			incremental_selection = {
				enable = true,
				keymaps = {
					node_incremental = "v",
					node_decremental = "V",
				},
			},
		},
	},
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"LinArcX/telescope-env.nvim",
		},
		opts = function()
			require("telescope").load_extension("env")
			return {
				defaults = {
					layout_config = {
						horizontal = {
							prompt_position = "bottom",
						},
					},
				},
			}
		end,
	},
	-- TEST: buffer completion doesnt work on all files? need to test later.
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-emoji",
			"hrsh7th/cmp-calc",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-cmdline",
			"lukas-reineke/cmp-under-comparator",
			"chrisgrieser/cmp-nerdfont",
		},
		opts = function(_, opts)
			local cmp = require("cmp")
			local lspkind_status_ok, lspkind = pcall(require, "lspkind")

			---@type cmp.ConfigSchema
			local config = {
				window = {
					documentation = {
						max_width = 60,
					},
				},
				sources = cmp.config.sources({
					{ name = "nvim_lsp", priority = 1000 },
					{ name = "nvim_lua", priority = 900 },
					{
						-- NOTE: only through codeium.nvim, the native plugin for neovim
						name = "codeium",
						priority = 800,
					},
					{ -- credits: https://github.com/catgoose/nvim/blob/279618115977b652eff339d627eeab3c616347a2/lua/plugins/cmp.lua#L70-L78
						name = "luasnip",
						group_index = 1,
						option = { use_show_condition = false },
						entry_filter = function()
							local context = require("cmp.config.context")
							return not context.in_treesitter_capture(
									"string"
								)
								and not context.in_syntax_group("String")
								and not context.in_treesitter_capture("comment")
								and not context.in_syntax_group("Comment")
						end,
						priority = 500,
					},
					{ name = "emoji", priority = 400 },
					{ name = "nerdfont", priority = 350 },
					{ name = "path", priority = 250 },
					{ name = "calc", priority = 100 },
					{ name = "buffer", keyword_length = 2 },
				}),
				formatting = {
					expandable_indicator = true,
					fields = {
						"kind",
						"abbr",
						"menu",
					},
					format = lspkind_status_ok
							and lspkind.cmp_format({
								mode = "symbol",
								maxwidth = 50,
								ellipsis_char = "...",
								symbol_map = {
									-- NOTE: only through codeium.nvim, the native plugin for neovim
									-- Codeium = "",
								},
							})
						or nil,
					sorting = {},
					priority_weight = 1,
					comparators = {
						cmp.config.compare.offset,
						cmp.config.compare.exact,
						cmp.config.compare.score,
						cmp.config.compare.recently_used,
						require("cmp-under-comparator").under,
						cmp.config.compare.locality,
						cmp.config.compare.kind,
						cmp.config.compare.sort_text,
						cmp.config.compare.length,
						cmp.config.compare.order,
					},
					-- performance = {
					--   max_view_entries = 50,
					-- },
				},
				experimental = {
					ghost_text = false,
				},
			}

			return require("astronvim.utils").extend_tbl(opts, config)
		end,
		---@param opts cmp.ConfigSchema
		config = function(_, opts)
			require("cmp").setup(opts)

			local cmp = require("cmp")

			cmp.setup.cmdline({ "/", "?" }, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" },
				},
			})

			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" },
				}, {
					{ name = "cmdline" },
				}),
			})
		end,
	},
	{
		"L3MON4D3/LuaSnip",
		dependencies = {
			"honza/vim-snippets",
		},
	},
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			{ "theHamsta/nvim-dap-virtual-text", config = true },
		},
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		opts = {
			default_component_configs = {
				indent = {
					with_expanders = true,
					expander_collapsed = icons.expander_collapsed,
					expander_expanded = icons.expander_expanded,
					expander_highlight = "NeoTreeExpander",
				},
			},
			filesystem = {
				filtered_items = {
					always_show = {
						".config",
						".zshrc",
						".env.zsh",
						".zshenv",
						".gitignore",
					},
				},
			},
		},
	},
	{
		"lewis6991/gitsigns.nvim",
		opts = {
			current_line_blame = true,
			current_line_blame_opts = { ignore_whitespace = true },
		},
	},
	{
		"kevinhwang91/nvim-ufo",
		cond = not vim.g.vscode,
		---@param opts UfoConfig
		opts = function(_, opts)
			-- credits: https://github.com/kevinhwang91/nvim-ufo/issues/150
			-- NOTE: this can also easily break and the fold level doesnt limit till the max nested of folds
			do
				-- Ensure our ufo foldlevel is set for the buffer
				vim.api.nvim_create_autocmd("BufReadPre", {
					callback = function()
						vim.b["ufo_foldlevel"] = 0
					end,
				})

				---@param num integer Set the fold level to this number
				local set_buf_foldlevel = function(num)
					vim.b["ufo_foldlevel"] = num
					require("ufo").closeFoldsWith(num)
				end

				---@param num integer The amount to change the UFO fold level by
				local change_buf_foldlevel_by = function(num)
					local foldlevel = vim.b["ufo_foldlevel"] or 0
					-- Ensure the foldlevel can't be set negatively
					if foldlevel + num >= 0 then
						foldlevel = foldlevel + num
					else
						foldlevel = 0
					end
					set_buf_foldlevel(foldlevel)
				end

				require("astronvim.utils").set_mappings({
					n = {
						["zm"] = {
							function()
								local count = vim.v.count
								if count == 0 then count = 1 end
								change_buf_foldlevel_by(-count)
							end,
							desc = "fold more",
						},
						["zr"] = {
							function()
								local count = vim.v.count
								if count == 0 then count = 1 end
								change_buf_foldlevel_by(count)
							end,
							desc = "Fold less",
						},
						["zS"] = {
							function()
								if vim.v.count == 0 then
									vim.notify(
										"No foldlevel given to set!",
										vim.log.levels.WARN
									)
								else
									set_buf_foldlevel(vim.v.count)
								end
							end,
							desc = "UFO: Set Foldlevel",
						},
					},
				})
			end

			-- credits: https://github.com/kevinhwang91/nvim-ufo/blob/c6d88523f574024b788f1c3400c5d5b9bb1a0407/README.md?plain=1#L332-L358
			local handler = function(virtText, lnum, endLnum, width, truncate)
				local newVirtText = {}
				local suffix = (" " .. icons.folded_symbol .. " %d "):format(
					endLnum - lnum
				)
				local sufWidth = vim.fn.strdisplaywidth(suffix)
				local targetWidth = width - sufWidth
				local curWidth = 0
				for _, chunk in ipairs(virtText) do
					local chunkText = chunk[1]
					local chunkWidth = vim.fn.strdisplaywidth(chunkText)
					if targetWidth > curWidth + chunkWidth then
						table.insert(newVirtText, chunk)
					else
						chunkText = truncate(chunkText, targetWidth - curWidth)
						local hlGroup = chunk[2]
						table.insert(newVirtText, { chunkText, hlGroup })
						chunkWidth = vim.fn.strdisplaywidth(chunkText)
						-- str width returned from truncate() may less than 2nd argument, need padding
						if curWidth + chunkWidth < targetWidth then
							suffix = suffix
								.. (" "):rep(
									targetWidth - curWidth - chunkWidth
								)
						end
						break
					end
					curWidth = curWidth + chunkWidth
				end
				table.insert(newVirtText, { suffix, "MoreMsg" })
				return newVirtText
			end
			opts.fold_virt_text_handler = handler
		end,
	},
}
return plugins
