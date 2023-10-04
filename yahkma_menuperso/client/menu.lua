esx = nill
TriggerEvent(Config.Menu.getESX, function(obj) ESX = obj end)

local menuState = false
local inVehicle = false

Citizen.CreateThread(function ()
    while true do
        inVehicle = IsPedInAnyVehicle(PlayerPedId(), true)
        Citizen.Wait(500)
    end
end)

local main_menu = RageUI.CreateMenu(Config.Menu.ServerName, "Intéraction")
local inventory = RageUI.CreateSubMenu(main_menu, Config.Menu.ServerName, "Inventaire")
local wallet = RageUI.CreateSubMenu(main_menu, Config.Menu.ServerName, "Portefeuille")
local gestion_clothes = RageUI.CreateSubMenu(main_menu, Config.Menu.ServerName, "Vêtements")
local gestion_weapon = RageUI.CreateSubMenu(main_menu, Config.Menu.ServerName, "Gestion des armes")
local gestion_entreprise = RageUI.CreateSubMenu(main_menu, Config.Menu.ServerName, "Gestion de l'entreprise")
local gestion_orga = RageUI.CreateSubMenu(main_menu, Config.Menu.ServerName, "Gestion de l'organisation")
local gestion_vehicule = RageUI.CreateSubMenu(main_menu, Config.Menu.ServerName, "Gestion du véhicule")


main_menu.Closed = function ()
    menuState = false
end

function OpenMenu()
    if menuState then
        menuState = false
        RageUI.Visible(main_menu, false)
    else
        menuState = true
        RageUI.Visible(main_menu, true)
    end

    CreateThread(function ()
        while menuState do
            Wait(1)

            RageUI.IsVisible(main_menu, function ()

                RageUI.Button("> Inventaire", nill, {}, true, {
                }, inventory)
                RageUI.Button("> Portefeuille", nill, {}, true, {
                }, wallet)
                RageUI.Button("> Vêtements", nill, {}, true, {
                }, gestion_clothes)
                RageUI.Button("> Gestion des armes", nill, {}, true, {
                }, gestion_weapon)
                RageUI.Button("> Gestion de l'entreprise", nill, {}, true, {
                }, gestion_entreprise)
                RageUI.Button("> Gestion de l'organisation", nill, {}, true, {
                }, gestion_orga)
                if inVehicle then
                    RageUI.Button("> Gestion du véhicule", nill, {}, true, {
                }, gestion_vehicule)
            else
                RageUI.Button("> Gestion du véhicule", nill, {RightBadge = RageUI.BadgeStyle.Star}, false, {
                })
            end
        end)

            RageUI.IsVisible(inventory, function ()

                 RageUI.Separator("↓ Inventaire ↓")
            end)

            RageUI.IsVisible(wallet, function ()

                RageUI.Separator("↓ Portefeuille ↓")
                
            end)

        end
    end)
end

Keys.Register(Config.Menu.Key, "Menu", "Ouvrir le menu", function ()
    OpenMenu()
end)

