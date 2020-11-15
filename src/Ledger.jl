module Ledger

using Dates

"""`LedgerModification` is an `abstract type` that encompasses all the modifications on can do to a ledger."""
abstract type LedgerModification end

struct Transcation<:LedgerModification
    amount::Real
    account::String
    date::Union{Date,DateTime}
    tags::Dict{String,String}
end

# Transactions
# add_transaction! (for expenses and incomes)
# remove_account! add account, delete account
# add_account! add account, delete add_account
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


end # module
