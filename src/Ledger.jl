"""`Ledger` is a module that provides a system of budgeting centered around a "ledger", 
    which is an array of `LedgerEntry` `struct`. `Ledger` entry structs represets things
    like transactions, adding/removing accounts, etc."""
module Ledger

using Dates

"""`LedgerEntry` is an `abstract type` that encompasses all the modifications on can do to a ledger."""
abstract type LedgerEntry end

"""`Transaction(amount::Real, account::String, date::::Union{Date,DateTime}, tags::Dict{String,String})` 
    records the flow of money from or to a ledger."""
struct Transaction<:LedgerEntry
    amount::Real
    account::String
    date::Union{Date,DateTime}
    tags::Dict{String,String}
end

"""`AddAccount(account::String, date::::Union{Date,DateTime})` 
    records the addition of an account."""
struct AddAccount<:LedgerEntry
    account::String
    date::Union{Date,DateTime}
end

"""`RemoveAccount(account::String, date::::Union{Date,DateTime})` 
    records the deletion of an account from a ledger."""
struct RemoveAccount<:LedgerEntry
    account::String
    date::Union{Date,DateTime}
end

"""`new_ledger()` creates an empty ledger, `LedgerEntry[]`"""
function new_ledger()
    LedgerEntry[]
end

"""`add_transaction!(ledger::Array{LedgerEntry,1}, transaction::Transaction)` 
    adds a `transaction`, to `ledger`, if ledger has `transaction.account`."""
function add_transaction!(ledger::Array{LedgerEntry,1}, transaction::Transaction)

    if has_account(ledger, transaction.account)
        push!(ledger, transaction)
    else
        println("The transaction, $(transaction.amount), was not added to the ledger, because the account, $(transaction.account), is not in the ledger.")
    end

end

"""`add_account!(ledger::Array{LedgerEntry,1}, account::String; date = today())` 
    adds an account to ledger."""
function add_account!(ledger::Array{LedgerEntry,1}, account::String; date = today())

    if has_account(ledger, account)
        println("The account, $(account), was not added to the ledger, because it was already added.")
    else
        push!(ledger, AddAccount(account, date))
    end

end


"""`remove_account!(ledger::Array{LedgerEntry,1}, account::String; date = today())` 
    removes an account from ledger."""
function remove_account!(ledger::Array{LedgerEntry,1}, account::String; date = today())

    if has_account(ledger, account)
        push!(ledger, RemoveAccount(account, date))
    else
        println("The account, $(account), was not removed from the ledger, because it was never added or was already removed.")
    end

end


"""`has_account(ledger::Array{LedgerEntry,1}, account::String)` 
    checks if `ledger` has `acount` added"""
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

function process_ledger(ledger::Array{LedgerEntry,1}; filter = true)

    tally = Dict{String, Any}()

    for ledger_entry in ledger
        if filter
           # println(ledger_entry)
           process_ledger_entry!(tally, ledger_entry)
        end
    end
    tally
end

function process_ledger_entry!(tally, ledger_entry::LedgerEntry)
    println(ledger_entry)
end

function process_ledger_entry!(tally, ledger_entry::Transaction)
    tally[ledger_entry.account] += ledger_entry.amount 
end

function process_ledger_entry!(tally, ledger_entry::AddAccount)
    tally[ledger_entry.account] = 0
end

function process_ledger_entry!(tally, ledger_entry::RemoveAccount)
    if tally[ledger_entry.account] != 0
        if haskey(tally, "")
            tally[""] += tally[ledger_entry.account]
        else
            tally[""] = tally[ledger_entry.account]
        end
    end
    delete!(tally, ledger_entry.account) 
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

export new_ledger, add_transaction!, add_account!, remove_account!, LedgerEntry, AddAccount, RemoveAccount, Transaction, process_ledger

end # module
