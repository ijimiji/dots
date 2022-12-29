local ok, comment = pcall(require, "nvim_comment")
if ok then
	comment.setup({})
end

local ok, pairs = pcall(require, "nvim-autopairs")
if ok then
	pairs.setup({})
end

local ok, surround = pcall(require, "nvim-surround")
if ok then
	surround.setup({})
end
