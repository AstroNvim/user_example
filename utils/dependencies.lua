---@param executable string
---@return boolean
local function has_excecutable(executable)
	-- TODO: warn the user if not found
	return vim.fn.executable(executable) == 0
end

return {
	has_excecutable = has_excecutable,
}
