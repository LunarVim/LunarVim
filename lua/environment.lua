lv_base = vim.fn.stdpath('config')
lv_global = false
if os.getenv('LV_BASE') then
	lv_global = true
	lv_base = os.getenv('LV_BASE') .. '/nvim'
end

