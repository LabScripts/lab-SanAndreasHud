ESX = exports['es_extended']:getSharedObject()
local lastValues = {}

local weapons = {
    [GetHashKey("WEAPON_KNIFE")] = "WEAPON_KNIFE",
    [GetHashKey("WEAPON_KNUCKLE")] = "WEAPON_KNUCKLE",
    [GetHashKey("WEAPON_NIGHTSTICK")] = "WEAPON_ASSAULTRIFLE",
    [GetHashKey("WEAPON_HAMMER")] = "WEAPON_ASSAULTRIFLE",
    [GetHashKey("WEAPON_BAT")] = "WEAPON_ASSAULTRIFLE",
    [GetHashKey("WEAPON_GOLFCLUB")] = "WEAPON_ASSAULTRIFLE",
    [GetHashKey("WEAPON_CROWBAR")] = "WEAPON_ASSAULTRIFLE",
    [GetHashKey("WEAPON_BOTTLE")] = "WEAPON_ASSAULTRIFLE",
    [GetHashKey("WEAPON_DAGGER")] = "WEAPON_ASSAULTRIFLE",
    [GetHashKey("WEAPON_HATCHET")] = "WEAPON_ASSAULTRIFLE",
    [GetHashKey("WEAPON_MACHETE")] = "WEAPON_ASSAULTRIFLE",
    [GetHashKey("WEAPON_FLASHLIGHT")] = "WEAPON_ASSAULTRIFLE",
    [GetHashKey("WEAPON_SWITCHBLADE")] = "WEAPON_ASSAULTRIFLE",
    [GetHashKey("WEAPON_PROXMINE")] = "WEAPON_ASSAULTRIFLE",
    [GetHashKey("WEAPON_BZGAS")] = "WEAPON_ASSAULTRIFLE",
    [GetHashKey("WEAPON_SMOKEGRENADE")] = "WEAPON_ASSAULTRIFLE",
    [GetHashKey("WEAPON_MOLOTOV")] = "WEAPON_ASSAULTRIFLE",
    [GetHashKey("WEAPON_FIREEXTINGUISHER")] = "WEAPON_ASSAULTRIFLE",
    [GetHashKey("WEAPON_REVOLVER")] = "WEAPON_REVOLVER",
    [GetHashKey("WEAPON_POOLCUE")] = "WEAPON_ASSAULTRIFLE",
    [GetHashKey("WEAPON_PIPEWRENCH")] = "WEAPON_ASSAULTRIFLE",
    [GetHashKey("WEAPON_PISTOL")] = "WEAPON_PISTOL",
    [GetHashKey("WEAPON_PISTOL_MK2")] = "WEAPON_PISTOL",
    [GetHashKey("WEAPON_COMBATPISTOL")] = "WEAPON_PISTOL",
    [GetHashKey("WEAPON_APPISTOL")] = "WEAPON_ASSAULTRIFLE",
    [GetHashKey("WEAPON_PISTOL50")] = "WEAPON_PISTOL",
    [GetHashKey("WEAPON_SNSPISTOL")] = "WEAPON_PISTOL",
    [GetHashKey("WEAPON_HEAVYPISTOL")] = "WEAPON_PISTOL",
    [GetHashKey("WEAPON_VINTAGEPISTOL")] = "WEAPON_PISTOL",
    [GetHashKey("WEAPON_FLAREGUN")] = "WEAPON_PISTOL",
    [GetHashKey("WEAPON_MARKSMANPISTOL")] = "WEAPON_PISTOL",
    [GetHashKey("WEAPON_MICROSMG")] = "WEAPON_MICROSMG",
    [GetHashKey("WEAPON_MINISMG")] = "WEAPON_MICROSMG",
    [GetHashKey("WEAPON_SMG")] = "WEAPON_MICROSMG",
    [GetHashKey("WEAPON_SMG_MK2")] = "WEAPON_MICROSMG",
    [GetHashKey("WEAPON_ASSAULTSMG")] = "WEAPON_MICROSMG",
    [GetHashKey("WEAPON_MG")] = "WEAPON_ASSAULTRIFLE",
    [GetHashKey("WEAPON_COMBATMG")] = "WEAPON_ASSAULTRIFLE",
    [GetHashKey("WEAPON_COMBATMG_MK2")] = "WEAPON_ASSAULTRIFLE",
    [GetHashKey("WEAPON_COMBATPDW")] = "WEAPON_MICROSMG",
    [GetHashKey("WEAPON_GUSENBERG")] = "WEAPON_MICROSMG",
    [GetHashKey("WEAPON_MACHINEPISTOL")] = "WEAPON_MICROSMG",
    [GetHashKey("WEAPON_ASSAULTRIFLE")] = "WEAPON_ASSAULTRIFLE",
    [GetHashKey("WEAPON_ASSAULTRIFLE_MK2")] = "WEAPON_ASSAULTRIFLE",
    [GetHashKey("WEAPON_CARBINERIFLE")] = "WEAPON_ASSAULTRIFLE",
    [GetHashKey("WEAPON_CARBINERIFLE_MK2")] = "WEAPON_ASSAULTRIFLE",
    [GetHashKey("WEAPON_ADVANCEDRIFLE")] = "WEAPON_ASSAULTRIFLE",
    [GetHashKey("WEAPON_SPECIALCARBINE")] = "WEAPON_ASSAULTRIFLE",
    [GetHashKey("WEAPON_BULLPUPRIFLE")] = "WEAPON_ASSAULTRIFLE",
    [GetHashKey("WEAPON_COMPACTRIFLE")] = "WEAPON_ASSAULTRIFLE",
    [GetHashKey("WEAPON_PUMPSHOTGUN")] = "WEAPON_SHOTGUN",
    [GetHashKey("WEAPON_SWEEPERSHOTGUN")] = "WEAPON_SHOTGUN",
    [GetHashKey("WEAPON_SAWNOFFSHOTGUN")] = "WEAPON_SHOTGUN",
    [GetHashKey("WEAPON_BULLPUPSHOTGUN")] = "WEAPON_SHOTGUN",
    [GetHashKey("WEAPON_ASSAULTSHOTGUN")] = "WEAPON_SHOTGUN",
    [GetHashKey("WEAPON_MUSKET")] = "WEAPON_ASSAULTRIFLE",
    [GetHashKey("WEAPON_MARKSMANRIFLE")] = "WEAPON_ASSAULTRIFLE",
    [GetHashKey("WEAPON_RPG")] = "WEAPON_ASSAULTRIFLE",
    [GetHashKey("WEAPON_MINIGUN")] = "WEAPON_ASSAULTRIFLE",
    [GetHashKey("WEAPON_STICKYBOMB")] = "WEAPON_ASSAULTRIFLE",
    [GetHashKey("WEAPON_COMPACTLAUNCHER")] = "WEAPON_ASSAULTRIFLE",
    [GetHashKey("WEAPON_SNSPISTOL_MK2")] = "WEAPON_PISTOL",
    [GetHashKey("WEAPON_REVOLVER_MK2")] = "WEAPON_REVOLVER",
    [GetHashKey("WEAPON_DOUBLEACTION")] = "WEAPON_REVOLVER",
    [GetHashKey("WEAPON_SPECIALCARBINE_MK2")] = "WEAPON_ASSAULTRIFLE",
    [GetHashKey("WEAPON_BULLPUPRIFLE_MK2")] = "WEAPON_ASSAULTRIFLE",
    [GetHashKey("WEAPON_PUMPSHOTGUN_MK2")] = "WEAPON_SHOTGUN",
}

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function()
	ESX.PlayerData = ESX.GetPlayerData()
	SendNUIMessage({action = 'updateID', id = GetPlayerServerId(PlayerId())})
    LoadRadialMap()
	Main()
    setLevel()
