local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end
telescope.setup(O.plugin.telescope)
