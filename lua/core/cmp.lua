local M = {}

local check_backspace = function()
  local col = vim.fn.col "." - 1
  return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
end

local function T(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local is_emmet_active = function()
  local clients = vim.lsp.buf_get_clients()

  for _, client in pairs(clients) do
    if client.name == "emmet_ls" then
      return true
    end
  end
  return false
end

M.config = function()
  local status_cmp_ok, cmp = pcall(require, "cmp")
  if not status_cmp_ok then
    return
  end
  local status_luasnip_ok, luasnip = pcall(require, "luasnip")
  if not status_luasnip_ok then
    return
  end
  local current_buf = vim.api.nvim_get_current_buf
  local win_get_cursor = vim.api.nvim_win_get_cursor

  local function inside_snippet()
    if not luasnip.session.current_nodes then
      return false
    end

    local node = luasnip.session.current_nodes[current_buf()]
    if not node then
      return false
    end

    local snip_begin_pos, snip_end_pos = node.parent.snippet.mark:pos_begin_end()
    local pos = win_get_cursor(0)
    return pos[1] >= snip_begin_pos[1] and pos[1] <= snip_end_pos[1]
  end

  lvim.builtin.cmp = {
    confirm_opts = {
      behavior = cmp.ConfirmBehavior.Replace,
      select = false,
    },
    experimental = {
      ghost_text = false,
      native_menu = true,
    },
    formatting = {
      kind_icons = {
        Class = " ",
        Color = " ",
        Constant = "ﲀ ",
        Constructor = " ",
        Enum = "練",
        EnumMember = " ",
        Event = " ",
        Field = " ",
        File = "",
        Folder = " ",
        Function = " ",
        Interface = "ﰮ ",
        Keyword = " ",
        Method = " ",
        Module = " ",
        Operator = "",
        Property = " ",
        Reference = " ",
        Snippet = " ",
        Struct = " ",
        Text = " ",
        TypeParameter = " ",
        Unit = "塞",
        Value = " ",
        Variable = " ",
      },
      format = function(entry, vim_item)
        vim_item.kind = lvim.builtin.cmp.formatting.kind_icons[vim_item.kind]
        vim_item.menu = ({
          nvim_lsp = "(LSP)",
          emoji = "(Emoji)",
          path = "(Path)",
          calc = "(Calc)",
          cmp_tabnine = "(Tabnine)",
          vsnip = "(Snippet)",
          luasnip = "(Snippet)",
          buffer = "(Buffer)",
        })[entry.source.name]
        vim_item.dup = ({
          buffer = 1,
          path = 1,
          nvim_lsp = 0,
        })[entry.source.name] or 0
        return vim_item
      end,
    },
    snippet = {
      expand = function(args)
        require("luasnip").lsp_expand(args.body)
      end,
    },
    documentation = {
      border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
    },
    sources = {
      { name = "nvim_lsp" },
      { name = "path" },
      { name = "luasnip" },
      { name = "cmp_tabnine" },
      { name = "nvim_lua" },
      { name = "buffer" },
      { name = "calc" },
      { name = "emoji" },
      { name = "treesitter" },
      { name = "crates" },
    },
    mapping = {
      ["<C-d>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      -- TODO: potentially fix emmet nonsense
      ["<Tab>"] = cmp.mapping(function()
        if vim.fn.pumvisible() == 1 then
          vim.fn.feedkeys(T "<down>", "n")
        elseif luasnip.expandable() or (inside_snippet() and luasnip.jumpable()) then
          vim.fn.feedkeys(T "<Plug>luasnip-expand-or-jump", "")
        elseif check_backspace() then
          vim.fn.feedkeys(T "<Tab>", "n")
        elseif is_emmet_active() then
          return vim.fn["cmp#complete"]()
        else
          vim.fn.feedkeys(T "<Tab>", "n")
        end
      end, {
        "i",
        "s",
      }),
      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if vim.fn.pumvisible() == 1 then
          vim.fn.feedkeys(T "<up>", "n")
        elseif inside_snippet() and luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, {
        "i",
        "s",
      }),

      ["<C-Space>"] = cmp.mapping.complete(),
      ["<C-e>"] = cmp.mapping.close(),
      ["<CR>"] = cmp.mapping(function(fallback)
        if vim.fn.pumvisible() ~= 0 and cmp.confirm(lvim.builtin.cmp.confirm_opts) then
          return
        end

        if inside_snippet() and luasnip.jumpable() then
          luasnip.jump(1)
        else
          fallback()
        end
      end),
    },
  }
end

M.setup = function()
  require("luasnip/loaders/from_vscode").lazy_load()
  require("cmp").setup(lvim.builtin.cmp)
end

return M
