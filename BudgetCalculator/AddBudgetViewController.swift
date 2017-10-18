//
//  AddBudgetViewController.swift
//  BudgetCalculator
//
//  Created by Kacper Kowalski on 18.10.2017.
//  Copyright © 2017 Kacper Kowalski. All rights reserved.
//

import UIKit

protocol BudgetDelegate: class {
    func enteredBudgetData(name: String, amount: Int)
}

class AddBudgetViewController: UIViewController, UITextFieldDelegate {
    
    weak var delegate: BudgetDelegate? = nil
    
    @IBOutlet weak var budgetName: UITextField!
    @IBOutlet weak var budgetAmount: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        budgetName.delegate = self
        budgetAmount.delegate = self
        
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
    
    @IBAction func saveContent(_ sender: UIButton) {
        delegate?.enteredBudgetData(name: budgetName.text!, amount: Int(budgetAmount.text!) ?? 0)
        navigationController?.pop(animated: true)
    }
    
    // MARK: Private methods
    
    private func updateSaveButtonState() {
        // Disable button if the textfield is empty
        let nameField = budgetName.text ?? "", amountField = budgetAmount.text ?? ""
        saveButton.isEnabled = !nameField.isEmpty && !amountField.isEmpty
    }
}