end)

function Main()
    CreateThread(function()
        while true do
            Wait(400)

            local ped = PlayerPedId()
            local playerId = PlayerId()

            SetPlayerHealthRechargeMultiplier(playerId,0.0)
            local maxHealth = GetEntityMaxHealth(ped)-100
            local health = GetEntityHealth(ped)-100
            if health < 0 then health = 0 end
            if lastValues.health ~= health then
                lastValues.health = health
                SendNUIMessage({action = 'updateHealth', current = health, max = maxHealth})
            end

            SetPlayerHealthRechargeMultiplier(playerId,0.0)
            local maxArmor = GetPlayerMaxArmour(playerId)
            local armor = GetPedArmour(ped)
            if armor < 0 then armor = 0 end

            if lastValues.armor ~= armor then
                lastValues.armor = armor
                SendNUIMessage({action = 'updateArmor', current = armor, max = maxArmor})
            end
           
            local player = GetPlayerPed(-1)
            if IsPedArmed(player, 7) then

                local weapon = GetSelectedPedWeapon(player)
                local ammoTotal = GetAmmoInPedWeapon(player,weapon)
                local bool,ammoClip = GetAmmoInClip(player,weapon)
                local ammoRemaining = math.floor(ammoTotal - ammoClip)
                    
                if weapons[weapon] then
                    if ammoClip then
                        SendNUIMessage({action = 'setWeaponImg', weapon = weapons[weapon], ammo = ammoClip})
                    else
                        SendNUIMessage({action = 'setWeaponImg', weapon = weapons[weapon]})
                    end
                else
                    SendNUIMessage({action = 'setWeaponImg', weapon = 'unarmed'})
                end
                    
            else
                SendNUIMessage({action = 'setWeaponImg', weapon = 'unarmed'})
            end			
        end
    end)

    updatePlayerInfo()
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(4000)
        TriggerEvent('esx_status:getStatus', 'hunger', function(hunger)
            TriggerEvent('esx_status:getStatus', 'thirst', function(thirst)
                local myhunger = hunger.getPercent()
                local mythirst = thirst.getPercent()
                SendNUIMessage({action = 'updateHunger', current = myhunger, max = 100})
                SendNUIMessage({action = 'updateThirst', current = mythirst, max = 100})
            end)
        end)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        if GetEntityMaxHealth(PlayerPedId()) ~= 200 then
            SetEntityMaxHealth(PlayerPedId(), 200)
            SetEntityHealth(PlayerPedId(), 200)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        local hours = GetClockHours()
        local minutes = GetClockMinutes()
        if hours < 10 then
            hours = '0'..hours
        end
        if minutes < 10 then
            minutes = '0'..minutes
        end
        SendNUIMessage({action = "updateClock", minutes = minutes, hours=hours})
    end
