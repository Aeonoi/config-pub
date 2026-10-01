return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  opts = {
    -- Define your formatters
    formatters_by_ft = {
      lua = { "stylua" },
      javascript = {
        "biome",
      },
      javascriptreact = {
        "biome",
      },
      typescript = {
        "biome",
      },
      typescriptreact = {
        "biome",
      },
      css = {
        "biome",
      },
      html = {
        "biome",
      },
      htmlangular = {
        "prettier",
      },
      json = {
        "biome",
      },
      java = {
        "google_java_format",
      }
    },
    notify_on_error = false,
    default_format_opts = {
      async = true,
      timeout_ms = 500,
      lsp_format = "fallback",
    },
    format_after_save = {
      async = true,
      timeout_ms = 500,
      lsp_format = "fallback",
    },
  },
}
