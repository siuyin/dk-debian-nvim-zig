vim.opt.hlsearch = false
vim.opt.grepprg = "rg --vimgrep"
vim.opt.grepformat = "%f:%l:%c:%m"

vim.lsp.config('zls', { 
        cmd = {"/usr/local/zig/zls"},
        filetypes = {"zig"},
	root_markers = {"build.zig"},
	settings = {
		zls = {
			zig_exe_path = "/usr/local/zig/zig"
		}
	}
})

vim.lsp.enable('zls')

vim.keymap.set("n","<leader>e", vim.diagnostic.open_float, {bufnr = bufnr})

-- Define an autocommand group to prevent duplicate autocmds
vim.api.nvim_create_augroup("LspFormatting", { clear = true })

-- Create an autocommand that fires when an LSP client attaches to a buffer
vim.api.nvim_create_autocmd("LspAttach", {
  group = "LspFormatting",
  callback = function(args)
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)

    -- Check if the client supports formatting and auto-formatting is desired
    if client and client.server_capabilities.documentFormattingProvider then
      -- Create another autocommand for BufWritePre (before saving)
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = "LspFormatting",
        buffer = bufnr,
        callback = function()
          -- Format the buffer using the attached LSP client
          vim.lsp.buf.format({ bufnr = bufnr })
        end,
      })
    end
  end,
})

