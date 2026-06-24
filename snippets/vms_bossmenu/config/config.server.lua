
--  ██████╗██╗   ██╗███████╗████████╗ ██████╗ ███╗   ███╗    ███████╗ ██████╗  ██████╗██╗███████╗████████╗██╗   ██╗     █████╗  ██████╗ ██████╗   
-- ██╔════╝██║   ██║██╔════╝╚══██╔══╝██╔═══██╗████╗ ████║    ██╔════╝██╔═══██╗██╔════╝██║██╔════╝╚══██╔══╝╚██╗ ██╔╝    ██╔══██╗██╔════╝██╔════╝   
-- ██║     ██║   ██║███████╗   ██║   ██║   ██║██╔████╔██║    ███████╗██║   ██║██║     ██║█████╗     ██║    ╚████╔╝     ███████║██║     ██║        
-- ██║     ██║   ██║╚════██║   ██║   ██║   ██║██║╚██╔╝██║    ╚════██║██║   ██║██║     ██║██╔══╝     ██║     ╚██╔╝      ██╔══██║██║     ██║        
-- ╚██████╗╚██████╔╝███████║   ██║   ╚██████╔╝██║ ╚═╝ ██║    ███████║╚██████╔╝╚██████╗██║███████╗   ██║      ██║       ██║  ██║╚██████╗╚██████╗██╗
--  ╚═════╝ ╚═════╝ ╚══════╝   ╚═╝    ╚═════╝ ╚═╝     ╚═╝    ╚══════╝ ╚═════╝  ╚═════╝╚═╝╚══════╝   ╚═╝      ╚═╝       ╚═╝  ╚═╝ ╚═════╝ ╚═════╝╚═╝
---@param name string: this will be the accountName from Config.JobMenusSettings
SV.getSocietyMoney = function(name, cb)
    if Config.Banking == 'qb-banking' then
        local society = exports['qb-banking']:GetAccountBalance(name)
        cb(society)

    elseif Config.Banking == 'okokBanking' then
        local society = exports['okokBanking']:GetAccount(name)
        cb(society)

    elseif Config.Banking == 'Renewed-Banking' then
        local society = exports['Renewed-Banking']:getAccountMoney(name)
        cb(society)

    elseif Config.Banking == 'tgg-banking' then
        local society = exports['tgg-banking']:GetSocietyAccountMoney(name)
        cb(society)

    elseif Config.Banking == 'RxBanking' then
        exports['RxBanking']:GetSocietyAccount(name, amount)
        
    end
end

---@param name string: this will be the accountName from Config.JobMenusSettings
SV.addSocietyMoney = function(name, amount)
    if Config.Banking == 'qb-banking' then
        exports['qb-banking']:AddMoney(name, amount)

    elseif Config.Banking == 'okokBanking' then
        exports['okokBanking']:AddMoney(name, amount)
        
    elseif Config.Banking == 'Renewed-Banking' then
        exports['Renewed-Banking']:addAccountMoney(name, amount)

    elseif Config.Banking == 'tgg-banking' then
        exports['tgg-banking']:AddSocietyMoney(name, amount)

    elseif Config.Banking == 'RxBanking' then
        exports['RxBanking']:RemoveSocietyMoney(name, amount)

    end
end

---@param name string: this will be the accountName from Config.JobMenusSettings
SV.removeSocietyMoney = function(name, amount)
    if Config.Banking == 'qb-banking' then
        exports['qb-banking']:RemoveMoney(name, amount)

    elseif Config.Banking == 'okokBanking' then
        exports['okokBanking']:RemoveMoney(name, amount)

    elseif Config.Banking == 'Renewed-Banking' then
        exports['Renewed-Banking']:removeAccountMoney(name, amount)

    elseif Config.Banking == 'tgg-banking' then
        exports['tgg-banking']:RemoveSocietyMoney(name, amount)

    elseif Config.Banking == 'RxBanking' then
        exports['RxBanking']:AddSocietyMoney(name, amount)

    end
end