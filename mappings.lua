local is_available = require("astronvim.utils").is_available

local mappings = {
	n = {
		-- better buffer navigation
		["]b"] = false,
		["[b"] = false,
		["<S-l>"] = {
			function()
				require("astronvim.utils.buffer").nav(vim.v.count > 0 and vim.v.count or 1)
			end,
			desc = "Next buffer",
		},
		["<S-h>"] = {
			function()
				require("astronvim.utils.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1))
			end,
			desc = "Previous buffer",
		},

		["<leader>b"] = { name = "Buffers" },
		["<leader>bD"] = {
			function()
				require("astronvim.utils.status").heirline.buffer_picker(function(bufnr)
					require("astronvim.utils.buffer").close(bufnr)
				end)
			end,
			desc = "Pick to close",
		},

		-- credits: https://github.com/t1gu1/astrovim-config/blob/5a1d7bd4933f8192de027071d62f953b4c831af3/mappings.lua#L74-L77
		["<leader>pc"] = {
			"<cmd>e $MYVIMRC | :cd %:p:h/lua/user/ | wincmd k | pwd | Neotree<CR>",
			desc = "Open AstroVim User Config",
		},

		-- credits: https://github.com/ThePrimeagen/init.lua/blob/97c039bb88d8bbbcc9b1e3d0dc716a2ba202c6d2/lua/theprimeagen/remap.lua
		["J"] = { "mzJ`z" },
		["<C-d>"] = { "<C-d>zz", desc = "Scroll down" },
		["<C-u>"] = { "<C-u>zz", desc = "Scroll up" },
		["n"] = { "nzzzv" },
		["N"] = { "Nzzzv" },
		["Q"] = { "nop" },

		-- yank to system clipboard
		["<leader>y"] = { '"+y', desc = "Yank to system clipboard" },
		["<leader>Y"] = { '"+Y', desc = "Yank from system clipboard" },

		["<leader>T"] = { name = "Tab" },
		["<leader>Tn"] = { "<cmd>tabnew<cr>", desc = "New tab" },
		["<leader>Tc"] = { "<cmd>tabclose<cr>", desc = "Close tab" },

		-- better increment/decrement
		["-"] = { "<C-x>", desc = "Decrement number" },
		["+"] = { "<C-a>", desc = "Increment number" },

		["<leader>."] = { "<Cmd>cd %:p:h<CR>", desc = "Set CWD" },

		-- quick save and quit
		["<C-s>"] = { ":w!<cr>", desc = "Save and quit" }, -- change description but the same command

		["<leader>fp"] = {
			"<cmd>Telescope projects<CR>",
			desc = "Open Projects",
		},
	},
	x = {
		["<leader>y"] = { '"+y', desc = "Yank to system clipboard" },

		-- better increment/decrement
		["+"] = { "g<C-a>", desc = "Increment number" },
		["-"] = { "g<C-x>", desc = "Descrement number" },
	},
}

if is_available("todo-comments.nvim") then
	mappings.n["<leader>xt"] = { "<cmd>TodoTrouble<cr>", desc = "Todo trouble" }
	mappings.n["<leader>xT"] = { "<cmd>TodoTelescope<cr>", desc = "Todo telescope" }
end

return mappings
