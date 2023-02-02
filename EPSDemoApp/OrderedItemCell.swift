//
//  OrderedItemCell.swift
//  EPSDemoApp
//
//  Created by Sabbir Hossain on 2/2/23.
//

import UIKit

class OrderedItemCell: UITableViewCell {
    @IBOutlet weak var orderId: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var totalItemLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(order: Order) {
        if let orderId = order.bookingID, let date = order.deliveryDate, let price = order.totalValue, let totalItem = order.totalItem {
            self.orderId.text = "Order ID #\(orderId)"
            self.dateLabel.text = date
            self.priceLabel.text = "BDT: \(price)"
            self.totalItemLabel.text = "Total Item: \(totalItem)"
        }
    }

}
