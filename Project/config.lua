----------------------------------------
-- 이 주석은 삭제하지 마세요.
-- 35% 할인해 드립니다. 코로나 계정 유료 구매시 연락주세요. (Corona SDK, Enterprise, Cards)
-- @Author 아폴로케이션 원강민 대표
-- @Website http://WonHaDa.com, http://Apollocation.com, http://CoronaLabs.kr
-- @E-mail englekk@naver.com, englekk@apollocation.com
-- 'John 3:16, Psalm 23'
-- MIT License :: WonHada Library에 한정되며, 라이선스와 저작권 관련 명시만 지켜주면 되는 라이선스
----------------------------------------

-- !!! 아직 테스트가 충분하지 않지만 나쁘지 않은 것 같아서 적용합니다. 문제가 있다면 config.lua_bak 파일로 교체하시고 피드백(englekk@naver.com) 부탁드립니다.

-- SmartPixel config.lua
-- GitHub: https://github.com/Lerg/smartpixel-config-lua

if not display then return end -- 데스크탑용 앱은 사용안함

local w, h = display.pixelWidth, display.pixelHeight

local modes = {1, 1.5, 2, 3, 4, 6, 8} -- Scaling factors to try
local contentW, contentH = 320, 480   -- Minimal size your content can fit in

-- Try each mode and find the best one
local _w, _h, _m = w, h, 1
for i = 1, #modes do
    local m = modes[i]
    local lw, lh = w / m, h / m
    if lw < contentW or lh < contentH then
        break
    else
        _w, _h, _m = lw, lh, m
    end
end
-- If scaling is not pixel perfect (between 1 and 2) - use letterbox
if _m < 2 then
    local scale = math.max(contentW / w, contentH / h)
    _w, _h = w * scale, h * scale
end

application = {
    content = {
        width = _w,
        height = _h,
        scale = 'letterbox',
        audioPlayFrequency = 44100, -- 11025, 22050, 44100: 높을수록 고음질
        fps = 60,
        imageSuffix = {
            ['@2x'] = 1.1,
            ['@4x'] = 2.1,
        }
    },
    --[[notification =
    {
      iphone =
      {
        types =
        {
          "badge", "sound", "alert"
        }
      },
      google =
      {
        projectNumber = "000000000000"
      },
    }]]
}