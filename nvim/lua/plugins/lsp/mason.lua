return {
    'williamboman/mason.nvim',
    dependencies = {
        'williamboman/mason-lspconfig.nvim',
        'neovim/nvim-lspconfig',
        'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
        local mason = require('mason')
        local mason_lspconfig = require('mason-lspconfig')
        local lspconfig = require('lspconfig')

        mason.setup({
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗"
                }
            }
        })

        mason_lspconfig.setup({
            ensure_installed = {
                'lua_ls',
                -- C/C++ Languager Servers
               -- 'clangd',
                'cmake',
                'arduino_language_server',
                -- Rust
                'rust_analyzer',
                -- Bash
                'bashls',
                -- Assembly Language LSP
                -- 'asm_lsp',
                -- Latex LSP
                'ltex',
                -- 'bufls',
                -- VHDL/Verilog/SystemV LSP
                'hdl_checker',
                -- Python LSP
                'pylsp',
            },
            -- for the love of god I dont want to worry about this
            automatic_installation = true,
        })

        local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
        mason_lspconfig.setup_handlers({
            function(server_name)
                lspconfig[server_name].setup({
                    capabilities = lsp_capabilities,
                })
            end,
        })
        
        lspconfig.lua_ls.setup({
            capabilities = capabilities
        })

        lspconfig.ccls.setup({
            capabilities = capabilities
        })
        
        lspconfig.marksman.setup({
            capabilities = capabilities
        })

        vim.diagnostic.config({
            update_in_insert = true,
        })

    end,
}
