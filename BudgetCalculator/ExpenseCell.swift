//
//  ExpenseCell.swift
//  BudgetCalculator
//
//  Created by Kacper Kowalski on 18.10.2017.
//  Copyright © 2017 Kacper Kowalski. All rights reserved.
//

import UIKit

class ExpenseCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    
    var expense: Expense? {
        didSet {
            nameLabel.text = expense?.name
            if let amount = expense?.amount {
                amountLabel.text = amount.formatedCurrency
            }
        }
    }
    
}
