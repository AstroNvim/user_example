---@return boolean
local function is_tty()
	return vim.env["TERM"] == "linux"
end

---@param cond boolean
---@param if_true any
---@param if_false any
local function when_else(cond, if_true, if_false)
	return cond and if_true or if_false
end

return {
	is_tty = is_tty,
	when_else = when_else,
}
