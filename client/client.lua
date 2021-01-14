ESX  = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
function savemakeup()
    TriggerServerEvent('skinchanger:getSkin',function(skin)
            LastSkin = skin
    end)
    TriggerEvent('skinchanger:getSkin',function(skin)
        TriggerServerEvent('esx_skin:save', skin)
    end)

end
makeupshop = {
	Base = { Header = {"commonmenu", "interaction_bgd"}, Title = "Institut beauté" },
	Data = { currentMenu = "Actions disponibles"},
	Events = { 
        onSelected = function(self, _, btn, PMenu, menuData, currentButton, currentBtn, currentSlt, result, slide)

            if btn.name == "Maquillage" then 
                makeupshop.Menu['Maquillage'].b = {}
                TriggerEvent('skinchanger:getData', function(components, maxVals)
                    for i=0, maxVals.makeup_1, 1 do
                        table.insert(makeupshop.Menu["Maquillage"].b, { name = "Maquillage N°" .. i , opacity = 0.30 , advSlider = {0,64,0},iterator = i })
                    end
                end)
                OpenMenu('Maquillage')
            elseif btn.name == "Rouge à lèvre" then 
                makeupshop.Menu['Rouge à lèvre'].b = {}
                TriggerEvent('skinchanger:getData', function(components, maxVals)
                    for i=0, maxVals.lipstick_1, 1 do
                        table.insert(makeupshop.Menu["Rouge à lèvre"].b, { name = "Rouge à lèvres N°" .. i , opacity = 0.30 , advSlider = {0,64,0},iterator = i })
                    end
                end)
                OpenMenu('Rouge à lèvre')
            elseif btn.name == "Teint" then 
                makeupshop.Menu['Teint'].b = {}
                TriggerEvent('skinchanger:getData', function(components, maxVals)
                    for i=0, maxVals.blush_1, 1 do
                        table.insert(makeupshop.Menu["Teint"].b, { name = "Teint N°" .. i , opacity = 0.30 , advSlider = {0,64,0},iterator = i })
                    end
                end)
                Wait(120)
                OpenMenu('Teint')
            
            elseif btn.name == "Payer" then 

                savemakeup()
                destorycam()
                SetEntityCoords(PlayerPedId(), 216.045 ,-1545.94 , 29.28)
                SetEntityHeading(PlayerPedId(), 237.22)
                ClearPedTasks(GetPlayerPed(-1))
                FreezeEntityPosition(GetPlayerPed(-1), false)   
                TriggerServerEvent('Sotek:pay')
                ESX.ShowNotification('∑ Vous venez de payer ~g~20$~s~ chez ~b~She nails.')
                CloseMenu()
            end
        end,
        onButtonSelected = function(currentMenu, currentBtn, menuData, newButtons, self)
            if currentMenu == "Maquillage" then 
                for k,v in pairs(makeupshop.Menu['Maquillage'].b) do 
                    if currentBtn - 1 == v.iterator then
                        TriggerEvent('skinchanger:change', "makeup_1",v.iterator) 
                    end
                end
            end
            if currentMenu == "Rouge à lèvre" then 
                for k,v in pairs(makeupshop.Menu['Rouge à lèvre'].b) do 
                    if currentBtn - 1 == v.iterator then
                        TriggerEvent('skinchanger:change', "lipstick_1",v.iterator) 
                    end
                end
            end
            if currentMenu == "Teint" then 
                for k,v in pairs(makeupshop.Menu['Teint'].b) do 
                    if currentBtn - 1 == v.iterator then
                        TriggerEvent('skinchanger:change', "blush_1",v.iterator) 
                    end
                end
            end
        end,
        onAdvSlide =  function(self, btn, currentBtn, currentButtons)
            if self.Data.currentMenu == "Maquillage" then 
                for k,v in pairs(makeupshop.Menu['Maquillage'].b) do 
                    if currentBtn.advSlider[3] == v.iterator then 
                    TriggerEvent('skinchanger:change', 'makeup_3', v.iterator)
                    end
                end
            end
            if self.Data.currentMenu == "Rouge à lèvre" then 
                for k,v in pairs(makeupshop.Menu['Rouge à lèvre'].b) do 
                    if currentBtn.advSlider[3] == v.iterator then 
                        TriggerEvent('skinchanger:change', 'lipstick_3', v.iterator)
                    end
                end
            end
            if self.Data.currentMenu == "Teint" then 
                for k,v in pairs(makeupshop.Menu['Teint'].b) do 
                    if currentBtn.advSlider[3] == v.iterator then 
                    TriggerEvent('skinchanger:change', 'blush_3', v.iterator)
                    end
                end
            end
        end,
        onSlide = function(menuData,btn, currentButton, currentSlt)
            local currentMenu = menuData.currentMenu
            local opacity = btn.opacity
            local slide = btn.slidenum
            local btn = btn.name
            if currentMenu == "Maquillage" then 
                TriggerEvent('skinchanger:change', 'makeup_2' , opacity*10)
            end
            if currentMenu == "Rouge à lèvre" then 
                TriggerEvent('skinchanger:change', 'lipstick_2' , opacity*10)
            end
            if currentMenu == "Teint" then 
                TriggerEvent('skinchanger:change', 'blush_2' , opacity*10)
            end
        end
    },

    Menu = {
		["Actions disponibles"] = {
            b = {
                {name = "Maquillage",ask = ">" , askX = true },
                {name = "Teint",ask = ">" , askX = true },
                {name = "Rouge à lèvre" , ask = ">" , askX = true },
                {name = "Payer" , price = 20}
            }
        }, 
        ["Maquillage"] = {
            b= {
            }
        },
        ["Rouge à lèvre"] = {
            b={

            }
        },
        ["Teint"] = {
            b={

            }
        }
    }
}

