local M = {}

M.defaults = {
  picker = "telescope",
  default_remote = { "upstream", "origin" },
  reaction_viewer_hint_icon = "",
  user_icon = " ",
  comment_icon = " ",
  outdated_icon = " ",
  resolved_icon = " ",
  timeline_marker = "",
  timeline_indent = "2",
  right_bubble_delimiter = "",
  left_bubble_delimiter = "",
  github_hostname = "",
  snippet_context_lines = 4,
  file_panel = {
    size = 10,
    use_icons = true,
  },
  mappings = {
    issue = {
      reload = "<C-r>",
      open_in_browser = "<C-b>",
      copy_url = "<C-y>",
      next_comment = "]c",
      prev_comment = "[c",
    },
    pull_request = {
      reload = "<C-r>",
      open_in_browser = "<C-b>",
      copy_url = "<C-y>",
      next_comment = "]c",
      prev_comment = "[c",
    },
    review_thread = {
      next_comment = "]c",
      prev_comment = "[c",
      select_next_entry = "]q",
      select_prev_entry = "[q",
      close_review_tab = "<C-c>",
    },
    repo = {},
    submit_win = {
      close_review_win = "<C-c>",
      approve_review = "<C-a>",
      comment_review = "<C-m>",
      request_changes = "<C-r>",
    },
    review_diff = {
      select_next_entry = "]q",
      select_prev_entry = "[q",
      next_thread = "]t",
      prev_thread = "[t",
      close_review_tab = "<C-c>",
    },
    file_panel = {
      next_entry = "j",
      prev_entry = "k",
      select_entry = "<cr>",
      refresh_files = "R",
      select_next_entry = "]q",
      select_prev_entry = "[q",
      close_review_tab = "<C-c>",
    },
  },
}

M._config = M.defaults

function M.get_config()
  return M._config
end

function M.config()
  lvim.builtin.octo = {
    active = false,
    on_config_done = nil,
    opts = M.defaults,
  }
end

function M.setup(user_config)
  require("octo.completion")
  require("octo.folds")
  _G.octo_repo_issues = {}
  _G.octo_buffers = {}
  require("octo.signs").setup()
  user_config = user_config or {}
  M._config = require("octo.utils").tbl_deep_clone(M.defaults)
  require("octo.utils").tbl_soft_extend(M._config, user_config)

  M._config.file_panel = vim.tbl_deep_extend("force", M.defaults.file_panel, user_config.file_panel or {})

  lvim.builtin.which_key.mappings["G"] = {
    name = "Github",
    g = { "<cmd>lua require'octo.mappings'.on_keypress('goto_issue')<cr>", "Go to issue" },
    i = {
      name = "Issues",
      c = { "<cmd>Octo issue close<cr>", "Close" },
      l = { "<cmd>Octo issue list<cr>", "List" },
      o = { "<cmd>Octo issue reopen<cr>", "Reopen" },
      a = {
        name = "Assignee",
        a = { "<cmd>Octo assignee add<cr>", "Add assignee" },
        d = { "<cmd>Octo assignee remove<cr>", "Remove assignee" },
      },
      b = {
        name = "Label",
        a = { "<cmd>Octo label add<cr>", "Add label" },
        d = { "<cmd>Octo label remove<cr>", "Remove label" },
        c = { "<cmd>Octo label create<cr>", "Create label" },
      },
    },
    p = {
      name = "Pull Requests",
      l = { "<cmd>Octo pr list<cr>", "List" },
      o = { "<cmd>Octo pr checkout<cr>", "Checkout" },
      M = { "<cmd>Octo pr merge<cr>", "Merge" },
      c = { "<cmd>Octo pr commits<cr>", "Commits" },
      f = { "<cmd>Octo pr changes<cr>", "Changed files" },
      d = { "<cmd>Octo pr diff<cr>", "Diff" },
      r = {
        name = "Review",
        s = { "<cmd>Octo review start<cr>", "Start", },
        f = { "<cmd>Octo review submit<cr>", "Submit" },
        c = { "<cmd>Octo review close<cr>", "Close" },
        d = { "<cmd>Octo review discard<cr>", "Discard" },
        u = { "<cmd>Octo review resume<cr>", "Resume" },
        m = { "<cmd>Octo review comments<cr>", "Comments" },
        a = { "<cmd>lua require'octo.mappings'.on_keypress('add_review_comment')<cr>", "Add review comment" },
        e = { "<cmd>lua require'octo.mappings'.on_keypress('focus_files')<cr>", "Focus files" },
        b = { "<cmd>lua require'octo.mappings'.on_keypress('toggle_files')<cr>", "Toggle files" },
        v = { "<cmd>lua require'octo.mappings'.on_keypress('toggle_viewed')<cr>", "Toggle viewed" },
      },
      v = {
        name = "Reviewers",
        a = { "<cmd>lua require'octo.mappings'.on_keypress('add_reviewer')<cr>", "Add" },
        d = { "<cmd>lua require'octo.mappings'.on_keypress('remove_reviewer')<cr>", "Remove" },
      },
      a = {
        name = "Assignee",
        a = { "<cmd>Octo assignee add<cr>", "Add assignee" },
        d = { "<cmd>Octo assignee remove<cr>", "Remove assignee" },
      },
      b = {
        name = "Label",
        a = { "<cmd>Octo label add<cr>", "Add label" },
        d = { "<cmd>Octo label remove<cr>", "Remove label" },
        c = { "<cmd>Octo label create<cr>", "Create label" },
      },
    },
    c = {
      name = "Comments",
      a = { "<cmd>Octo comment add<cr>", "Add comment" },
      d = { "<cmd>Octo comment remove<cr>", "Remove comment" },
    },
    r = {
      name = "Reactions",
      p = { "<cmd>Octo reaction hooray<cr>", "Hooray" },
      h = { "<cmd>Octo reaction heart<cr>", "Heart" },
      e = { "<cmd>Octo reaction eyes<cr>", "Eyes" },
      u = { "<cmd>Octo reaction thumbs_up<cr>", "Thumbs up" },
      d = { "<cmd>Octo reaction thumbs_down<cr>", "Thumbs down" },
      r = { "<cmd>Octo reaction rocket<cr>", "Rocket" },
      l = { "<cmd>Octo reaction laugh<cr>", "Laugh" },
      c = { "<cmd>Octo reaction confused<cr>", "Confused" },
    },
  }

  -- If the user provides key bindings: use only the user bindings.
  if user_config.mappings then
    M._config.mappings.issue = (user_config.mappings.issue or M._config.mappings.issue)
    M._config.mappings.pull_request = (user_config.mappings.pull_request or M._config.mappings.pull_request)
    M._config.mappings.review_thread = (user_config.mappings.review_thread or M._config.mappings.review_thread)
    M._config.mappings.review = (user_config.mappings.review or M._config.mappings.review)
    M._config.mappings.file_panel = (user_config.mappings.file_panel or M._config.mappings.file_panel)
  end

end

return M
