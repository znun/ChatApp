//
//  ExpencessViewController.swift
//  ExpenseManager
//
//  Created by Mahmudul Hasan on 2/12/22.
//

import UIKit

class ExpensesViewController: UIViewController {

    //MARK:- IBOutlets
    
    //Labels

    //Text Fields
    
    //Buttons
    
    //test
    var expenseName = ["Utility","Fruits","Gym","Cricket","Baseball","tShirt","Movie"]
    var expenseCost = ["20000","10000","6500","5000","10000","500","450"]
    var expenseDes = ["Home Bill","Food and Fruits","Cloth of winter","Medicine and Doctor","Transport Bill"]
    //MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    //MARK: - IBActions
    
}

//Extensions
extension ExpensesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return expenseName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ExpenseViewCell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ExpenseViewCell
        cell.expenseName.text = expenseName[indexPath.row]
        cell.expenseCost.text = expenseCost[indexPath.row]
       // cell.expenseDes.text = expenseDes[indexPath.row]
        
        return cell
    }
    
    
}
