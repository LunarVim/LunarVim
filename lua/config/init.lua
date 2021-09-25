local M = {}

--- Initialize lvim default configuration
-- Define lvim global variable
function M:init(opts)
  opts = opts or {}
  self.path = opts.path
  local utils = require "utils"

  require "config.defaults"

  -- Fallback config.lua to lv-config.lua
  if not utils.is_file(self.path) then
    local lv_config = self.path:gsub("config.lua$", "lv-config.lua")
    print(self.path, "not found, falling back to", lv_config)

    self.path = lv_config
  end

  local builtins = require "core.builtins"
  builtins.config(self)

  local settings = require "config.settings"
  settings.load_options()

  local lvim_lsp_config = require "lsp.config"
  lvim.lsp = vim.deepcopy(lvim_lsp_config)

  local supported_languages = {
    "asm",
    "bash",
    "beancount",
    "bibtex",
    "bicep",
    "c",
    "c_sharp",
    "clojure",
    "cmake",
    "comment",
    "commonlisp",
    "cpp",
    "crystal",
    "cs",
    "css",
    "cuda",
    "d",
    "dart",
    "dockerfile",
    "dot",
    "elixir",
    "elm",
    "emmet",
    "erlang",
    "fennel",
    "fish",
    "fortran",
    "gdscript",
    "glimmer",
    "go",
    "gomod",
    "graphql",
    "haskell",
    "hcl",
    "heex",
    "html",
    "java",
    "javascript",
    "javascriptreact",
    "jsdoc",
    "json",
    "json5",
    "jsonc",
    "julia",
    "kotlin",
    "latex",
    "ledger",
    "less",
    "lua",
    "markdown",
    "nginx",
    "nix",
    "ocaml",
    "ocaml_interface",
    "perl",
    "php",
    "pioasm",
    "ps1",
    "puppet",
    "python",
    "ql",
    "query",
    "r",
    "regex",
    "rst",
    "ruby",
    "rust",
    "scala",
    "scss",
    "sh",
    "solidity",
    "sparql",
    "sql",
    "supercollider",
    "surface",
    "svelte",
    "swift",
    "tailwindcss",
    "terraform",
    "tex",
    "tlaplus",
    "toml",
    "tsx",
    "turtle",
    "typescript",
    "typescriptreact",
    "verilog",
    "vim",
    "vue",
    "yaml",
    "yang",
    "zig",
  }

  require("lsp.manager").init_defaults(supported_languages)
end

--- Override the configuration with a user provided one
-- @param config_path The path to the configuration overrides
function M:load(config_path)
  local autocmds = require "core.autocmds"

  config_path = config_path or self.path
  local ok, err = pcall(vim.cmd, "luafile " .. config_path)
  if not ok then
    print("Invalid configuration", config_path)
    print(err)
    return
  end

  self.path = config_path

  autocmds.define_augroups(lvim.autocommands)

  local settings = require "config.settings"
  settings.load_commands()
end

return M
