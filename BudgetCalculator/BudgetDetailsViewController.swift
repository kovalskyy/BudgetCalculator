//
//  BudgetDetailsViewController.swift
//  BudgetCalculator
//
//  Created by Kacper Kowalski on 18.10.2017.
//  Copyright © 2017 Kacper Kowalski. All rights reserved.
//

import UIKit

protocol BudgetDetailsViewDelegate: class {
    func budgetDetailsViewDidUpdateBudget(budget: Budget)
}

class BudgetDetailsViewController: UITableViewController, ExpenseDelegate {
    
    var budget: Budget!
    weak var delegate: BudgetDetailsViewDelegate?
    let minimalAmount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.setTitle(title: budget.name.capitalized, subtitle: ("$" + String(budget.total)))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style:.plain, target:nil, action:nil)
    }
    
    //MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationViewController = segue.destination as? AddExpenseViewController {
            destinationViewController.delegate = self
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return budget.expenses.count + 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row < budget.expenses.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ExpenseCell") as! ExpenseCell
            cell.expense = budget.expenses[indexPath.row]
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "BalanceCell") as! BalanceCell
            cell.textLabel?.text = "Wallet Balance: \(budget.balance.formatedCurrency)"
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? BalanceCell else { return }
        
        if budget.balance > minimalAmount {
            cell.textLabel?.backgroundColor = UIColor.blue
            cell.contentView.backgroundColor = UIColor.blue
        } else {
            cell.textLabel?.backgroundColor = UIColor.red
            cell.contentView.backgroundColor = UIColor.red
        }
    }
    
    //MARK: - Callback
    
    func enteredExpenseData(name: String, amount: Int) {
        budget.expenses.append(Expense(name: name, amount: amount))
        tableView.reloadData()
        delegate?.budgetDetailsViewDidUpdateBudget(budget: budget)
    }
}
