local create_cmd = vim.api.nvim_create_user_command

-- Add alias for quit
create_cmd("Q", "quit", {})

-- Delete all marks
create_cmd("delam", "delm! | delm A-Z0-9", {})
