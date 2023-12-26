-- TODO: customize statusbar, show stats? and diable lsp status, bcs noice; also show current venv
-- FIXME: cpp not working?

---@type LazySpec[]
local community_plugins = {
	"AstroNvim/astrocommunity",
}

---@param plugins LazySpec[]
local function add(plugins)
	for _, plugin in ipairs(plugins) do
		table.insert(community_plugins, plugin)
	end
end

-- seperate the section so it will be more readable

add({
	{ import = "astrocommunity.bars-and-lines.smartcolumn-nvim" },
	{
		"m4xshen/smartcolumn.nvim",
		opts = {
			colorcolumn = "120",
		},
	},
	{ import = "astrocommunity.bars-and-lines.vim-illuminate" },
})

add({
	-- { import = "astrocommunity.pack.angular" },
	{ import = "astrocommunity.pack.ansible" },
	{ import = "astrocommunity.pack.bash" },
	{ import = "astrocommunity.pack.cmake" },
	{ import = "astrocommunity.pack.cpp" },
	{ import = "astrocommunity.pack.cs" },
	{ import = "astrocommunity.pack.docker" },
	{ import = "astrocommunity.pack.html-css" },
	{ import = "astrocommunity.pack.json" },
	{ import = "astrocommunity.pack.lua" },
	{ import = "astrocommunity.pack.markdown" },
	{ import = "astrocommunity.pack.ps1" },
	{ import = "astrocommunity.pack.python" },
	{ import = "astrocommunity.pack.rust" },
	{ import = "astrocommunity.pack.toml" },
	{ import = "astrocommunity.pack.typescript-all-in-one" },
	{ import = "astrocommunity.pack.yaml" },
})

add({
	{ import = "astrocommunity.color.headlines-nvim" },
	{ import = "astrocommunity.color.headlines-nvim" },
})

add({
	-- { import = "astrocommunity.colorscheme.catppuccin" },
	-- { import = "astrocommunity.colorscheme.dracula-nvim" },
	-- { import = "astrocommunity.colorscheme.gruvbox-nvim" },
	-- { import = "astrocommunity.colorscheme.onedarkpro-nvim" },
	-- { import = "astrocommunity.colorscheme.oxocarbon-nvim" },
	{ import = "astrocommunity.colorscheme.mini-base16" },
	{ import = "astrocommunity.colorscheme.kanagawa-nvim" },
})

add({
	{ import = "astrocommunity.diagnostics.trouble-nvim" },
})

add({
	-- TODO: keymap toggle autosave, maybe also change behaviour?
	-- { import = "astrocommunity.editing-support.auto-save-nvim" },

	-- TODO: perhaps this is not needed with a custom pair?
	{ import = "astrocommunity.editing-support.nvim-treesitter-endwise" },

	{ import = "astrocommunity.editing-support.rainbow-delimiters-nvim" },
	{
		"HiPhish/rainbow-delimiters.nvim",
		opts = {
			highlight = {
				-- "RainbowDelimiterRed",
				"RainbowDelimiterCyan",
				"RainbowDelimiterViolet",
				"RainbowDelimiterYellow",
				-- "RainbowDelimiterBlue",
				-- "RainbowDelimiterOrange",
				-- "RainbowDelimiterGreen",
			},
		},
	},
	{ import = "astrocommunity.editing-support.suda-vim" },
	{ import = "astrocommunity.editing-support.treesj" },
	{ import = "astrocommunity.editing-support.true-zen-nvim" },
	{ import = "astrocommunity.editing-support.vim-move" },
})

add({
	-- { import = "astrocommunity.git.git-blame-nvim" },
})

add({
	{ import = "astrocommunity.lsp.lsp-signature-nvim" },
	{
		"ray-x/lsp_signature.nvim",
		opts = {
			noice = true,
		},
	},
	{ import = "astrocommunity.lsp.lsp-inlayhints-nvim" },
})

add({
	{ import = "astrocommunity.markdown-and-latex.peek-nvim" },
})

add({
	{ import = "astrocommunity.motion.flash-nvim" },
	{ import = "astrocommunity.motion.hop-nvim" },
	{ import = "astrocommunity.motion.nvim-surround" },
})

add({
	{ import = "astrocommunity.programming-language-support.csv-vim" },
	{ import = "astrocommunity.programming-language-support.nvim-jqx" },
})

add({
	{ import = "astrocommunity.project.nvim-spectre" },
	{ import = "astrocommunity.project.project-nvim" },
})

add({
	{ import = "astrocommunity.register.nvim-neoclip-lua" },
})

add({
	{ import = "astrocommunity.scrolling.nvim-scrollbar" },
})

add({
	-- TODO: what kind of keybinds does it need?
	{ import = "astrocommunity.split-and-window.windows-nvim" },
})

add({
	{ import = "astrocommunity.utility.noice-nvim" },
	{
		"folke/noice.nvim",
		opts = {
			lsp = {
				signature = { enabled = false },
				hover = { enabled = false },
			},
			-- credits: https://code.mehalter.com/AstroNvim_user/~files/b9d13b6af65fa7c6ec271063355b4625af93b52e/lua/plugins/noice.lua
			routes = {
				{ filter = { event = "msg_show", cmdline = "^:lua" }, view = "messages" }, -- send lua output to split
				{ filter = { event = "msg_show", min_height = 20 }, view = "messages" }, -- send long messages to split
				{ filter = { event = "msg_show", find = "%d+L,%s%d+B" }, opts = { skip = true } }, -- skip save notifications
				{ filter = { event = "msg_show", find = "^%d+ more lines$" }, opts = { skip = true } }, -- skip paste notifications
				{ filter = { event = "msg_show", find = "^%d+ fewer lines$" }, opts = { skip = true } }, -- skip delete notifications
				{ filter = { event = "msg_show", find = "^%d+ lines yanked$" }, opts = { skip = true } }, -- skip yank notifications
			},
		},
	},
})

return community_plugins
