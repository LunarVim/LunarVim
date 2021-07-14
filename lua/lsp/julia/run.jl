# Load LanguageServer from the project next to this file
## Save old load path
old_load_path = copy(LOAD_PATH)
push!(empty!(LOAD_PATH), @__DIR__)
## Load packages
using LanguageServer, SymbolServer
## Restore old load path
append!(empty!(LOAD_PATH), old_load_path)

# Figure out the active project
## This works if you are *not* using a Pkg.activate based workflow
## e.g. if you set up LOAD_PATH manually or set JULIA_PROJECT=@. in
## .bashrc or equivalent
project_path = Base.active_project()
## This works if you are using a Pkg.activated based workflow
# project_path = something(Base.current_project(pwd()), Base.active_project())

# Depot path for the server to index
depot_path = get(ENV, "JULIA_DEPOT_PATH", "")

# Start the server
@info "Running julia language server" project_path depot_path
server = LanguageServer.LanguageServerInstance(stdin, stdout, project_path, depot_path)
server.runlinter = true
run(server)
