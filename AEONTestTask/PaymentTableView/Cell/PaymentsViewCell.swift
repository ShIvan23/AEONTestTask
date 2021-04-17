//
//  PaymentsViewCell.swift
//  AEONTestTask
//
//  Created by Ivan on 17.04.2021.
//

import UIKit

class PaymentsViewCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet weak var operationLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
