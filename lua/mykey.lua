local   old_keymap_set = vim.keymap.set
local   old_keymap_set_buf = vim.api.nvim_buf_set_keymap
keymap_key = nil 
keymap_mode = nil 
keymap_function = nil
keymap_opts = nil 

local autocmd_handler = function(mode, mapkey, func, opts)
   keymap_key = mapkey
   keymap_mode = mode
   keymap_function = func
   keymap_opts = opts
   vim.cmd('do <nomodeline> User keymap')
end

local autocmd_handler_buf = function(_,mode, mapkey, func, opts)
   autocmd_handler(mode,mapkey,func,opts)
end

local mykey = '<tab>'
vim.api.nvim_create_autocmd({"User"}, {
   pattern = "keymap",
   callback = function()
         old_keymap_set_buf(0,'i',mykey,mykey,{})
   end,
})

vim.keymap.set = function(...)
   autocmd_handler(...)
   old_keymap_set(...)
end

vim.api.nvim_buf_set_keymap = function(...)
   autocmd_handler_buf(...)
   old_keymap_set_buf(...)
end
M = {}
M.setup = function (key)
   mykey = key
end

return M
