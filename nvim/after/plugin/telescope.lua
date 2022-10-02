local telescope = require("telescope")
local telescopeConfig = require("telescope.config")

-- Clone the default Telescope configuration
local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }

-- I want to search in hidden/dot files.
table.insert(vimgrep_arguments, "--hidden")
-- I don't want to search in the `.git` directory.
table.insert(vimgrep_arguments, "--glob")
table.insert(vimgrep_arguments, "!.git/*")

telescope.setup({
	defaults = {
    mappings = {
      i = {
        ["<A-j>"] = "move_selection_next",
        ["<A-k>"] = "move_selection_previous"
      }
    },
		-- `hidden = true` is not supported in text grep commands.
		vimgrep_arguments = vimgrep_arguments,
    color_devicons = false,
	},
	pickers = {
		find_files = {
			-- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
			find_command = { "rg", "--files", "--hidden", "--glob", "!.git/*" },
		},
	},
})

Nmap("<leader>ff", "<cmd>Telescope find_files<cr>")
Nmap("<leader>fg", "<cmd>Telescope live_grep<cr>")
Nmap("<leader>fb", "<cmd>Telescope buffers<cr>")
Nmap("<leader>fh", "<cmd>Telescope help_tags<cr>")
