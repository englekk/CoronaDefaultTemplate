-- local DeviceInfo = require("wonhada.utils.DeviceInfo")

local Class = {}

--Class.defaultFont = (DeviceInfo.isiOS and "712serif.ttf" or "DroidSansMono")
Class.defaultFont = native.systemFont
-- Class.colorIndexFont = "droidsansmono.ttf" -- "712serif.ttf"

--[[
-- iOS용 폰트 찾기
local fonts = native.getFontNames()

local name = "맑은"     -- ttf 파일의 앞 문자를 넣으면 됩니다. mal은 malgun.ttf를 찾기 위해 사용. iOS는 MalgunGothic.

name = string.lower( name )
local fontNames = ""

-- Display each font in the terminal console
for i, fontname in ipairs(fonts) do
	j, k = string.find( string.lower( fontname ), name )
	if( j ~= nil ) then
		print( "fontname = " .. tostring( fontname ) )
		fontNames = fontNames..tostring( fontname )..", "
	end
end
native.showAlert(tostring(fontNames), "", "")
]]

return Class