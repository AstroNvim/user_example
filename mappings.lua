-- Mapping data with "desc" stored directly by vim.keymap.set().
--
-- Please use this mappings table to set keyboard mapping since this is the
-- lower level configuration and more robust one. (which-key will
-- automatically pick-up stored data by this setting.)
return {
  -- first key is the mode
  n = {
    -- second key is the lefthand side of the map
    -- mappings seen under group name "Buffer"
    ["<leader>bn"] = { "<cmd>tabnew<cr>", desc = "New tab" },
    ["<leader>bD"] = {
      function()
        require("astronvim.utils.status").heirline.buffer_picker(function(bufnr) require("astronvim.utils.buffer").close(bufnr) end)
      end,
      desc = "Pick to close",
    },
    -- tables with the `name` key will be registered with which-key if it's installed
    -- this is useful for naming menus
    ["<leader>b"] = { name = "Buffers" },
    -- quick save
    -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command
    ["<Tab>"] = {":bnext<CR>", desc = "Next buffer" },
    ["<S-Tab>"] = {":bprevious<CR>", desc = "Previous buffer" },
    ["gD"] = {vim.lsp.buf.definition, desc = "Go to definition" },
    ["gi"] = {vim.lsp.buf.implementation, desc = "Go to implementation" },
    ["K"] =  {vim.lsp.buf.hover, desc = "Hover" },
    ["gr"] = {vim.lsp.buf.references, desc = "References" },
    ["gds"] = {vim.lsp.buf.document_symbol, desc = "Document symbol" },
    ["gws"] = {vim.lsp.buf.workspace_symbol, desc = "Workspace symbol" },
    ["<leader>sh"] = {vim.lsp.buf.signature_help, desc = "Signature help" },
    ["<leader>rn"] = {vim.lsp.buf.rename, desc = "Rename" },
    ["<leader>ka"] = {vim.lsp.buf.code_action, desc = "K(C)ode action"},
    ["<leader>aa"] = {vim.diagnostic.setqflist, desc = "All workspace diagnostics"},
    ["<leader>ae"] = {function() vim.diagnostic.setqflist({ severity = "E" }) end, desc = "All workspace errors"},
    ["<leader>aw"] = {function() vim.diagnostic.setqflist({ severity = "W" }) end, desc = "All workspace warnings"},
    ["<leader>d"] = {vim.diagnostic.setloclist, desc = "Buffer diagnostics" },
    ["[c"] = {function() vim.diagnostic.goto_prev({ wrap = false }) end, desc = "Previous diagnostic" },
    ["]c"] = {function() vim.diagnostic.goto_next({ wrap = false }) end, desc = "Next diagnostic" },
    
  },
  t = {
    -- setting a mapping to false will disable it
    -- ["<esc>"] = false,
  },
}
