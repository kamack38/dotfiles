local M = {}

M.keys = {

  --[[
  gh  -> github
  ghl -> label
  -- gha -> actions
  gho -> assignee
  ghc -> card
  ghi -> issue
  ghj -> comment
  -- gho -> reviewer
  ghp -> pr
  ghP -> repo
  ghr -> review
  ghs -> search
  ght -> thread
  ghu -> react
  -- ghg -> Gist
  --]]

  -- Gist
  { "<leader>ghg", "<cmd> Octo gist list<CR>", mode = "n", desc = "List Gists" },

  -- Actions (list)
  { "<leader>gha", "<cmd> Octo actions<CR>", mode = "n", desc = "List Actions" },

  -- Repo
  { "<leader>ghPl", "<cmd> Octo repo list<CR>", mode = "n", desc = "List Repo" },
  { "<leader>ghPf", "<cmd> Octo repo fork<CR>", mode = "n", desc = "Fork Repo" },
  { "<leader>ghPu", "<cmd> Octo repo url<CR>", mode = "n", desc = "Url Repo" },
  { "<leader>ghPv", "<cmd> Octo repo view<CR>", mode = "n", desc = "View Repo" },
  { "<leader>ghPb", "<cmd> Octo repo browser<CR>", mode = "n", desc = "Browser Repo" },

  -- React
  { "<leader>ghuh", "<cmd> Octo reaction heart<CR>", mode = "n", desc = "React with heart" },
  { "<leader>ghur", "<cmd> Octo reaction rocket<CR>", mode = "n", desc = "React with rocket" },
  { "<leader>ghut", "<cmd> Octo reaction tada<CR>", mode = "n", desc = "React with tada" },
  { "<leader>ghup", "<cmd> Octo reaction party<CR>", mode = "n", desc = "React with party" },
  { "<leader>ghuo", "<cmd> Octo reaction hooray<CR>", mode = "n", desc = "React with hooray" },
  { "<leader>ghuc", "<cmd> Octo reaction confused<CR>", mode = "n", desc = "React with confused" },
  { "<leader>ghul", "<cmd> Octo reaction laugh<CR>", mode = "n", desc = "React with laugh" },
  { "<leader>ghue", "<cmd> Octo reaction eyes<CR>", mode = "n", desc = "React with eyes" },
  { "<leader>ghum", "<cmd> Octo reaction -1<CR>", mode = "n", desc = "Upvote" },
  { "<leader>ghup", "<cmd> Octo reaction +1<CR>", mode = "n", desc = "Downvote" },
  { "<leader>ghud", "<cmd> Octo reaction thumbs_down<CR>", mode = "n", desc = "React with thumbs_down" },
  { "<leader>ghuu", "<cmd> Octo reaction thumbs_up<CR>", mode = "n", desc = "React with thumbs_up" },

  -- Comment
  { "<leader>ghja", "<cmd> Octo comment add<CR>", mode = "n", desc = "Add Comment" },
  { "<leader>ghjd", "<cmd> Octo comment delete<CR>", mode = "n", desc = "Delete Comment" },

  -- Card
  { "<leader>ghcm", "<cmd> Octo card move<CR>", mode = "n", desc = "Move Card" },
  { "<leader>ghcr", "<cmd> Octo card remove<CR>", mode = "n", desc = "Remove Card" },
  { "<leader>ghca", "<cmd> Octo card add<CR>", mode = "n", desc = "Add Card" },

  -- Review
  { "<leader>ghrq", "<cmd> Octo review close<CR>", mode = "n", desc = "Close Review" },
  { "<leader>ghrs", "<cmd> Octo review start<CR>", mode = "n", desc = "Start Review" },
  { "<leader>ghrd", "<cmd> Octo review discard<CR>", mode = "n", desc = "Discard Review" },
  { "<leader>ghrr", "<cmd> Octo review resume<CR>", mode = "n", desc = "Resume Review" },
  { "<leader>ghrw", "<cmd> Octo review submit<CR>", mode = "n", desc = "Submit Review" },
  { "<leader>ghrc", "<cmd> Octo review commit<CR>", mode = "n", desc = "Commit Review" },
  { "<leader>ghra", "<cmd> Octo review comments<CR>", mode = "n", desc = "comments Review" },

  -- Thread
  { "<leader>ght", "<cmd> Octo thread resolve<CR>", mode = "n", desc = "Resolve Thread" },
  { "<leader>ght", "<cmd> Octo thread unresolve<CR>", mode = "n", desc = "Unresolve Thread" },

  -- PR
  { "<leader>ghpu", "<cmd> Octo pr url<CR>", mode = "n", desc = "PR Url" },
  { "<leader>ghpe", "<cmd> Octo pr edit<CR>", mode = "n", desc = "Edit PR" },
  { "<leader>ghpr", "<cmd> Octo pr reopen<CR>", mode = "n", desc = "Reopen PR " },
  { "<leader>ghps", "<cmd> Octo pr search<CR>", mode = "n", desc = "Search PR" },
  { "<leader>ghpc", "<cmd> Octo pr commits<CR>", mode = "n", desc = "Check PR Commits" },
  { "<leader>ghph", "<cmd> Octo pr checks<CR>", mode = "n", desc = "PR Checks" },
  { "<leader>ghpl", "<cmd> Octo pr reload<CR>", mode = "n", desc = "Reload PR" },
  { "<leader>ghpb", "<cmd> Octo pr browser<CR>", mode = "n", desc = "Open PR in Browser" },
  { "<leader>ghpm", "<cmd> Octo pr merge<CR>", mode = "n", desc = "Merge PR" },
  { "<leader>ghpn", "<cmd> Octo pr create<CR>", mode = "n", desc = "Create PR" },
  { "<leader>ghpo", "<cmd> Octo pr checkout<CR>", mode = "n", desc = "Checkout PR" },
  { "<leader>ghpt", "<cmd> Octo pr close<CR>", mode = "n", desc = "Close PR" },
  { "<leader>ghpq", "<cmd> Octo pr list<CR>", mode = "n", desc = "List PR" },
  { "<leader>ghpd", "<cmd> Octo pr diff<CR>", mode = "n", desc = "PR Diff" },
  { "<leader>ghpz", "<cmd> Octo pr changes<CR>", mode = "n", desc = "PR Changes" },
  { "<leader>ghpp", "<cmd> Octo pr ready<CR>", mode = "n", desc = "Ready PR" },

  -- Search
  { "<leader>ghs", "<cmd> Octo search<CR>", mode = "n", desc = "Search Github" },

  -- Assignee
  { "<leader>ghoa", "<cmd> Octo assignee add<CR>", mode = "n", desc = "Add Assignee" },
  { "<leader>ghor", "<cmd> Octo assignee remove<CR>", mode = "n", desc = "Remove Assignee" },

  -- Reviewer
  { "<leader>ghk", "<cmd> Octo reviewer add<CR>", mode = "n", desc = "Add Code Reviewer" },

  -- Issue
  { "<leader>ghib", "<cmd> Octo issue browser<CR>", mode = "n", desc = "Issue Browser" },
  { "<leader>ghir", "<cmd> Octo issue reopen<CR>", mode = "n", desc = "Reopen Issue" },
  { "<leader>ghic", "<cmd> Octo issue create<CR>", mode = "n", desc = "Create Issue" },
  { "<leader>ghis", "<cmd> Octo issue search<CR>", mode = "n", desc = "Search Issue" },
  { "<leader>ghiu", "<cmd> Octo issue url<CR>", mode = "n", desc = "Url of Issue" },
  { "<leader>ghil", "<cmd> Octo issue list<CR>", mode = "n", desc = "List Issue" },
  { "<leader>ghie", "<cmd> Octo issue edit<CR>", mode = "n", desc = "Edit Issue" },
  { "<leader>ghix", "<cmd> Octo issue close<CR>", mode = "n", desc = "Close Issue" },
  { "<leader>ghid", "<cmd> Octo issue reload<CR>", mode = "n", desc = "Reload Issue" },

  -- Label
  { "<leader>ghlc", "<cmd> Octo label create<CR>", mode = "n", desc = "Create Label" },
  { "<leader>ghla", "<cmd> Octo label add<CR>", mode = "n", desc = "Add Label" },
  { "<leader>ghlr", "<cmd> Octo label remove<CR>", mode = "n", desc = "Remove Label" },
}

return M