local posmakeushop = {
    {x=216.045 , y=-1545.94 ,z= 29.28}
}

Citizen.CreateThread(function()
	while true do
        Citizen.Wait(0)
            for k, v in pairs(posmakeushop) do 
                coords = GetEntityCoords(GetPlayerPed(-1),false)
                local dist = Vdist(coords.x, coords.y, coords.z, posmakeushop[k].x, posmakeushop[k].y, posmakeushop[k].z)
                if dist <= 5 then 
                    DrawMarker(2, posmakeushop[k].x, posmakeushop[k].y,posmakeushop[k].z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.2, 0.2, 0.2, 204, 204, 204, 200, true, false, 2, true, false, false, false)
                end
            if dist <= 2 then 
                ESX.ShowHelpNotification("Appuyer sur ~b~E~s~ pour vous faire une beauté.")
                if IsControlJustReleased(1, 51) then
                  
                    ready()
                end
            end
        end
    end
end)

function ready()
    disableUI = true
    TaskPedSlideToCoord(PlayerPedId(),  215.095, -1543.85, 29.72631072998, 29.72631072998, 1.0)
    TriggerEvent('makeupshop:disableUI')
    DoScreenFadeOut(1000)
    
    while not IsScreenFadedOut() do
        Citizen.Wait(0)
    end
    SetEntityInvincible(GetPlayerPed(-1), true) 
    SetEntityHeading(GetPlayerPed(-1), 223.4)
    SetEntityCoords(GetPlayerPed(-1), 215.095, -1543.85, 29.72631072998, 0.0, 0.0, 0.0, 10)
	DisplayRadar(false) 
    local cam = {}		
    cam = CreateCam("DEFAULT_SCRIPTED_Camera", 1)	
    TaskStartScenarioAtPosition(GetPlayerPed(-1), "PROP_HUMAN_SEAT_CHAIR_MP_PLAYER", 215.095, -1543.85, 29.72631072998-1.0, 214.9, 0, 1, false)
    Citizen.Wait(1000)
    createcammakeup(true)
    CreateMenu(makeupshop)
    DoScreenFadeIn(5000)
end

Citizen.CreateThread(function ()
    for _,pos in pairs(posmakeushop) do
        blip = AddBlipForCoord(pos.x,pos.y,pos.z)
        SetBlipSprite(blip,489)
        SetBlipScale(blip,0.6)
        SetBlipColour(blip,7)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('Magasin de maquillage')
        EndTextCommandSetBlipName(blip)
    end
end)

function round(exact, quantum)
    local quant,frac = math.modf(exact/quantum)
    return quantum * (quant + (frac > 0.5 and 1 or 0))
end


function createcammakeup(default)
    RenderScriptCams(false, false, 0, 1, 0)
    DestroyCam(cam, false)
    if (not DoesCamExist(cam)) then
        if default then
            cam = CreateCamWithParams('DEFAULT_SCRIPTED_CAMERA', 215.96, -1544.95, 29.28+0.2, 0.0, 0.0, 39.93, 30.0, false, 0)
        else
            cam = CreateCamWithParams('DEFAULT_SCRIPTED_CAMERA', 215.96, -1544.95, 29.28+0.2, 0.0, 0.0, 39.93, 30.0, false, 0)
        end 
        SetCamActive(cam, true)
        RenderScriptCams(true, false, 0, true, false)
    end
end

function destorycam() 	
    RenderScriptCams(false, false, 0, 1, 0)
    DestroyCam(cam, false)
    TriggerServerEvent('barbershop:removeposition')
end


RegisterNetEvent('makeupshop:disableUI')
AddEventHandler('makeupshop:disableUI', function()
    Citizen.CreateThread(function()
        while disableUI do
            Citizen.Wait(0)
            HideHudComponentThisFrame(19)
            DisableControlAction(2, 37, true)
            DisablePlayerFiring(GetPlayerPed(-1), true)
            DisableControlAction(0, 106, true)
            if IsDisabledControlJustPressed(2, 37) or IsDisabledControlJustPressed(0, 106) then
                SetCurrentPedWeapon(player, GetHashKey("WEAPON_UNARMED"), true)
            end
        end
    end)
end)