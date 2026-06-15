local StartOrder = {
    -- External dependencies. These must exist in your resources folder.
    'oxmysql',
    'es_extended',

    -- WB_Scripts resources
    'WB_Core',
    'WB_UI',
    'WB_Discord',
    'WB_Identity',
    'WB_Multichar',
    'WB_Banking',
    'WB_Inventory',
    'WB_Jobs',
    'WB_Garages',
    'WB_Admin'
}

local function resourceExists(name)
    return GetResourcePath(name) ~= nil and GetResourcePath(name) ~= ''
end

local function startResource(name)
    if not resourceExists(name) then
        print(('^1[WB_Scripts]^7 Resource fehlt: ^3%s^7'):format(name))
        return
    end

    local state = GetResourceState(name)
    if state == 'started' or state == 'starting' then
        print(('^2[WB_Scripts]^7 Bereits gestartet: ^3%s^7'):format(name))
        return
    end

    print(('^5[WB_Scripts]^7 Starte Resource: ^3%s^7'):format(name))
    ExecuteCommand(('ensure %s'):format(name))
end

CreateThread(function()
    Wait(1500)

    print('^5========================================^7')
    print('^5[WB_Scripts]^7 Starte Framework Bundle')
    print('^5========================================^7')

    for _, resourceName in ipairs(StartOrder) do
        startResource(resourceName)
        Wait(750)
    end

    print('^2[WB_Scripts]^7 Bundle-Start abgeschlossen.')
    print('^5========================================^7')
end)
