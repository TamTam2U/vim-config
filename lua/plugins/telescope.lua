return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		keys = function()
			local builtin = require("telescope.builtin")

			return {
				{ "<C-p>", builtin.find_files, desc = "Find File" },
				-- { "<C-p>", find_directory_and_focus, desc = "Find File" },
				{ "<C-f>", builtin.live_grep, desc = "Find File" },
			}
		end,
		config = function()
			local telescope = require("telescope")
			local actions = require("telescope.actions")
			telescope.setup({
				defaults = {
					mappings = {
						i = {
							["<C-j>"] = actions.move_selection_next,
							["<C-k>"] = actions.move_selection_previous,
							["<esc>"] = actions.close,
						},
					},
					-- file_ignore_patterns = { ".git/*", "*/tmp/*", "node_modules/*", "venv", "vendor/*" },
					vimgrep_arguments = {
						"rg",
						"--color=never",
						"--no-heading",
						"--with-filename",
						"--line-number",
						"--column",
						"--smart-case",
						"--ignore-file",
						".gitignore",
					},
				},
				pickers = {
					find_files = {
						theme = "dropdown",
						previewer = false,
						find_command = {
							"rg",
							"--files",
							"--sortr=modified",
							"--color=never",
							"--no-heading",
							"--with-filename",
							"--line-number",
							"--column",
							"--smart-case",
							"--ignore-file",
							".gitignore",
						},
					},
				},
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({ winblend = 10 }),
					},
					persisted = {
						layout_config = { width = 0.55, height = 0.55 },
					},
				},
			})
			telescope.load_extension("ui-select")
		end,
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
	},
}
