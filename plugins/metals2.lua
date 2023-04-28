local M = {}

M.config = function()
  local lvim_lsp = require("lvim.lsp")
  local metals_config = require("metals").bare_config()
  metals_config.on_init = lvim_lsp.common_on_init
  metals_config.on_exit = lvim_lsp.common_on_exit
  metals_config.capabilities = lvim_lsp.common_capabilities()
  metals_config.on_attach = function(client, bufnr)
    lvim_lsp.common_on_attach(client, bufnr)
    require("metals").setup_dap()
  end
  metals_config.settings = {
    superMethodLensesEnabled = true,
    showImplicitArguments = true,
    showInferredType = true,
    showImplicitConversionsAndClasses = true,
    excludedPackages = {},
  }
  metals_config.init_options.statusBarProvider = false
  vim.api.nvim_create_autocmd("FileType", {
    pattern = { "scala", "sbt", "java" },
    callback = function() require("metals").initialize_or_attach(metals_config) end,
    group = vim.api.nvim_create_augroup("nvim-metals", { clear = true }),
  })
end

return M
