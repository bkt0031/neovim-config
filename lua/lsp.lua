require('mason').setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})

require('mason-lspconfig').setup({
    -- A list of servers to automatically install if they're not already installed
    ensure_installed = { 'pylsp', 'lua_ls', 'gopls' },
})

-- Set different settings for different languages' LSP.
-- LSP list: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
-- How to use setup({}): https://github.com/neovim/nvim-lspconfig/wiki/Understanding-setup-%7B%7D
--     - the settings table is sent to the LSP.
--     - on_attach: a lua callback function to run after LSP attaches to a given buffer.
local lspconfig = require("lspconfig")

-- How to add a LSP for a specific programming language?
-- 1. Use `:Mason` to install the corresponding LSP.
-- 2. Add the configuration below. The syntax is `lspconfig.<name>.setup(...)`
-- Hint (find <name> here) : https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
lspconfig.pylsp.setup({
	on_attach = on_attach,
})

lspconfig.gopls.setup({
	on_attach = on_attach,
})

lspconfig.lua_ls.setup({
	on_attach = on_attach,
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim).
				version = "LuaJIT",
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global.
				globals = { "vim" },
			},
			workspace = {
				-- Make the server aware of Neovim runtime files.
				library = vim.api.nvim_get_runtime_file("", true),
			},
			-- Do not send telemetry data containing a randomized but unique identifier.
			telemetry = {
				enable = false,
			},
		},
	},
})

