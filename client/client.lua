vRPStd = {}
Tunnel.bindInterface("vrp_talkdisplay",vRPStd)
Proxy.addInterface("vrp_talkdisplay",vRPStd)

local users = {}
function vRPStd.newUser(user_id,source)users[user_id] = {player = GetPlayerFromServerId(source)} end
function vRPStd.delUser(user_id)users[user_id] = nil end

local function RGBRainbow( frequency )
	local result = {}
	local curtime = GetGameTimer() / 500

	result.r = math.floor( math.sin( curtime * frequency + 0 ) * 127 + 128 )
	result.g = math.floor( math.sin( curtime * frequency + 2 ) * 127 + 128 )
	result.b = math.floor( math.sin( curtime * frequency + 4 ) * 127 + 128 )
	
	return result
end

local function drawTxt(x,y,width,height,scale,text)
    SetTextFont(0)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(RGBRainbow(1).r,RGBRainbow(1).g,RGBRainbow(1).b,255)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end

Citizen.CreateThread(function()
    while true do
		Citizen.Wait(1)
		local t = 0
        for i = 0, 256 do
			if NetworkIsPlayerActive(i) then
				if(NetworkIsPlayerTalking(i))then
					local name = GetPlayerName(i)
					for k, v in pairs(users) do
						if(name and k)then
							t = t + 1 if(t == 1)then drawTxt(0.515, 0.95, 1.0,1.0,0.4, "Vorbeste: ")end
							drawTxt(0.520, 0.95 + (t * 0.023), 1.0,1.0,0.4, "[ID:"..k.." - Name:"..name.."]")
						end
					end
                end
            end
        end
	end
end)