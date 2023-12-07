return {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
        -- Autocompletion
        { "hrsh7th/cmp-buffer" },
        { "hrsh7th/cmp-path" },
        { "saadparwaiz1/cmp_luasnip" },
        { "hrsh7th/cmp-nvim-lua" },

        -- Snippets
        { "L3MON4D3/LuaSnip" },
        { "rafamadriz/friendly-snippets" },
    },
    config = function()
        local cmp = require("cmp")

        local luasnip = require("luasnip")

        -- loads vscide style snippets from installed plugins, e.g., friendly-snippets
        require("luasnip.loaders.from_vscode").lazy_load()

        cmp.setup({
            preselect = cmp.PreselectMode.None,
            completion = {
                -- Set completeopt to have a better completion experience
                -- :help completeopt
                -- menuone: popup even when there's only one match
                -- noinsert: Do not insert text until a selection is made
                -- noselect: Do not select, force user to select one from the menu
                completeopt = "noselect,noinsert,menuone"
            },
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end
            },
            mapping = cmp.mapping.preset.insert({
                ['<up>'] = cmp.mapping.select_prev_item(),
                ['<down>'] = cmp.mapping.select_next_item(),
                ['<Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                        -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
                        -- that way you will only jump inside the snippet region
                    elseif luasnip.expand_or_locally_jumpable() then
                        luasnip.expand_or_jump()
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                ['<S-Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                ['<C-d>'] = cmp.mapping.scroll_docs(4),
                ['<C-u>'] = cmp.mapping.scroll_docs(-4),
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<CR>'] = cmp.mapping.confirm({
                    behavior = cmp.ConfirmBehavior.Insert,
                    select = false,
                })

            }),
            sources = {
                { name = 'nvim_lsp' },
                { name = 'luasnip' },
                { name = 'path' },
                { name = 'buffer' },
            },
            window = {
                completion = cmp.config.window.bordered({
                    winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:CursorLine,Search:Search",
                }),
                documentation = cmp.config.window.bordered({
                    winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:CursorLine,Search:Search",
                }),
            }
        })
    end
}
