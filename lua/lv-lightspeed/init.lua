local M = {}

M.config = function()
  require("lightspeed").setup {
    jump_to_first_match = true,
    jump_on_partial_input_safety_timeout = 400,
    highlight_unique_chars = true,
    grey_out_search_area = true,
    match_only_the_start_of_same_char_seqs = true,
    limit_ft_matches = 5,
    full_inclusive_prefix_key = "<c-x>",
    -- By default, the values of these will be decided at runtime,
    -- based on `jump_to_first_match`
    -- labels = O.hint_labels,
    cycle_group_fwd_key = nil,
    cycle_group_bwd_key = nil,
  }
end

return M
