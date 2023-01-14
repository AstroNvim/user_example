local C = require "astronvim_theme.colors"
-- modify the astronvim colors of the astronvim colorscheme directly when it's created
return {
  Normal = { fg = C.fg, bg = C.bg },

  -- customize styles of highlight groups
  -- DiagnosticError = { italic = true },
  -- DiagnosticHint = { italic = true },
  -- DiagnosticInfo = { italic = true },
  -- DiagnosticWarn = { italic = true },
}
