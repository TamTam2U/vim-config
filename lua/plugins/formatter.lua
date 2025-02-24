return {
	{
		"stevearc/conform.nvim",
		config = function()
			local conform = require("conform")
			conform.setup({
				formatters_by_ft = {
					lua = { "stylua" },
					-- Conform will run multiple formatters sequentially
				},
				format_after_save = {
					lsp_fallback = true,
					async = true,
					timeout_ms = 500,
					quiet = true,
				},
			})
			vim.keymap.set({ "n", "x", "v", "i" }, "<F3>", function()
				conform.format({
					bufnr = vim.api.nvim_get_current_buf(),
					lsp_fallback = true,
					async = true,
					timeout_ms = 500,
					quiet = true,
				})
			end, { desc = "Format" })

			vim.api.nvim_create_user_command("Format", function(args)
				local range = nil
				if args.count ~= -1 then
					local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
					range = {
						start = { args.line1, 0 },
						["end"] = { args.line2, end_line:len() },
					}
				end
				require("conform").format({ async = true, lsp_format = "fallback", range = range, quite = true })
			end, { range = true })
		end,
	},
}
