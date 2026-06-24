
-- ██████╗  ██████╗       ███████╗ ██████╗██████╗ ██████╗ ██████╗ ████████╗███████╗
-- ██╔══██╗██╔════╝       ██╔════╝██╔════╝██╔══██╗██╔══██╗██╔══██╗╚══██╔══╝██╔════╝
-- ██████╔╝██║  ███╗█████╗███████╗██║     ██████╔╝██████╔╝██████╔╝   ██║   ███████╗
-- ██╔══██╗██║   ██║╚════╝╚════██║██║     ██╔══██╗██╔═══╝ ██╔═══╝    ██║   ╚════██║
-- ██║  ██║╚██████╔╝      ███████║╚██████╗██║  ██║██║     ██║        ██║   ███████║
-- ╚═╝  ╚═╝ ╚═════╝       ╚══════╝ ╚═════╝╚═╝  ╚═╝╚═╝     ╚═╝        ╚═╝   ╚══════╝
--
-- RxBanking Integration for VMS Housing
-- Author: GR-Scripts
-- Description: Seamless integration between RxBanking and VMS Housing System
-- Version: 1.0.0
--
-- ═══════════════════════════════════════════════════════════════════════════════

if Config.Banking ~= 'RxBanking' then
    return
end

function GetSocietyMoney(societyName)
    local account = exports['RxBanking']:GetSocietyAccount('realestate')
    if account and account.balance then
        return account.balance
    end
    return 0
end

function AddSocietyMoney(societyName, amount, reason)
    reason = reason or 'VMS Housing - Property Sale'
    exports['RxBanking']:AddSocietyMoney('realestate', amount, 'deposit', reason)
end

function RemoveSocietyMoney(societyName, amount, reason)
    reason = reason or 'VMS Housing Transaction'
    exports['RxBanking']:RemoveSocietyMoney('realestate', amount, 'withdraw', reason)
end

function RegisterSocietyTransaction(src, societyName, type, data)
    local account = exports['RxBanking']:GetSocietyAccount('realestate')
    if not account or not account.iban then
        return
    end

    local reason = 'VMS Housing Transaction'
    
    if type == 'propertyPurchase' then
        reason = ('Purchased Property: %s, %s'):format(data.propertyAddress or 'Unknown', data.propertyRegion or '')
        exports['RxBanking']:CreateTransaction(
            data.amount or 0,
            'withdraw',
            account.iban,
            nil,
            reason
        )
        
    elseif type == 'propertySale' then
        reason = ('Sold Property: %s, %s to %s'):format(
            data.propertyAddress or 'Unknown',
            data.propertyRegion or '',
            data.buyerName or 'Unknown Buyer'
        )
        exports['RxBanking']:CreateTransaction(
            data.amount or 0,
            'deposit',
            nil,
            account.iban,
            reason
        )
        
    elseif type == 'rentPayment' then
        reason = ('Rent Payment: %s, %s from %s'):format(
            data.propertyAddress or 'Unknown',
            data.propertyRegion or '',
            data.buyerName or 'Tenant'
        )
        exports['RxBanking']:CreateTransaction(
            data.amount or 0,
            'payment',
            nil,
            account.iban,
            reason
        )
        
    elseif type == 'commission' then
        reason = ('Agent Commission: %s for %s, %s'):format(
            data.agentName or 'Agent',
            data.propertyAddress or 'Unknown',
            data.propertyRegion or ''
        )
        exports['RxBanking']:CreateTransaction(
            data.amount or 0,
            'payment',
            account.iban,
            nil,
            reason
        )
    end
end

function GetPlayerAccount(identifier)
    local account = exports['RxBanking']:GetPlayerPersonalAccount(identifier)
    return account
end

function GetPlayerBankBalance(identifier)
    local account = exports['RxBanking']:GetPlayerPersonalAccount(identifier)
    if account then
        return account.balance or 0
    end
    return 0
end

function AddPlayerBankMoney(identifier, amount, reason)
    local account = exports['RxBanking']:GetPlayerPersonalAccount(identifier)
    if account and account.iban then
        reason = reason or 'VMS Housing Transaction'
        exports['RxBanking']:AddAccountMoney(account.iban, amount, 'deposit', reason)
    end
end

function RemovePlayerBankMoney(identifier, amount, reason)
    local account = exports['RxBanking']:GetPlayerPersonalAccount(identifier)
    if account and account.iban then
        if account.balance >= amount then
            reason = reason or 'VMS Housing Transaction'
            exports['RxBanking']:RemoveAccountMoney(account.iban, amount, 'withdraw', reason)
            return true
        end
    end
    return false
end

function TransferMoney(fromIdentifier, toIdentifier, amount, reason)
    local fromAccount = exports['RxBanking']:GetPlayerPersonalAccount(fromIdentifier)
    local toAccount = exports['RxBanking']:GetPlayerPersonalAccount(toIdentifier)
    
    if fromAccount and toAccount and fromAccount.balance >= amount then
        reason = reason or 'VMS Housing Transfer'
        
        exports['RxBanking']:RemoveAccountMoney(fromAccount.iban, amount, 'transfer', reason, toAccount.iban)
        exports['RxBanking']:AddAccountMoney(toAccount.iban, amount, 'transfer', reason, fromAccount.iban)
        
        return true
    end
    
    return false
end

if Config and Config.Core then
    local originalRemoveMoney = SV and SV.RemoveMoney
    if originalRemoveMoney then
        SV.RemoveMoney = function(xPlayer, moneyType, count, reason)
            originalRemoveMoney(xPlayer, moneyType, count, reason)

            if not reason then
                return
            end

            local reasonLabels = {
                furniturePurchase = 'Furniture Purchase',
                purchaseProperty = 'Property Purchase',
                rentalProperty = 'Property Rent',
                purchaseKey = 'Key Purchase',
                lockReplacement = 'Lock Replacement',
                upgradeProperty = 'Property Upgrade',
                serviceBillPayment = 'Service Bill Payment',
                rentalBillPayment = 'Rental Bill Payment',
                rentalContract = 'Rental Contract',
                salesContract = 'Sales Contract',
                salesMarketplace = 'Marketplace Sale',
                rentalMarketplace = 'Marketplace Rent',
            }

            local label = reasonLabels[reason]
            if label then
                AddSocietyMoney('realestate', count, label)
            end
        end
    end
end

