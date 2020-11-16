using Pkg

Pkg.activate(".")

using Dates, Ledger, Random

ledger = new_ledger()

account_names = ["Food", "Transportation", "Fashion"]

for account in account_names
    add_account!(ledger, account)
end

push!(account_names, "Education")

for i in 1:10
    add_transaction!(ledger, Transaction(rand(-10:10), rand(account_names), today(), Dict()))
end

for account in account_names
    remove_account!(ledger, account)
end
