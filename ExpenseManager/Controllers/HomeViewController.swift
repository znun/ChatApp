//
//  HomeViewController.swift
//  ExpenseManager
//
//  Created by Mahmudul Hasan on 1/12/22.
//

import UIKit

class HomeViewController: UIViewController {

    //MARK:- IBOutlets

    //Labels
    @IBOutlet weak var dateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    currentDate()
       
    }
    //functions
    func currentDate() {
        let date = Date()
        let formater = DateFormatter()
        formater.dateFormat = "dd/MM/yyyy"
        let result = formater.string(from: date)
        dateLabel.text = result
    }
    

}
