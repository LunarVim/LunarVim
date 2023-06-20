local M = {}

local Log = require "lvim.core.log"
local _ = require "mason-core.functional"
local fmt = string.format
local null_ls = require("null-ls")

local FORMATTING = null_ls.methods.FORMATTING
local DIAGNOSTICS = null_ls.methods.DIAGNOSTICS
local CODE_ACTION = null_ls.methods.CODE_ACTION

---Checks whether a given `source` is a mason package.
---@param source table|string
function M.is_package(source)
    if type(source) == "table" and source.name then
        return tostring(source) == fmt("Package(name=%s)", source.name)
    end
    return false
end

---Returns an Optional mason package either from the mason registry or creates a new mason package with
---a provided spec.
---
---For more information to custom package hangle, see: https://github.com/williamboman/mason.nvim/blob/main/lua/mason-core/package/init.lua
---@param null_ls_source_name Package|string
---@return Package|nil
function M.resolve_null_ls_package_from_mason(null_ls_source_name)
    -- taken from mason-null-ls and modified
    -- https://github.com/jay-babu/mason-null-ls.nvim/blob/main/lua/mason-null-ls/automatic_installation.lua

    local Optional = require('mason-core.optional')
    local source_mappings = require('mason-null-ls.mappings.source')
    local registry = require('mason-registry')

    return Optional.of_nilable(source_mappings.getPackageFromNullLs(null_ls_source_name)):map(function(package_name)
        if not registry.has_package(package_name) then
            Log:warn(fmt("The null-ls source '%s' is not supported by mason.", null_ls_source_name))
        end

        ---@diagnostic disable-next-line: param-type-mismatch
        local custom_is_defined, custom_pkg = M.register_custom_mason_package(null_ls_source_name)
        if custom_is_defined then
            return custom_pkg
        end

        local ok, pkg = pcall(registry.get_package, package_name)
        if ok then
            return pkg
        end

        if not custom_is_defined then
            return nil
        end
    end)
end

---Based on a given `method` a given `source` will be registered.
---@param method string
---@param source string|Package
---@return boolean|nil
function M.register_sources_on_ft(method, source)
    local null_ls_methods = require("lvim.lsp.null-ls._meta").method_bridge()
    local source_options = {}
    if not M.is_package(source) then
        local _, provided = pcall(require, "lvim.lsp.null-ls.sources." .. source)
        source_options = provided.settings or {}
    else
        source = source.name
    end

    source_options["name"] = source

    local kind = nil
    if null_ls_methods[method] == CODE_ACTION then
        kind = require("lvim.lsp.null-ls.code_actions")
    elseif null_ls_methods[method] == FORMATTING then
        kind = require("lvim.lsp.null-ls.formatters")
    elseif null_ls_methods[method] == DIAGNOSTICS then
        kind = require("lvim.lsp.null-ls.linters")
    else
        Log:error(fmt("The method '%s' is not a valid null-ls method.", method))
        return kind
    end

    -- we need to pase this as a table itself to stay compatible with the service.register_sources(configs, method)
    kind.setup({ source_options })
    return true
end

---Attempts to install a mason package for a given `source`. If no mason package could be resolved the
---`source` will be returned. Otherwise returns a mason package.
---@param source Package|string
---@return Package|string
function M.try_install_mason_package(source)
    local null_ls_client = require("null-ls.client")
    local registry = require('mason-registry')
    local mason_null_ls_mapping = require("mason-null-ls.mappings.source")
    ---@class Package
    ---@field is_installed function
    ---@field install function
    ---@field name string
    ---@param package Package
    local function install_package(package)
        if not package:is_installed() then
            Log:debug(fmt("Automatically installing '%s' by the mason package '%s'.", source, package.name))
            package:install():once(
                'closed',
                vim.schedule_wrap(function()
                    if registry.is_installed(package.name) then
                        Log:info(fmt("Installed '%s' by the mason package '%s'.", source, package.name))
                        null_ls_client.retry_add()
                        Log:info(fmt("Reattached '%s' to lsp buffer.", package.name))
                    else
                        Log:warn(fmt(
                            "Installation of '%s' by the mason package '%s' failed. Consult mason logs.",
                            source,
                            package.name))
                    end
                end)
            )
        end
    end

    if M.is_package(source) then
        ---@diagnostic disable-next-line: param-type-mismatch
        install_package(source)
        return mason_null_ls_mapping.getNullLsFromPackage(source.name)
    end

    return M.resolve_null_ls_package_from_mason(source):if_present(function(package)
        install_package(package)
    end):or_else(source)
end

