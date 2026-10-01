return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			{ "williamboman/mason-lspconfig.nvim", config = function() end },
		},
		config = function()
			local lspconfig = require("lspconfig")
			local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
			local capabilities = vim.tbl_deep_extend(
				"force",
				{},
				vim.lsp.protocol.make_client_capabilities(),
				has_cmp and cmp_nvim_lsp.default_capabilities() or {}
			)

			-- Server configurations
			local servers = {
				-- https://github.com/yioneko/vtsls/blob/main/packages/service/configuration.schema.json#L1063
				vtsls = {
					root_dir = lspconfig.util.root_pattern("tsconfig.json", "package.json", "jsconfig.json"),
					filetypes = {
						"javascript",
						"javascriptreact",
						"javascript.jsx",
						"typescript",
						"typescriptreact",
						"typescript.tsx",
					},
					settings = {
						complete_function_calls = true,
						vtsls = {
							enableMoveToFileCodeAction = true,
							autoUseWorkspaceTsdk = true,
							experimental = {
								completion = {
									enableServerSideFuzzyMatch = true,
								},
							},
						},
						typescript = {
							updateImportsOnFileMove = { enabled = "always" },
							suggest = {
								completeFunctionCalls = true,
							},
							format = {
								enable = false,
							},
							tsserver = {
								maxTsServerMemory = 12288,
							},
							inlayHints = {
								enumMemberValues = { enabled = true },
								functionLikeReturnTypes = { enabled = true },
								parameterNames = { enabled = "literals" },
								parameterTypes = { enabled = true },
								propertyDeclarationTypes = { enabled = true },
								variableTypes = { enabled = false },
							},
						},
						javascript = {
							tsserver = {
								maxTsServerMemory = 5120,
							},
							inlayHints = {
								enumMemberValues = { enabled = true },
								functionLikeReturnTypes = { enabled = true },
								parameterNames = { enabled = "literals" },
								parameterTypes = { enabled = true },
								propertyDeclarationTypes = { enabled = true },
								variableTypes = { enabled = false },
							},
						},
					},
				},
				lua_ls = {
					settings = {
						Lua = {
							format = {
								enable = false,
							},
							workspace = {
								checkThirdParty = false,
							},
							codeLens = {
								enable = true,
							},
							completion = {
								callSnippet = "Replace",
							},
							doc = {
								privateName = { "^_" },
							},
							hint = {
								enable = true,
								setType = false,
								paramType = true,
								paramName = "Disable",
								semicolon = "Disable",
								arrayIndex = "Disable",
							},
						},
					},
				},
				clangd = {
					filetypes = { "c", "h", "cpp" },
					cmd = { "clangd", "--background-index" },
					single_file_support = true,
				},
				rust_analyzer = {
					root_dir = lspconfig.util.root_pattern(".git", "Cargo.toml"),
					check = {
						command = "clippy",
						features = "all",
					},
				},
			}

			require("mason").setup()
			require("nvim-web-devicons").setup()
			require("mason-lspconfig").setup({
				handlers = {
					function(server_name)
						if server_name ~= "jdtls" then
							local server = servers[server_name] or {}
							server.capabilities =
								vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
							-- server.on_attach = function(client, buffer)
							-- 	if client.supports_method("textDocument/documentSymbol") then
							-- 		require("nvim-navic").attach(client, buffer)
							-- 	end
							-- end
							require("lspconfig")[server_name].setup(server)
						end
					end,
				},
			})
			-- local x = vim.diagnostic.severity
			-- local icons = require("utils.icons")
			vim.diagnostic.config({
				update_in_insert = false,
				underline = true,
				severity_sort = true,
				-- signs = {
				-- 	text = {
				-- 		[x.ERROR] = icons.diagnostics.Error,
				-- 		[x.WARN] = icons.diagnostics.Warn,
				-- 		[x.HINT] = icons.diagnostics.Hint,
				-- 		[x.INFO] = icons.diagnostics.Info,
				-- 	},
				-- },
				float = {
					focusable = false,
					style = "minimal",
					-- border = "rounded",
					source = "always",
					header = "",
					prefix = "",
				},
				virtual_text = false,
				-- virtual_text = {
				-- 	source = "always",
				-- 	spacing = 4,
				-- 	prefix = "\u{ea71}",
				-- },
			})
		end,
	},
}
