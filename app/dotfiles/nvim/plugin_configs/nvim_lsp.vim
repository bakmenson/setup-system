let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
lua require'lspconfig'.tsserver.setup{ on_attach=require'completion'.on_attach }
lua require'lspconfig'.pyright.setup{ on_attach=require'completion'.on_attach }
"lua require'lspconfig'.jdtls.setup{ on_attach=require'completion'.on_attach }
