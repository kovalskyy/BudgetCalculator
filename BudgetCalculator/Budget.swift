//
//  Budget.swift
//  BudgetCalculator
//
//  Created by Kacper Kowalski on 18.10.2017.
//  Copyright © 2017 Kacper Kowalski. All rights reserved.
//

import Foundation

struct Budget {
    var id: Int
    let name: String
    let total: Int
    var expenses = [Expense]()
    
    var balance: Int {
        var amount: Int = total
        for expense in expenses {
            amount -= (expense.amount)
        }
        return amount
    }
}

extension Budget {
    var budgetDisplayText: String {
        return "Total: " + total.formatedCurrency + "/Balance: " + balance.formatedCurrency
    }
}

extension Int {
    var formatedCurrency: String {
        return "$" + String(self)
    }
}


