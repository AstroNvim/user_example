-- TODO: might wanna install https://github.com/mg979/vim-visual-multi
-- TODO: neogen and implement like this: https://code.mehalter.com/AstroNvim_user/~files/v4/lua/plugins/neogen.lua
-- TODO: seems interesting, does also include vscode tasks https://github.com/stevearc/overseer.nvim
-- TODO: could replace neo-tree with this https://github.com/kevinhwang91/rnvimr

local is_on_glibc = require("user.utils.dependencies").is_on_glibc
local icons = require("user.icons")

---@type LazySpec
local plugins = {
	{
		--TODO: add background color for tty
		"nvim-treesitter/nvim-treesitter-context",
		event = "User AstroFile",
		keys = {
			---@diagnostic disable-next-line id is used internally in lazy.nvim
			{
				"<leader>uT",
				"<cmd>TSContextToggle<CR>",
				desc = "Toggle treesitter context",
			},
		},
	},
	{
		"mbbill/undotree",
		cmd = "UndotreeToggle",
		event = "User AstroFile",
		keys = {
			---@diagnostic disable-next-line
			{
				"<leader>fu",
				"<cmd>UndotreeToggle<CR>",
				desc = "Find undotree",
			},
		},
	},
	{
		"jackMort/ChatGPT.nvim",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},
		event = "VeryLazy", -- NOTE: keybinds need to be registered
		cmd = {
			"ChatGPT",
			"ChatGPTActAs",
			"ChatGPTEditWithInstructions",
			"ChatGPTRun",
		},
		cond = vim.env["OPENAI_API_KEY"] ~= nil,
		opts = {
			-- NOTE: plugin has a bug, this below doesnt work yet
			-- api_key_cmd = (
			-- 	"/usr/bin/bw --session '"
			-- 	.. (vim.env["BW_SESSION"] or "")
			-- 	.. "' get item chatgpt"
			-- )
			-- 	.. " | /usr/bin/jq -r '.fields"
			-- 	.. ' | map(select(.name == "api key"))'
			-- 	.. " | .[0].value'",
		},
		config = function(_, opts)
			require("chatgpt").setup(opts)

			--TODO: use astronvim keymap setting
			local wk = require("which-key")
			wk.register({
				["<leader>a"] = {
					name = "ChatGPT",
					c = { "<cmd>ChatGPT<CR>", "ChatGPT" },
					e = {
						"<cmd>ChatGPTEditWithInstruction<CR>",
						"Edit with instruction",
						mode = { "n", "v" },
					},
					g = {
						"<cmd>ChatGPTRun grammar_correction<CR>",
						"Grammar Correction",
						mode = { "n", "v" },
					},
					t = {
						"<cmd>ChatGPTRun translate<CR>",
						"Translate",
						mode = { "n", "v" },
					},
					k = {
						"<cmd>ChatGPTRun keywords<CR>",
						"Keywords",
						mode = { "n", "v" },
					},
					d = {
						"<cmd>ChatGPTRun docstring<CR>",
						"Docstring",
						mode = { "n", "v" },
					},
					a = {
						"<cmd>ChatGPTRun add_tests<CR>",
						"Add Tests",
						mode = { "n", "v" },
					},
					o = {
						"<cmd>ChatGPTRun optimize_code<CR>",
						"Optimize Code",
						mode = { "n", "v" },
					},
					s = {
						"<cmd>ChatGPTRun summarize<CR>",
						"Summarize",
						mode = { "n", "v" },
					},
					f = {
						"<cmd>ChatGPTRun fix_bugs<CR>",
						"Fix Bugs",
						mode = { "n", "v" },
					},
					x = {
						"<cmd>ChatGPTRun explain_code<CR>",
						"Explain Code",
						mode = { "n", "v" },
					},
					r = {
						"<cmd>ChatGPTRun roxygen_edit<CR>",
						"Roxygen Edit",
						mode = { "n", "v" },
					},
					l = {
						"<cmd>ChatGPTRun code_readability_analysis<CR>",
						"Code Readability Analysis",
						mode = { "n", "v" },
					},
				},
			})
		end,
	},
	{
		-- credits: https://github.com/AstroNvim/astrocommunity/blob/6f3ce1b6349a29975cbd1af8427f7a52aaef936d/lua/astrocommunity/completion/codeium-vim/init.lua
		"Exafunction/codeium.vim",
		event = "User AstroFile",
		cond = is_on_glibc(),
		config = function()
			require("astronvim.utils").set_mappings({
				i = {
					["<C-g>"] = {
						function()
							return vim.fn["codeium#Accept"]()
						end,
						desc = "Codeium accept completion",
						expr = true,
					},
					["<c-n>"] = {
						function()
							return vim.fn["codeium#CycleCompletions"](1)
						end,
						desc = "Codeium next suggestion",
						expr = true,
					},
					["<c-p>"] = {
						function()
							print("hello")
							return vim.fn["codeium#CycleCompletions"](-1)
						end,
						desc = "Codeium previous suggestion",
						expr = true,
					},
					["<c-x>"] = {
						function()
							return vim.fn["codeium#Clear"]()
						end,
						desc = "Codeium clear completions",
						expr = true,
					},
				},
				n = {
					["<leader>uA"] = {
						function()
							if vim.g.codeium_enabled == true then
								vim.cmd("CodeiumDisable")
							else
								vim.cmd("CodeiumEnable")
							end
						end,
						desc = "Toggle Codeium active",
						expr = true,
					},
				},
			})
		end,
	},
	-- {
	-- 	-- NOTE: only gives suggestions through nvim-cmp now, maybe the author will change it.
	-- 	"Exafunction/codeium.nvim",
	-- 	event = "User AstroFile",
	-- 	dependencies = {
	-- 		"nvim-lua/plenary.nvim",
	-- 		"hrsh7th/nvim-cmp",
	-- 	},
	-- 	cond = is_on_glibc(),
	-- 	config = function()
	-- 		require("codeium").setup({})
	-- 	end,
	-- },
	{
		"folke/todo-comments.nvim",
		event = "User AstroFile",
		cmd = { "TodoTrouble", "TodoTelescope", "TodoLocList", "TodoQuickFix" },
		opts = function()
			require("astronvim.utils").set_mappings({
				n = {
					["<leader>xt"] = {
						"<cmd>TodoTrouble<cr>",
						desc = "Todo trouble",
					},
					["<leader>fT"] = {
						"<cmd>TodoTelescope<cr>",
						desc = "Todo telescope",
					},
				},
			})
			return {}
		end,
	},
	-- credits: https://github.com/LazyVim/LazyVim/blob/879e29504d43e9f178d967ecc34d482f902e5a91/lua/lazyvim/plugins/ui.lua#L214-L275
	{
		"lukas-reineke/indent-blankline.nvim",
		event = "User AstroFile",
		---@type ibl.indent_options
		---@diagnostic disable-next-line
		opts = {
			indent = {
				char = icons.scope_symbol,
				tab_char = icons.scope_indent_tab_symbol,
			},
			scope = {
				enabled = false,
			},
			exclude = {
				filetypes = {
					"help",
					"alpha",
					"dashboard",
					"neo-tree",
					"Trouble",
					"trouble",
					"lazy",
					"mason",
					"notify",
					"toggleterm",
					"lazyterm",
				},
			},
		},
		main = "ibl",
	},
	{
		"echasnovski/mini.indentscope",
		event = "User AstroFile",
		opts = {
			symbol = icons.scope_symbol,
			options = { try_as_border = true },
		},
		init = function()
			vim.api.nvim_create_autocmd("FileType", {
				pattern = {
					"help",
					"alpha",
					"dashboard",
					"neo-tree",
					"Trouble",
					"trouble",
					"lazy",
					"mason",
					"notify",
					"toggleterm",
					"lazyterm",
				},
				callback = function()
					vim.b["miniindentscope_disable"] = true
				end,
			})
		end,
	},
	{
		"echasnovski/mini.operators",
		keys = {
			{ "<leader>oe", desc = "Evaluate" },
			{ "<leader>ox", desc = "Exchange" },
			{ "<leader>om", desc = "Multiply" },
			{ "<leader>or", desc = "Replace" },
			{ "<leader>os", desc = "Sort" },
		},
		opts = {
			evaluate = { prefix = "<leader>oe" },
			exchange = { prefix = "<leader>ox" },
			multiply = { prefix = "<leader>om" },
			replace = { prefix = "<leader>or" },
			sort = { prefix = "<leader>os" },
		},
	},
}

return plugins
