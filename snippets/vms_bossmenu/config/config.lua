-- ██████╗  █████╗ ██╗      █████╗ ███╗   ██╗ ██████╗███████╗
-- ██╔══██╗██╔══██╗██║     ██╔══██╗████╗  ██║██╔════╝██╔════╝
-- ██████╔╝███████║██║     ███████║██╔██╗ ██║██║     █████╗  
-- ██╔══██╗██╔══██║██║     ██╔══██║██║╚██╗██║██║     ██╔══╝  
-- ██████╔╝██║  ██║███████╗██║  ██║██║ ╚████║╚██████╗███████╗
-- ╚═════╝ ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═══╝ ╚═════╝╚══════╝
---@field Banking string: Using an external money storage system will disable the use of the entire Safe section, this means that you will not be able to make deposits, withdrawals, transfers and there will be no insight into the balance of the company
--[[
    - none: Using the built-in system for storing money, withdrawals/deposits, transfers

    - qb-banking
    - okokBanking
    - Renewed-Banking
    - tgg-banking

    * If there is no bank system listed above, you can customize it in config.server.lua (SV.getSocietyMoney, SV.addSocietyMoney, SV.removeSocietyMoney)
]]
Config.Banking = 'RxBanking'