local create_cmd = vim.api.nvim_create_user_command

create_cmd("Q", "quit", {})
