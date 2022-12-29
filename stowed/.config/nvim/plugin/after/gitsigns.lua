local ok, git = pcall(require, "gitsigns")
if ok then
	git.setup()
end
