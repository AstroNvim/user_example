-- Configure AstroNvim updates
return {
  remote = "origin", -- remote to use
  channel = "nightly", -- "stable" or "nightly"
  version = "latest", -- "latest", tag name, or regex search like "v1.*" to only do updates before v2 (STABLE ONLY)
  branch = "nightly", -- branch name (NIGHTLY ONLY)
  commit = nil, -- commit hash (NIGHTLY ONLY)
  pin_plugins = nil, -- nil, true, false (nil will pin plugins on stable only)
  skip_prompts = false, -- skip prompts about breaking changes
  show_changelog = true, -- show the changelog after performing an update
  auto_quit = false, -- automatically quit the current session after a successful update
  remotes = { -- easily add new remotes to track
    --   ["remote_name"] = "https://remote_url.come/repo.git", -- full remote url
    --   ["remote2"] = "github_user/repo", -- GitHub user/repo shortcut,
    --   ["remote3"] = "github_user", -- GitHub user assume AstroNvim fork
  },
}
