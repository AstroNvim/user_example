local is_tty = require("user.utils.helper").is_tty

---@type Icons
return is_tty() and require("user.icons.text")
	or require("user.icons.nerd_font")
