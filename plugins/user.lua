-- TODO: might wanna install https://github.com/mg979/vim-visual-multi
-- TODO: neogen and implement like this: https://code.mehalter.com/AstroNvim_user/~files/v4/lua/plugins/neogen.lua
-- TODO: seems interesting, does also include vscode tasks https://github.com/stevearc/overseer.nvim

---@type LazySpec
local plugins = {
	{
		"nvim-treesitter/nvim-treesitter-context",
		event = "User AstroFile",
		opts = {},
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
		event = vim.env["OPENAI_API_KEY"] ~= nil and "VeryLazy" or nil,
		enable = vim.env["OPENAI_API_KEY"] ~= nil,
		-- commit = "24bcca7", -- TODO: got this fixed yet?
		config = function(_, opts)
			require("chatgpt").setup(opts)

			local wk = require("which-key")
			wk.register({
				["<leader>a"] = {
					name = "ChatGPT",
					c = { "<cmd>ChatGPT<CR>", "ChatGPT" },
					e = { "<cmd>ChatGPTEditWithInstruction<CR>", "Edit with instruction", mode = { "n", "v" } },
					g = { "<cmd>ChatGPTRun grammar_correction<CR>", "Grammar Correction", mode = { "n", "v" } },
					t = { "<cmd>ChatGPTRun translate<CR>", "Translate", mode = { "n", "v" } },
					k = { "<cmd>ChatGPTRun keywords<CR>", "Keywords", mode = { "n", "v" } },
					d = { "<cmd>ChatGPTRun docstring<CR>", "Docstring", mode = { "n", "v" } },
					a = { "<cmd>ChatGPTRun add_tests<CR>", "Add Tests", mode = { "n", "v" } },
					o = { "<cmd>ChatGPTRun optimize_code<CR>", "Optimize Code", mode = { "n", "v" } },
					s = { "<cmd>ChatGPTRun summarize<CR>", "Summarize", mode = { "n", "v" } },
					f = { "<cmd>ChatGPTRun fix_bugs<CR>", "Fix Bugs", mode = { "n", "v" } },
					x = { "<cmd>ChatGPTRun explain_code<CR>", "Explain Code", mode = { "n", "v" } },
					r = { "<cmd>ChatGPTRun roxygen_edit<CR>", "Roxygen Edit", mode = { "n", "v" } },
					l = {
						"<cmd>ChatGPTRun code_readability_analysis<CR>",
						"Code Readability Analysis",
						mode = { "n", "v" },
					},
				},
			})
		end,
		dependencies = {
			"MunifTanjim/nui.nvim",
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},
		opts = {
			-- NOTE: plugin has a bug, this below doesnt work yet
			-- api_key_cmd = ("/usr/bin/bw --session '" .. (vim.env["BW_SESSION"] or "") .. "' get item chatgpt")
			-- 	.. " | /usr/bin/jq -r '.fields"
			-- 	.. ' | map(select(.name == "api key"))'
			-- 	.. " | .[0].value'",
		},
	},
	{
		-- credits: https://github.com/AstroNvim/astrocommunity/blob/6f3ce1b6349a29975cbd1af8427f7a52aaef936d/lua/astrocommunity/completion/codeium-vim/init.lua
		"Exafunction/codeium.vim",
		event = "User AstroFile",
		config = function()
			vim.keymap.set("i", "<C-g>", function()
				return vim.fn["codeium#Accept"]()
			end, { expr = true })
			vim.keymap.set("i", "<c-;>", function()
				return vim.fn["codeium#CycleCompletions"](1)
			end, { expr = true })
			vim.keymap.set("i", "<c-,>", function()
				return vim.fn["codeium#CycleCompletions"](-1)
			end, { expr = true })
			vim.keymap.set("i", "<c-x>", function()
				return vim.fn["codeium#Clear"]()
			end, { expr = true })
			vim.keymap.set("n", "<leader>uA", function()
				if vim.g.codeium_enabled == true then
					vim.cmd("CodeiumDisable")
				else
					vim.cmd("CodeiumEnable")
				end
			end, { noremap = true, desc = "Toggle Codeium active" })
		end,
	},
	{
		"folke/todo-comments.nvim",
		opts = {},
		event = "User AstroFile",
		cmd = { "TodoTrouble", "TodoTelescope", "TodoLocList", "TodoQuickFix" },
		keys = {
			{ "<leader>xt", "<cmd>TodoTrouble<cr>", desc = "Todo trouble" },
			{ "<leader>fT", "<cmd>TodoTelescope<cr>", desc = "Todo telescope" },
		},
	},
}

return plugins
