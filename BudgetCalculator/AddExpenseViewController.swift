//
//  AddExpenseViewController.swift
//  BudgetCalculator
//
//  Created by Kacper Kowalski on 18.10.2017.
//  Copyright © 2017 Kacper Kowalski. All rights reserved.
//

import UIKit

protocol ExpenseDelegate: class {
    func enteredExpenseData(name: String, amount: Int)
}

class AddExpensesViewController: UIViewController, UITextFieldDelegate {
    
    weak var delegate: ExpenseDelegate? = nil
    
    @IBOutlet weak var expenseName: UITextField!
    @IBOutlet weak var expenseAmount: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        expenseName.delegate = self
        expenseAmount.delegate = self
        
        updateSaveButtonState()
    }
    
    //MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide keyboard
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Disable the save button while editing
        saveButton.isEnabled = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState()
    }
    
    // MARK: Callback
    
    @IBAction func saveExpenseContent(_ sender: UIButton) {
        delegate?.enteredExpenseData(name: expenseName.text!, amount: Int(expenseAmount.text!) ?? 0)
        navigationController?.pop(animated: true)
    }
    
    // MARK: Private methods
    
    private func updateSaveButtonState() {
        // Disable button if the textfield is empty
        let nameField = expenseName.text ?? "", amountField = expenseAmount.text ?? ""
        saveButton.isEnabled = !nameField.isEmpty && !amountField.isEmpty
    }
    
}

