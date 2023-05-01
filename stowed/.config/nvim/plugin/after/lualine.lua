local colors = {
	black = vim.g.terminal_color_0,
	red = vim.g.terminal_color_1,
	green = vim.g.terminal_color_2,
	yellow = vim.g.terminal_color_3,
	blue = vim.g.terminal_color_4,
	magenta = vim.g.terminal_color_5,
	cyan = vim.g.terminal_color_6,
	white = vim.g.terminal_color_7,
	grey = vim.g.terminal_color_8,
	light_red = vim.g.terminal_color_9,
	light_green = vim.g.terminal_color_10,
	light_yellow = vim.g.terminal_color_11,
	light_blue = vim.g.terminal_color_12,
	light_magenta = vim.g.terminal_color_13,
	light_cyan = vim.g.terminal_color_14,
	light_white = vim.g.terminal_color_15,
}

local nord_theme = {
	inactive = {
		a = { bg = colors.grey, fg = colors.black, gui = "bold" },
		b = { bg = colors.grey, fg = colors.black },
		c = { bg = colors.grey, fg = colors.black },
		x = { bg = colors.grey, fg = colors.red },
		y = { bg = colors.grey, fg = colors.black },
		z = { bg = colors.grey, fg = colors.black },
	},
	visual = {
		a = { bg = colors.blue, fg = colors.black, gui = "bold" },
		b = { bg = colors.yellow, fg = colors.black },
		c = { bg = colors.grey, fg = colors.black },
		x = { bg = colors.grey, fg = colors.red },
		y = { bg = colors.blue, fg = colors.black },
		z = { bg = colors.yellow, fg = colors.black },
	},
	replace = {
		a = { bg = colors.magenta, fg = colors.black, gui = "bold" },
		b = { bg = colors.yellow, fg = colors.black },
		c = { bg = colors.grey, fg = colors.black },
		x = { bg = colors.grey, fg = colors.red },
		y = { bg = colors.blue, fg = colors.black },
		z = { bg = colors.yellow, fg = colors.black },
	},
	normal = {
		a = { bg = colors.red, fg = colors.black, gui = "bold" },
		b = { bg = colors.yellow, fg = colors.black },
		c = { bg = colors.grey, fg = colors.black },
		x = { bg = colors.grey, fg = colors.red },
		y = { bg = colors.blue, fg = colors.black },
		z = { bg = colors.yellow, fg = colors.black },
	},
	insert = {
		a = { bg = colors.green, fg = colors.black, gui = "bold" },
		b = { bg = colors.yellow, fg = colors.black },
		c = { bg = colors.grey, fg = colors.black },
		x = { bg = colors.grey, fg = colors.red },
		y = { bg = colors.blue, fg = colors.black },
		z = { bg = colors.yellow, fg = colors.black },
	},
	command = {
		a = { bg = colors.white, fg = colors.black, gui = "bold" },
		b = { bg = colors.yellow, fg = colors.black },
		c = { bg = colors.grey, fg = colors.black },
		x = { bg = colors.grey, fg = colors.red },
		y = { bg = colors.blue, fg = colors.black },
		z = { bg = colors.yellow, fg = colors.black },
	},
}

local ok, lualine = pcall(require, "lualine")
if ok then
	lualine.setup({
		options = {
			icons_enabled = false,
			theme = nord_theme,
			component_separators = { left = "", right = "" },
			section_separators = { left = "", right = "" },
			disabled_filetypes = {},
			always_divide_middle = true,
			globalstatus = true,
			bg = colors.grey,
		},
		sections = {
			lualine_a = { "mode" },
			lualine_b = { "filename" },
			lualine_c = { { "branch", "diff", "diagnostics", color = { fg = colors.black, bg = colors.red } } },
			lualine_y = { { "encoding", padding = 1 } },
			lualine_z = { { "filesize", padding = 1 } },
			lualine_x = {
				{
					function()
						local current_line = vim.fn.line(".")
						local total_lines = vim.fn.line("$")
						local chars =
							{ "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
						local line_ratio = current_line / total_lines
						local index = math.ceil(line_ratio * #chars)
						return chars[index]
					end,
					padding = { left = 0, right = 0 },
				},
			},
		},
	})
end
