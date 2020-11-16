using Pkg

Pkg.activate(".")

using Dates, Ledger, Random

ledger = new_ledger()

for i in 1:10
    add_transaction!(ledger, Transaction(rand(-10:10), randstring('a':'z',5), today(), Dict()))
end

