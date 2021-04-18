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
    
    // MARK: - Puplic Methods
    func createCell(payment: Response) {
        operationLabel.text = payment.desc
        operationLabel.lineBreakMode = .byWordWrapping
        operationLabel.numberOfLines = 0
       
        guard let intervalFloat = payment.created else { return }
        dateLabel.text = formateDate(floatTime: intervalFloat)
        
        currencyLabel.text = payment.currency
        
        guard let amount = payment.amount else { return }
        amountLabel.text = String(describing: amount)
    }
    
    private func formateDate(floatTime: Float) -> String {
        let interval = TimeInterval(floatTime)
        let date = Date.init(timeIntervalSince1970: interval)
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        return dateFormatter.string(from: date)
    }
    
}
