
--[[
                                                  
     Licensed under GNU General Public License v2 
      * (c) 2013,      Luke Bonham                
      * (c) 2010-2012, Peter Hofmann              
                                                  
--]]

local newtimer        = require("lain.helpers").newtimer

local wibox           = require("wibox")

local util            = require("lain.util")

local io              = io
local os              = { getenv = os.getenv }
local pairs           = pairs
local string          = { len    = string.len,
                          match  = string.match }
local table           = { sort   = table.sort }

local setmetatable    = setmetatable

-- Maildir check
-- lain.widgets.maildir
local maildir = {}

local function worker(args)
    local args         = args or {}
    local timeout      = args.timeout or 60
    local mailbox     = args.mailbox or os.getenv("HOME") .. "/mail/INBOX/new"
    local ignore_boxes = args.ignore_boxes or {}
    local settings     = args.settings or function() end

    maildir.widget = wibox.widget.textbox('')

    function update()
        local p = io.popen("ls " .. mailbox ..
						   "| wc -l")
		newmail = p:read("*all")

        widget = maildir.widget
		settings()
    end

    newtimer(maildir, timeout, update, true)
    return maildir.widget
end

return setmetatable(maildir, { __call = function(_, ...) return worker(...) end })
