//
//  ShopHeaderView.swift
//  EPSDemoApp
//
//  Created by Sabbir Hossain on 2/2/23.
//

import UIKit

protocol ShopHeaderViewDelegate {
    func getFilteredOrders(orderType: OrderType)
    func filterContentForSearchText(searchText: String,isFiltering: Bool)
}

enum OrderType {
    case Confirmed
    case PartiallyDelivered
    case Delivered
    case None
}

class ShopHeaderView: UITableViewHeaderFooterView, UISearchBarDelegate {
    
    @IBOutlet weak var shopNameLabel: UILabel!
    @IBOutlet weak var shopAddressLabel: UILabel!
    @IBOutlet weak var orderCategoryView: UIStackView!
    
    @IBOutlet weak var confirmedOrderView: UIView!
    @IBOutlet weak var partiallyDeliveredView: UIView!
    @IBOutlet weak var deliveredView: UIView!
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var isFiltering: Bool{
        return  ((searchBar.text?.isEmpty) != nil)
    }
    
    var delegate: ShopHeaderViewDelegate?
    
    
    func setupUI() {
        searchBar.delegate = self
        for v in orderCategoryView.subviews {
            v.layer.cornerRadius = 10
        }
    }
    
    @IBAction func categorySelectionButton(_ sender: UIButton) {
        switch sender.tag {
        case 11:
            confirmedOrderView.layer.opacity = 0.7
            partiallyDeliveredView.layer.opacity = 1.0
            deliveredView.layer.opacity = 1.0
            delegate?.getFilteredOrders(orderType: .Confirmed)
        case 22:
            confirmedOrderView.layer.opacity = 1.0
            partiallyDeliveredView.layer.opacity = 0.7
            deliveredView.layer.opacity = 1.0
            delegate?.getFilteredOrders(orderType: .PartiallyDelivered)
        case 33:
            confirmedOrderView.layer.opacity = 1.0
            partiallyDeliveredView.layer.opacity = 1.0
            deliveredView.layer.opacity = 0.7
            delegate?.getFilteredOrders(orderType: .Delivered)
        default:
            break
        }
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if let searchText = searchBar.text {
            delegate?.filterContentForSearchText(searchText: searchText, isFiltering: isFiltering)
        }
    }
}
