-- bootstrap lazy.nvim, AstroNvim, and user plugins
require "config.lazy"
-- run polish file at the very end
pcall(require, "config.polish")
