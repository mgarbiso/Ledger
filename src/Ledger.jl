module Ledger

using Dates

"""`LedgerEntry` is an `abstract type` that encompasses all the modifications on can do to a ledger."""
abstract type LedgerEntry end

struct Transaction<:LedgerEntry
    amount::Real
    account::String
    date::Union{Date,DateTime}
    tags::Dict{String,String}
end

struct AddAccount<:LedgerEntry
    account::String
    date::Union{Date,DateTime}
end

struct RemoveAccount<:LedgerEntry
    account::String
    date::Union{Date,DateTime}
end

function new_ledger()
    LedgerEntry[]
end

function add_transaction!(ledger::Array{LedgerEntry,1}, transaction::Transaction)

    if has_account(ledger, transaction.account)
        push!(ledger, transaction)
    else
        println("The transaction, $(transaction), was not added to the ledger.")
    end

end

function add_account!(ledger::Array{LedgerEntry,1}, account::String; date = today())

    if has_account(ledger, account)
        println("The account, $(account), was not added to the ledger, because it was already added.")
    else
        push!(ledger, AddAccount(account, date))
    end

end

function remove_account!(ledger::Array{LedgerEntry,1}, account::String; date = today())

    if has_account(ledger, account)
        push!(ledger, RemoveAccount(account, date))
    else
        println("The account, $(account), was not removed from the ledger, because it was never added or was already removed.")
    end

end

function has_account(ledger::Array{LedgerEntry,1}, account::String)
    account_exist = false

    for ledger_entry in ledger
        if typeof(ledger_entry) == AddAccount && ledger_entry.account == account
            account_exist = true
        elseif typeof(ledger_entry) == RemoveAccount && ledger_entry.account == account
            account_exist = false
        end
    end

    return account_exist
end

# Transactions
# set_default_account! default account

#Read read_net
# Display Current Net
# Display Curent Avaialable/Expected
# Display Unallocated funds, funds with no category.
# Display Filtered funds

# Export
# csv
# pdf report
# excel

# Import
# csv

export new_ledger, add_transaction!, add_account!, remove_account!, LedgerEntry, AddAccount, RemoveAccount, Transaction

end # module
