---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by ginne.
--- DateTime: 2020/3/17 09:44
---
local _M = {}
function _M.STP(x,y)
    local basic = require("matrixbasic")
    local x2 = x:size()[2]
    local y1 = y:size()[1]
    local t = basic.lcm(x2,y1)
    local In = torch.eye(t/x2)
    local Ip = torch.eye(t/y1)
    return (basic.Kronecker(x,In)*basic.Kronecker(y,Ip))
end
return _M





