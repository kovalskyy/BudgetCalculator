//
//  BudgetCell.swift
//  BudgetCalculator
//
//  Created by Kacper Kowalski on 18.10.2017.
//  Copyright © 2017 Kacper Kowalski. All rights reserved.
//

import UIKit

class BudgetCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    var budget: Budget? {
        didSet {
            nameLabel.text = budget?.name.capitalized
            totalLabel.text = budget?.budgetDisplayText
        }
    }
    
    
}
