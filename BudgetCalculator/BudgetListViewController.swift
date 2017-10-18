//
//  BudgetListViewController.swift
//  BudgetCalculator
//
//  Created by Kacper Kowalski on 18.10.2017.
//  Copyright © 2017 Kacper Kowalski. All rights reserved.
//

import UIKit

class BudgetListViewController: UITableViewController {
    
    var budgets = [Budget]()

    override func viewDidLoad() {
        super.viewDidLoad()

         self.navigationItem.leftBarButtonItem = editButtonItem
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style:.plain, target:nil, action:nil)
    }

    //MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationViewController = segue.destination as? AddBudgetViewController {
            //
        }
    }
    
    //MARK: - Callback
    

    //MARK: - UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return budgets.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "BudgetListCell") as! BudgetCell
        cell.budget = budgets[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let row = indexPath.row
        print("ROW: \(row)")
        
        let budget = self.budgets[indexPath.row]
        let viewController = UIStoryboard(name:"BudgetDetail", bundle: nil).instantiateViewController(withIdentifier: "BudgetDetailsScene") as! BudgetDetailsViewController
        //viewController.delegate = self
        viewController.budget = budget
        
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            budgets.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
}


// MARK: - Subtitle on UINavigationBar

extension UINavigationItem {
    func setTitle(title:String, subtitle:String) {
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont.systemFont(ofSize: 17)
        titleLabel.sizeToFit()
        
        let subtitleLabel = UILabel()
        subtitleLabel.text = subtitle
        subtitleLabel.font = UIFont.systemFont(ofSize: 12)
        subtitleLabel.textAlignment = .center
        subtitleLabel.sizeToFit()
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        stackView.distribution = .equalCentering
        stackView.axis = .vertical
        
        let width = max(titleLabel.frame.size.width, subtitleLabel.frame.size.width)
        stackView.frame = CGRect(x: 0, y: 0, width: width, height: 35)
        
        stackView.alignment = .center
        self.titleView = stackView
    }
}

extension UINavigationController {
    func pop(animated: Bool) {
        _ = self.popViewController(animated: animated)
    }
}
