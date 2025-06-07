return {
    {
        "saghen/blink.cmp",
        lazy = false, -- lazy loading handled internally
        -- optional: provides snippets for the snippet source
        -- dependencies = "rafamadriz/friendly-snippets",

        -- use a release tag to download pre-built binaries
        version = "v0.*",
        -- OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
        -- build = 'cargo build --release',
        -- If you use nix, you can build from source using latest nightly rust with:
        -- build = 'nix run .#build-plugin',

        opts = {
            -- 'default' for mappings similar to built-in completion
            -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
            -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
            -- see the "default configuration" section below for full documentation on how to define
            -- your own keymap. when defining your own, no keybinds will be assigned automatically.
            keymap = {
                ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
                ['<C-h>'] = { 'hide' },
                ['<C-l>'] = { 'select_and_accept' },

                ['<C-k>'] = { 'select_prev', 'fallback' },
                ['<C-j>'] = { 'select_next', 'fallback' },

                ['<C-u>'] = { 'scroll_documentation_up', 'fallback' },
                ['<C-d>'] = { 'scroll_documentation_down', 'fallback' },

                ['<Tab>'] = { 'snippet_forward', 'fallback' },
                ['<S-Tab>'] = { 'snippet_backward', 'fallback' },
            },

            completion = {
                list = {
                    selection = {
                        preselect = true,
                        auto_insert = true,
                    }
                },
                accept = {
                    auto_brackets = {
                        enabled = true,
                    },
                },
                menu = {
                    draw = {
                        columns = {
                            { "label", "label_description", gap = 1 }, { "kind" }
                        },
                    },
                },
                documentation = {
                    auto_show = true,
                    window = {
                        max_width = 120,
                        max_height = 60,
                    },
                },
                ghost_text = {
                    enabled = false,
                },
                trigger = { prefetch_on_insert = false },
            },

            appearance = {
                use_nvim_cmp_as_default = false,
                nerd_font_variant = "mono",
            },

            sources = {
                default = { "lsp", "path", "snippets", "buffer" },
            },

            signature = {
                enabled = true,
            },
        }
    }
}
