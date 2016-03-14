----------------------------------------
-- 이 주석은 삭제하지 마세요.
-- 35% 할인해 드립니다. 코로나 계정 유료 구매시 연락주세요. (Corona SDK, Enterprise, Cards)
-- @Author 아폴로케이션 원강민 대표
-- @Website http://WonHaDa.com, http://Apollocation.com, http://CoronaLabs.kr
-- @E-mail englekk@naver.com, englekk@apollocation.com
-- 'John 3:16, Psalm 23'
-- MIT License :: WonHada Library에 한정되며, 라이선스와 저작권 관련 명시만 지켜주면 되는 라이선스
----------------------------------------

-- 캐논 샘플을 참고함 :: https://github.com/coronalabs-samples/CoronaCannon

-- 디자인 크기에 따라 fhd(FullHD, 1080x1920) 또는 hd(720x1280)로 변경하세요.
-- 디자인 파일이 많아서 용량을 줄이고 싶거나 퍼포먼스를 최적화해야 하는 경우라면 hd를 추천합니다.
local designSize = "fhd"

if not display then return end -- 데스크탑용 앱은 사용안함

-- 1080x1920 디자인 기준, 레터박스 스케일링용 계산법입니다.
-- x = 0, y = 0은 항상 화면의 좌상단을 가리킵니다.
-- 화면 우측 하단의 좌표를 구하려면, x = display.contentWidth, y = display.contentHeight를 사용하시면 됩니다.
local w, h = display.pixelWidth, display.pixelHeight

-- 씬 디자인의 절반
-- 1080x1920의 경우 540x960이지만 레티나와 기본의 가로 비율을 갖게 하려면 640x960을 적용해야 함
-- 만약 모든 가로 비율을 동일하게(태블릿은 조금 더 큼) 하고 싶다면 아래 540을 640으로 수정하세요.
local normalW, normalH = (w / h >= 0.6) and 640 or 540, 960 -- 씬 디자인이 1080x1920일 경우 (기본)
if designSize == "hd" then normalW, normalH = (w / h >= 0.6) and 426.66 or 360, 640 end -- 씬 디자인이 720x1280일 경우

local scale = math.max(normalW / w, normalH / h)
w, h = w * scale, h * scale

application = {
    content = {
      width = w,
        height = h,
        scale = 'letterbox',
        audioPlayFrequency = 44100, -- 11025, 22050, 44100: 높을수록 고음질
        fps = 60,
        xAlign = "left",
        yAlign = "top",
        imageSuffix = {
        ['@2x'] = 1.1,
              --['@4x'] = 2.1
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