end)

function updatePlayerInfo()
    ESX.TriggerServerCallback("lab-HUD:getData", function(data)
        SendNUIMessage({
            action = 'updateStatus',
            bank = data.bank,
            job = data.job .. ' - ' .. data.grade
        })
    end)
end

RegisterNetEvent('esx:setAccountMoney')
AddEventHandler('esx:setAccountMoney', function(account)
    updatePlayerInfo()
end)

RegisterNetEvent("esx:setJob")
AddEventHandler("esx:setJob", function(job)
    updatePlayerInfo()
end)

function LoadRadialMap()
    local defaultAspectRatio = 1920/1080
    local resolutionX, resolutionY = GetActiveScreenResolution()
    local aspectRatio = resolutionX/resolutionY
    local minimapOffset = 0
    if aspectRatio > defaultAspectRatio then
        minimapOffset = ((defaultAspectRatio-aspectRatio)/3.6)-0.008
    end
    RequestStreamedTextureDict("circlemap", false)
    while not HasStreamedTextureDictLoaded("circlemap") do
        Wait(150)
    end
    SetMinimapClipType(1)
    
    AddReplaceTexture("platform:/textures/graphics", "radarmasksm", "circlemap", "radarmasksm")
    AddReplaceTexture("platform:/textures/graphics", "radarmask1g", "circlemap", "radarmasksm")
    SetMinimapComponentPosition("minimap", "L", "B", -0.0100 + minimapOffset, -0.030, 0.180, 0.258)
    SetMinimapComponentPosition("minimap_mask", "L", "B", 0.200 + minimapOffset, 0.0, 0.065, 0.20)
    SetMinimapComponentPosition('minimap_blur', 'L', 'B', -0.00 + minimapOffset, 0.015, 0.252, 0.338)
    SetBlipAlpha(GetNorthRadarBlip(), 0)
    SetMinimapClipType(1)
    SetRadarBigmapEnabled(true, false)
    Wait(0)
    SetRadarBigmapEnabled(false, false)
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(100)
        SetRadarZoom(1100)
        SetBigmapActive(false, false)
    end
end)

Citizen.CreateThread(function()
    local minimap = RequestScaleformMovie("minimap")
    SetRadarBigmapEnabled(true, false)
    Wait(0)
    SetRadarBigmapEnabled(false, false)
end)

Citizen.CreateThread(function()
    local minimap = RequestScaleformMovie("minimap")
    SetRadarBigmapEnabled(true, false)
    Citizen.Wait(0)
    SetRadarBigmapEnabled(false, false)
    while true do
        Citizen.Wait(0)
        Citizen.InvokeNative(0xF6E48914C7A8694E, minimap, "SETUP_HEALTH_ARMOUR")
        Citizen.InvokeNative(0xC3D0841A0CC546A6, 3)
        Citizen.InvokeNative(0xC6796A8FFA375E53)
        Citizen.InvokeNative(0xC6796A8FFA375E53)
    end
end)

Citizen.CreateThread(function()
    while true do
        HideHudComponentThisFrame(6) -- VEHICLE_NAME
        HideHudComponentThisFrame(7) -- AREA_NAME
        HideHudComponentThisFrame(8) -- VEHICLE_CLASS
        HideHudComponentThisFrame(9) -- STREET_NAME
        HideHudComponentThisFrame(3) -- CASH
        HideHudComponentThisFrame(4) -- MP_CASH
		HideHudComponentThisFrame(21) -- 21 : HUD_COMPONENTS
		HideHudComponentThisFrame(22) -- 22 : HUD_WEAPONS

		DisplayAmmoThisFrame(false)
        Citizen.Wait(4)

    end
end)