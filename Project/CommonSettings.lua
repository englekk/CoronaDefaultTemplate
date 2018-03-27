----------------------------------------
-- 이 주석은 삭제하지 마세요.
-- 35% 할인해 드립니다. 코로나 계정 유료 구매시 연락주세요. (Corona SDK, Enterprise, Cards)
-- @Author 아폴로케이션 원강민 대표
-- @Website http://WonHaDa.com, http://Apollocation.com, http://CoronaLabs.kr
-- @E-mail englekk@naver.com, englekk@apollocation.com
-- 'John 3:16, Psalm 23'
-- MIT License :: WonHada Library에 한정되며, 라이선스와 저작권 관련 명시만 지켜주면 되는 라이선스
----------------------------------------

--[[
	개발 편의를 위한 Global 변수들
	__appContentWidth__ -- application.content.width
	__appContentHeight__ -- application.content.height
	__isSimulator__ -- 시뮬레이터에서 실행중인지 여부
]]

__isSimulator__ = system.getInfo("environment") == "simulator"

-- is iPhone X?
local architectureInfo = system.getInfo("architectureInfo")
local isiPhoneX = ( string.find( architectureInfo, "iPhone10,3" ) ~= nil ) or ( string.find( architectureInfo, "iPhone10,6" ) ~= nil )
if __isSimulator__ then
    local width = math.floor((display.actualContentWidth/display.contentScaleX)+0.5)
    local height = math.floor((display.actualContentHeight/display.contentScaleY)+0.5)
    local wh = string.format("%d_%d", width, height )
    isiPhoneX = (wh == "1125_2436")
end

local statusBarType = display.DefaultStatusBar
__setStatusBar = function (mode)
    statusBarType = mode
    display.setStatusBar(mode)
end
__getStatusBar = function ()
    return statusBarType
end

-- TODO: 첫 상태바 모드 설정
__setStatusBar(display.HiddenStatusBar)

__getStatusBarHeight = function ()
    if statusBarType == display.HiddenStatusBar then
        return 0
    end
    
    return display.topStatusBarContentHeight
end

__useSafeArea__ = true -- iPhone X를 위한 전역 변수
if not isiPhoneX then __useSafeArea__ = false end

--====================================--
-- 주의!! 아래 코드부터 수정하지 마세요.
-- App의 너비, 높이
local topInset, leftInset, bottomInset, rightInset = display.getSafeAreaInsets()
__safeAreaInsets__ = {top=topInset, left=leftInset, bottom=bottomInset, right=rightInset}
__appContentWidth__ = (__useSafeArea__ and display.safeActualContentWidth or display.actualContentWidth)
__appContentHeight__ = (__useSafeArea__ and display.safeActualContentHeight or display.actualContentHeight)
__scaleFactor__ = math.floor((__appContentWidth__ / 1080) * 1000) / 1000 -- fhd는 1080(0.5), 모든 크기의 기준이 되는 비율 기준값
__setScaleFactor = function (obj, ratio)
	ratio = ratio or __scaleFactor__
	obj.width, obj.height = math.round(obj.width * ratio), math.round(obj.height * ratio)
end

__isNilObject = function (obj)
    return (obj == nil or obj.parent == nil)
end

__applyScale = function (obj, targetPxSize, widthBase)
    if __isNilObject(obj) then return end
    
    if widthBase == nil then widthBase = true end -- 가로 기준
    
    local sf = targetPxSize / (widthBase and obj.width or obj.height) -- scaleFactor
    sf = math.round(sf * 10000) / 10000
    obj.xScale = sf
    obj.yScale = sf
end
--====================================--

__activityIndicatorState = false
__setActivityIndicator = function (state)
    if state and __activityIndicatorState then return end
    if (not state) and (not __activityIndicatorState) then return end
    
    native.setActivityIndicator(state)
    __activityIndicatorState = state
end

-- Global 변수값 확인
-- print(__appContentWidth__, __appContentHeight__, __isSimulator__)

-- 앵커포인트 좌상단으로 세팅
display.setDefault( "anchorX", 0 )
display.setDefault( "anchorY", 0 )

math.randomseed(os.time())