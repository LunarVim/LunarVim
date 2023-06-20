local M = {}

local _ = require "mason-core.functional"
local null_ls_utils = require "lvim.lsp.null-ls.util"
local Log = require "lvim.core.log"
local fmt = string.format

---Takes a map of null-ls methods mapped to a table of sources and transforms supported
---sources into a functional mason package.
---
---@generic T: table, K:string, V:table<string>, M:Package|string
---@param null_ls_builtins T<K,V>
---@return T<K,T<M>>
local function get_mason_packages_or_null_ls_sources(null_ls_builtins)
  local null_ls_methods = require("lvim.lsp.null-ls._meta").method_bridge()
  local res = {}

  for method, sources in pairs(null_ls_builtins) do
    local collection = {}
    for _, source in pairs(sources) do
      null_ls_utils
        .resolve_null_ls_package_from_mason(source)
        :if_present(function(package)
          table.insert(collection, package)
        end)
        :or_else_get(function()
          table.insert(collection, source)
        end)
    end
    res[null_ls_methods[method]] = collection
  end

  return res
end

---Mason packages won't be rosolved in this function except packages that where defined by the user. So
---ideally you should already have resolved all possible mason packages for a given `ft_builtins` if you
---want them to take preredence in the selection.
---
---Selects the option for each null-ls method for a given `ft_builtins` by the following criteria:
---
---- User provided options (its entirely the users responsibility to maintain the specified source). If the
--- source is found as a package in the mason registry that package will be used unless the user provides a
--- installation spec for the package. The plain old source will be used when both of these options fail
---- Available mason packages or custom packages(Optional)
---- Common sources between different methods (if there is a source listed in multiple methods of a filetype that source will be selected for all methods that list the source)
---- The first available option of a method
---
---See the source for what is possible: https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/lua/null-ls/builtins/_meta/filetype_map.lua
---@generic T: table, K:string, V:table<string>, M:Package|string
---@param ft string
---@param ft_builtins T<K,T<K,table<M>>>
---@return T<K,T<K,M>>
local function select_null_ls_sources(ft, ft_builtins)
  local _ = require "mason-core.functional"
  local null_ls_methods = require("lvim.lsp.null-ls._meta").method_bridge()
  local selection = {}

  local ok_provided, provided = pcall(require, "lvim.lsp.null-ls.providers." .. ft .. ".lua")
  if ok_provided and provided.methods then
    selection = get_mason_packages_or_null_ls_sources(provided.methods)
  end

  null_ls_utils.disassociate_selection_from_input(selection, ft_builtins)

  local sorted_selection = null_ls_utils.source_selection_sort(ft_builtins)

  for method, sources in pairs(sorted_selection) do
    selection[null_ls_methods[method]] = sources[1]
  end

  return selection
end

---Register all available null-ls builtins for a given filetype and install their corresponding mason package.
---@param filetype any
function M.setup(filetype, lsp_server)
  vim.validate { name = { filetype, "string" } }
  vim.validate { name = { lsp_server, "string" } }

  local ft_map = require("lvim.lsp.null-ls._meta").ft_bridge()
  local null_ls_builtins = ft_map[filetype]

  local method_to_package_info = get_mason_packages_or_null_ls_sources(null_ls_builtins)
  local selection = select_null_ls_sources(filetype, method_to_package_info)

  for method, source in pairs(selection) do
    null_ls_utils.register_sources_on_ft(method, null_ls_utils.try_install_mason_package(source))
  end

  Log:debug(
    fmt(
      "Finished setting up null-ls sources for the filetype '%s'. Sources are attached to the lsp server '%s'.",
      filetype,
      lsp_server
    )
  )
end

return M
