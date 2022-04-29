
ESX = nil

local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}
local timertoggle = false
local killed = false
local DrawFot = 255,100,203
local uzywane = false
local Melee = { "WEAPON_UNARMED" }

local minutyBW = 0.5 --tyle minut mamy bw

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getShvamesACaredObjvamesACect', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)



function DrawGenericTextThisFrame()
	SetTextFont(4)
	SetTextProportional(0)
	SetTextScale(0.0, 0.5)
	SetTextColour(255, 255, 255, 255)
	SetTextDropshadow(0, 0, 0, 0, 255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(true)
end

Citizen.CreateThread(function()
    while true do
	N_0x4757f00bc6323cfe(GetHashKey("WEAPON_UNARMED"), 0.4)
	N_0x4757f00bc6323cfe(GetHashKey("WEAPON_NIGHTSTICK"), 0.3)
    Wait(0)
    end
end)

function checkArray(array, val)
	for _, value in ipairs(array) do
		local v = value
		if type(v) == 'string' then
			v = GetHashKey(v)
		end

		if v == val then
			return true
		end
	end

	return false
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		local xd = IsEntityPlayingAnim(PlayerPedId(), 'mini@cpr@char_b@cpr_def', 'cpr_pumpchest_idle', 3)
		local animka = math.random(1,4)
			if uzywane == true then
				if xd == false and IsPedDeadOrDying(GetPlayerPed(-1)) then
					ESX.Streaming.RequestAnimDict('mini@cpr@char_b@cpr_def', function()
						TaskPlayAnim(PlayerPedId(), 'mini@cpr@char_b@cpr_def', 'cpr_pumpchest_idle', 8.0, -8.0, -1, 1, 1, false, false, false)
					end)
				end
			end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local ped = PlayerPedId()
		local d = GetPedCauseOfDeath(ped)
	 		if IsPedDeadOrDying(GetPlayerPed(-1)) then
					 if checkArray(Melee, d) and not uzywane then
						 TriggerEvent('esx_ambulancejob:revive', GetPlayerPed(-1))
						 TriggerEvent('esx_needs:starttimer')
						blokada = true
						if blokada then
						uzywane = true
						end
						SetEnableHandcuffs(ped, true)
						DisablePlayerFiring(ped, true)
						SetPedCanPlayGestureAnims(ped, false)
						DisplayRadar(false)
						--FreezeEntityPosition(GetPlayerPed(-1), true)
						Citizen.Wait(2500)
						ESX.Streaming.RequestAnimDict('mini@cpr@char_b@cpr_def', function()
							TaskPlayAnim(PlayerPedId(), 'mini@cpr@char_b@cpr_def', 'cpr_pumpchest_idle', 8.0, -8.0, -1, 1, 1, false, false, false)
						end)
						timertoggle = true 
						Citizen.Wait(minutyBW * 60000)
						SetEnableHandcuffs(ped, false)
						DisablePlayerFiring(ped, false)
						SetPedCanPlayGestureAnims(ped, true)
						DisplayRadar(true)
						blokada = false
						uzywane = false
						ESX.ShowNotification('~g~Odzyskałeś przytomność!')
						--FreezeEntityPosition(GetPlayerPed(-1), false)
						timertoggle = false
						ClearPedTasks(ped)
					 end
			end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if blokada then
			SetCurrentPedWeapon(ped, GetHashKey('WEAPON_UNARMED'), true)
			DisableControlAction(0, 1, true) -- Disable pan
			DisableControlAction(0, 2, true) -- Disable tilt
			DisableControlAction(0, 24, true) -- Attack
			DisableControlAction(0, 257, true) -- Attack 2
			DisableControlAction(0, 25, true) -- Aim
			DisableControlAction(0, 263, true) -- Melee Attack 1
			DisableControlAction(0, 32, true) -- W
			DisableControlAction(0, 34, true) -- A
			DisableControlAction(0, 31, true) -- S
			DisableControlAction(0, 30, true) -- D

			DisableControlAction(0, 45, true) -- Reload
			DisableControlAction(0, 22, true) -- Jump
			DisableControlAction(0, 44, true) -- Cover
			DisableControlAction(0, 37, true) -- Select Weapon
			DisableControlAction(0, 23, true) -- Also 'enter'?

			DisableControlAction(0, 288,  true) -- Disable phone
			DisableControlAction(0, 289, true) -- Inventory
			DisableControlAction(0, 170, true) -- Animations
			DisableControlAction(0, 167, true) -- Job

			DisableControlAction(0, 73, true) -- Disable clearing animation
			DisableControlAction(2, 199, true) -- Disable pause screen

			DisableControlAction(0, 59, true) -- Disable steering in vehicle
			DisableControlAction(0, 71, true) -- Disable driving forward in vehicle
			DisableControlAction(0, 72, true) -- Disable reversing in vehicle

			DisableControlAction(2, 36, true) -- Disable going stealth

			DisableControlAction(0, 47, true)  -- Disable weapon
			DisableControlAction(0, 264, true) -- Disable melee
			DisableControlAction(0, 257, true) -- Disable melee
			DisableControlAction(0, 140, true) -- Disable melee
			DisableControlAction(0, 141, true) -- Disable melee
			DisableControlAction(0, 142, true) -- Disable melee
			DisableControlAction(0, 143, true) -- Disable melee
			DisableControlAction(0, 75, true)  -- Disable exit vehicle
			DisableControlAction(27, 75, true) -- Disable exit vehicle

		else
			Citizen.Wait(500)
		end
	end
end)


RegisterNetEvent('esx_needs:starttimer')
AddEventHandler('esx_needs:starttimer', function()
	timer = minutyBW * 60
	Citizen.CreateThread(function()
		while timer > 0 do
			Citizen.Wait(0)
			Citizen.Wait(1000)
			if(timer > 0)then
				timer = timer - 1
			end
		end
	end)
	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(0)
			if timertoggle then
				DrawGenericTextThisFrame()
				SetTextEntry("STRING")
				AddTextComponentString('Zostales pobity, jesteś nieprzytomny i wstaniesz za ' .. timer .. ' sekund')
				DrawText(0.5, 0.8)
			else
				Citizen.Wait(1000)
			end
		end
	end)
end)