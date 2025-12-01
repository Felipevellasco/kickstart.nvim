local env = require 'felipe.core.globals'

-- Copy lambdas: set copy to use osc52 if no clipboard is detected
local vCopy = (env.isSSH or not env.clipboard) and function()
  require('osc52').copy_visual()
end or function()
  vim.cmd 'normal! "+y'
end

-- Copy operator lambda
local nCopy = (env.isSSH or not env.clipboard) and function()
  require('osc52').copy()
end or function()
  vim.cmd 'normal! "+yy'
end

-- Mapping helpers
local function map(mode, keys, action, options)
  vim.keymap.set(mode, keys, action, options)
end

local function nmap(keys, action, options)
  map('n', keys, action, options)
end

local function vmap(keys, action, options)
  map('v', keys, action, options)
end

local function imap(keys, action, options)
  map('i', keys, action, options)
end

-- NOTE: Mappings begin here

-- Clipboard integration
nmap('\\yy', nCopy, { desc = '[Y]ank to clipboard' })
vmap('\\y', vCopy, { desc = '[Y]ank selection to clipboard' })

-- Esc remapping
imap('jk', '<Esc>', { desc = 'Return to normal mode', silent = true })
