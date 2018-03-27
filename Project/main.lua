----------------------------------------
-- 이 주석은 삭제하지 마세요.
-- 35% 할인해 드립니다. 코로나 계정 유료 구매시 연락주세요. (Corona SDK, Enterprise, Cards)
-- @Author 아폴로케이션 원강민 대표
-- @Website http://WonHaDa.com, http://Apollocation.com, http://CoronaLabs.kr
-- @E-mail englekk@naver.com, englekk@apollocation.com
-- 'John 3:16, Psalm 23'
-- MIT License :: WonHada Library에 한정되며, 라이선스와 저작권 관련 명시만 지켜주면 되는 라이선스
----------------------------------------

---------------------------------
-- 기본 세팅
-- __statusBarHeight__ : 상단 StatusBar의 높이
-- __appContentWidth__ : App의 너비
-- __appContentHeight__ : App의 높이
-- 앵커포인트는 좌상단 
---------------------------------

require("CommonSettings")

--[[local SQLiteManager = require("wonhada.managers.SQLiteManager")
local FileUtils = require("wonhada.utils.FileUtils")
local DeviceInfo = require("wonhada.utils.DeviceInfo")]]

--========== Config DB 접속 및 초기화 Begin ==========--
-- Config DB 접속 (없으면 생성)
--[[SQLiteManager.useConfigDB("ConfigData.db", system.DocumentsDirectory)

-- local isFirstInstalled = (SQLiteManager.getConfig("coin") == nil)

-- Config DB 데이터 초기화
-- SQLiteManager.initConfig("coin", 0)]]
--========== Config DB 접속 및 초기화 End ==========--

--=====================--
-- tmp 폴더의 모든 파일 삭제
--[[FileUtils.deleteAllFiles(system.TemporaryDirectory, false)

-- 필요한 폴더들 생성
-- FileUtils.createDirectory(system.pathForFile("assets", system.DocumentsDirectory))
-- FileUtils.createDirectory(system.pathForFile("cate", system.DocumentsDirectory))
-- FileUtils.createDirectory(system.pathForFile("img", system.DocumentsDirectory))
-- FileUtils.createDirectory(system.pathForFile("thumb", system.DocumentsDirectory))
-- FileUtils.createDirectory(system.pathForFile("save", system.DocumentsDirectory))
]]
--=====================--

--=====================--
-- 푸시 노티피케이션: {"gcm.n.e":"1","aps":{"alert":{"title":"4444","body":"test"}},"google.c.a.e":"1","gcm.message_id":"0:1516010244154055%9c6ca6f99c6ca6f9","google.c.a.c_l":"1111","google.c.a.udt":"0","google.c.a.ts":"1516010243","google.c.a.c_id":"1700666465729963001"}
--[[local function on_DidReceiveRemoteNotification(e)
    Runtime:removeEventListener("didReceiveRemoteNotification", on_DidReceiveRemoteNotification)
    
    local pushNotiObj = (DeviceInfo.isiOS and e or e.data)
end
Runtime:addEventListener("didReceiveRemoteNotification", on_DidReceiveRemoteNotification)]]
--=====================--

-- 안드로이드 풀 스크린 모드 여부
local isAndroidFullScreen = true

-- 이 함수가 시작점입니다. 나머지는 신경쓰지 마세요. (-:
local function startApp()
	local composer = require "composer"
	composer.gotoScene("MainSceneStarter")
end

--=======================================================--
local function on_SystemEvent(e)
	local _type = e.type
	if _type == "applicationStart" then -- 앱이 시작될 때
		
		local isResized = false -- 리사이즈 함수 실행 여부
		
		local function onResized(e1)
			Runtime:removeEventListener("resize", onResized)
			isResized = true

			startApp()
		end
		
		--======== 안드로이드 풀 스크린 적용(수정 불필요) Begin ========--
		if system.getInfo("environment") == "simulator" or string.lower(system.getInfo("platformName")) ~= "android" or isAndroidFullScreen == false then
			onResized(nil)
		else -- 안드로이드이면서 풀 스크린 모드일 경우
			Runtime:addEventListener("resize", onResized)
			native.setProperty( "androidSystemUiVisibility", "immersiveSticky" )
			
			-- 소프트키 바가 없는 경우
			local function on_Timer(e2)
				if not isResized then onResized(nil) end
			end
			timer.performWithDelay(200, on_Timer, 1)
		end
		--======== 안드로이드 풀 스크린 적용(수정 불필요) End ========--
		
	elseif _type == "applicationExit" then -- 앱이 완전히 종료될 때
	elseif _type == "applicationSuspend" then -- 전화를 받거나 홈 버튼 등을 눌러서 앱을 빠져나갈 때
	elseif _type == "applicationResume" then -- Suspend 후 다시 돌아왔을 때
		if system.getInfo("environment") == "simulator" or string.lower(system.getInfo("platformName")) ~= "android" or isAndroidFullScreen == false then
		else -- 안드로이드이면서 풀 스크린 모드일 경우
			native.setProperty( "androidSystemUiVisibility", "immersiveSticky" )
		end
	end
end
Runtime:addEventListener("system", on_SystemEvent)
--=======================================================--