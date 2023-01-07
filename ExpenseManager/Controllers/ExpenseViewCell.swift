//
//  EnpenseViewCell.swift
//  ExpenseManager
//
//  Created by Mahmudul Hasan on 12/12/22.
//

import UIKit

class ExpenseViewCell: UITableViewCell {

    //MARK:- IBOutlets

    //Labels
    @IBOutlet weak var expenseName: UILabel!
    @IBOutlet weak var expenseCost: UILabel!
    @IBOutlet weak var expenseDes: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