---Register a custom mason package with a spec provided by the user.
---@param null_ls_source_name string
---@return boolean
---@return Package|nil
function M.register_custom_mason_package(null_ls_source_name)
    ---@class Package
    ---@field new function
    local Package = require "mason-core.package"
    local _ok, source_package_spec = pcall(require, "lvim.lsp.null-ls.packages." .. null_ls_source_name)
    if _ok then
        Log:debug(fmt(
            "A custom mason package '%s' was instanciated from the source '%s' that will be used for installation.",
            source_package_spec.name, null_ls_source_name))
        local pkg_ok, pkg = pcall(Package.new, source_package_spec)
        if pkg_ok then
            return pkg_ok, pkg
        end
    end
    return false, nil
end

---Ensures that only methods will be processed that are not selected yet
---@generic T: table, K:string, V:table<string>, M:Package|string
---@param selection T<K, V>
---@param ft_builtins T<K,T<K,table<M>>>
function M.disassociate_selection_from_input(selection, ft_builtins)
    for method, _ in pairs(ft_builtins) do
        if selection[method] then
            ft_builtins[method] = nil
        end
    end
end

---Takes a given `ft_builtins` table and inverts it so that sources are
---mapped to a set view of unique methods where they are available.
---@generic T: table, K:string, V:table<string>, M:Package|string
---@param ft_builtins T<K,T<K,table<M>>>
---@return T<M,T<K>>
function M.invert_method_to_sources_map(ft_builtins)
    local inverted = {}

    for method, sources in pairs(ft_builtins) do
        for _, source in pairs(sources) do
            if not inverted[source] then
                inverted[source] = { method }
            else
                if not _.any(function(e) return method == e end, inverted[source]) then
                    table.insert(inverted[source], method)
                end
            end
        end
    end
    return inverted
end

---Computes a score for a source of a method. Valid mason packages rank higher than non mason
---packages. The base score of the `source` will be multiplied with the `source_amount`. The `priority`
---is added to the overall score.
---@param source Package|string valid mason package or just a string
---@param source_amount number the amount of appearances of a source across all methods
---@param priority number the first `source` has a higher priority than the last
---@return number score the computed score
function M.compute_score_of_source(source, source_amount, priority)
    local scores = { package = 10, string = 2 }
    local score = M.is_package(source) and scores.package or scores.string
    return score * source_amount + priority
end

---Takes a given `ft_builtins` table and computes a score for each source of a method table.
---@generic T: table, K:string, V:table<string>, M:Package|string
---@param ft_builtins T<K,T<K,table<M>>> to determine the amount of appearances from methods
---@return T<string, T<number>>, T<string, T<number, M>>
function M.compute_ft_builtins_score(ft_builtins)
    local sources_to_amounts = {} ---@type table<string|Package, number>
    local method_to_scores = {}
    local method_to_score_to_source = {}

    for _, sources in pairs(ft_builtins) do
        for _, source in pairs(sources) do
            if not sources_to_amounts[source] then
                sources_to_amounts[source] = 1
            else
                sources_to_amounts[source] = sources_to_amounts[source] + 1
            end
        end
    end

    for method, sources in pairs(ft_builtins) do
        local score
        local computed_scores = {}
        local score_to_source = {}
        local source_count = #sources
        for _, source in pairs(sources) do
            local source_amount = sources_to_amounts[source] ---@type number
            score = M.compute_score_of_source(source, source_amount, source_count)
            table.insert(computed_scores, score)
            score_to_source[score] = source
            source_count = source_count - 1
        end
        method_to_scores[method] = computed_scores
        method_to_score_to_source[method] = score_to_source
    end

    return method_to_scores, method_to_score_to_source
end

---Selection sort that sorts a given list of `computed_scores` from highest to lowest.
---@param computed_scores table<number>
local function selection_sort(computed_scores)
    for i = #computed_scores, 1, -1 do
        local max_num = computed_scores[i]
        local max_index = i
        for j = 1, #computed_scores, 1 do
            if computed_scores[j] > max_num then
                max_num = computed_scores[j]
                max_index = j
            end
        end
        if max_num > computed_scores[i] then
            local temp = computed_scores[i]
            computed_scores[i] = computed_scores[max_index]
            computed_scores[max_index] = temp
        end
    end
end

---Greatest `k` selection sort for sources.
---@generic T: table, K:string, V:table<string>, M:Package|string
---@param ft_builtins T<K,T<K,table<M>>> to determine the amount of appearances from methods
---@return T<K, T<M>>
function M.source_selection_sort(ft_builtins)
    local sorted_ft_builtins = {}

    local method_to_scores, method_to_score_to_source =
        M.compute_ft_builtins_score(
            ft_builtins
        )

    for method, scores in pairs(method_to_scores) do
        selection_sort(scores)
        Log:debug(fmt("[lvim-null-ls] The sorted scores for '%s' are '%s'", method, vim.inspect(scores)))
    end

    for method, sorted_scores in pairs(method_to_scores) do
        local sorted_sources = {}
        for _, score in pairs(sorted_scores) do
            table.insert(sorted_sources, method_to_score_to_source[method][score])
        end
        sorted_ft_builtins[method] = sorted_sources
    end

    return sorted_ft_builtins
end

return M
