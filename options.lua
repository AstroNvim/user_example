local is_tty = require("user.utils.helper").is_tty

local icons = require("user.icons")

return {
	opt = {
		relativenumber = true,
		number = true,
		spell = true,
		-- NOTE:
		-- if you dont have the spells, you have to let neovim download them.
		-- run this command `nvim --clean -c "set spelllang=en_us,de_de spell" -c "quit"`
		spelllang = "en_us,de_de",
		signcolumn = "auto",
		wrap = false,
		shiftwidth = 4,
		tabstop = 4,
		list = true,
		expandtab = false,
		listchars = {
			tab = icons.tab_char,
			space = icons.space_char,
		},
		clipboard = "",
		-- completeopt = "menu,menuone,noselect,noinsert",
		foldcolumn = "auto:3",
		foldlevelstart = 99,
		foldenable = true,
		foldmethod = "manual",
		fillchars = {
			eob = " ",
			fold = " ",
			foldopen = icons.expander_expanded,
			foldsep = icons.expander_separator,
			foldclose = icons.expander_collapsed,
		},
	},
	g = {
		mapleader = " ", -- sets vim.g.mapleader
		autoformat_enabled = true, -- enable or disable auto formatting at start (lsp.formatting.format_on_save must be enabled)
		cmp_enabled = true, -- enable completion at start
		autopairs_enabled = true, -- enable autopairs at start
		diagnostics_mode = 3, -- set the visibility of diagnostics in the UI (0=off, 1=only show in status line, 2=virtual text off, 3=all on)
		icons_enabled = not is_tty(), -- disable icons in the UI (disable if no nerd font is available, requires :PackerSync after changing)
		ui_notifications_enabled = true, -- disable notifications when toggling UI elements
		resession_enabled = false, -- enable experimental resession.nvim session management (will be default in AstroNvim v4)
	},
}
