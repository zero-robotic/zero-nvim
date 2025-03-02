-- Note: The order matters: require("mason") -> rquire("mason-lspconfig") -> require("lspconfig")

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
    ensure_installed = { 'pylsp', 'lua_ls', 'rust_analyzer', "bashls" }
})


-- Set different settings for different languages' LSP
local lspconfig = require("lspconfig")

-- Customized on_attach function
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true}
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer.
local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

    if client.name == "rust_analyzer" then
        -- WARNING: This feature requires neovim v0.10+
        vim.lsp.inlay_hint.enable()
    end

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
    vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set("n", "<space>wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
    vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
    vim.keymap.set("n", "<space>f", function()
        vim.lsp.buf.format({
            async = true,
            filter = function(client)
                return client.name == "null-ls"
                    or client.name == "hls"
                    or client.name == "rust_analyzer"
                    or client.name == "ruff"
                    or client.name == "ts_ls"
                end,
            })
        end, bufopts)
end

lspconfig.pylsp.setup({
    on_attach = on_attach,
    settings = {
        -- configure plugins in pylsp
        pylsp = {
            plugins = {
                pyflakes = { enabled = false },
                pylint = { enabled = false },
                pycondestyle = { enabled = false },
            },
        },
    },
})

lspconfig.lua_ls.setup({
    on_attach = on_attach,
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT",
            },
            diagnostics = {
                globals = { "vim" },
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
            },
            -- Do not send telemetry data containing a randomized but unique identifier.
            telemetry = {
                enable = false,
            },
        },
    },
})

lspconfig.bashls.setup({})

lspconfig.rust_analyzer.setup({
    -- source: https://rust-analyzer.github.io/manual.html#nvim-lsp
    on_attach = on_attach,
})

lspconfig.clangd.setup({
    on_attach = on_attach
})


-- Case 1. For CMake Users
--     $ cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON .
-- Case 2. For Bazel Users, use https://github.com/hedronvision/bazel-compile-commands-extractor
lspconfig.clangd.setup({
    on_attach = on_attach,
})


