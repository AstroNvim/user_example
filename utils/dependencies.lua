---@param executable string
---@return boolean
local function has_excecutable(executable)
	local is_installed = vim.fn.executable(executable) == 1

	if not is_installed then
		vim.api.nvim_create_autocmd("UIEnter", {
			callback = function()
				vim.notify_once(
					executable .. " is not installed",
					vim.log.levels.WARN
				)
			end,
		})
	end

	return is_installed
end

---@return boolean
local function is_on_glibc()
	local result = vim.fn.system("ldd --version")
	return result:match("GNU libc") ~= nil
end

local function is_on_alpine()
	local output = vim.fn.system("cat /etc/os-release")
	return string.find(output, "alpine") ~= nil
end

return {
	is_on_glibc = is_on_glibc,
	has_excecutable = has_excecutable,
	is_on_alpine = is_on_alpine,
}
