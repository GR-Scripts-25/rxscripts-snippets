---@param data FineData
function FinePlayer(data)
    if not data or not data.targetIdentifier or not data.amount or not data.charges then
        return
    end

    local chargeNames = {}
    for _, charge in ipairs(data.charges) do
        table.insert(chargeNames, charge.name or "Unknown Charge")
    end
    local reason = table.concat(chargeNames, ", ")

    exports['RxBilling']:SendInvoice(data.targetIdentifier, data.amount, reason, true)
end

