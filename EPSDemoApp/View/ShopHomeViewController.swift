//
//  ShopHomeViewController.swift
//  EPSDemoApp
//
//  Created by Sabbir Hossain on 2/2/23.
//

import UIKit

class ShopHomeViewController: UIViewController {

    @IBOutlet weak var shopTableView: UITableView!
    private var viewModel = ShopViewModel()
    var filteredOrders = [Order]()
    var isFiltering = false
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getShopDetails()
        viewModel.getOrderDetails()
        setupTableView()
        viewModel.orderLoadedAction = { [weak self] in
            DispatchQueue.main.async {
                self?.shopTableView.reloadData()
            }
        }
    }
    
    private func setupTableView() {
        shopTableView.delegate = self
        shopTableView.dataSource = self
        shopTableView.register(UINib(nibName: "ShopHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "ShopHeaderView")
    }
    
    func filterContentForSearchText(searchText: String,isFiltering: Bool) {
        filteredOrders = (viewModel.orders?.filter({ order in
            guard let bookId = order.bookingID, let toltalPrice = order.totalValue else { return (viewModel.orders != nil) }
            let bookingIDMatch = String(bookId).range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
            let amountMatch = String(toltalPrice).range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
            return (bookingIDMatch != nil) || (amountMatch != nil) }))!
        self.isFiltering = isFiltering
        shopTableView.reloadData()
    }
    
}

extension ShopHomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredOrders.count
        }
        return viewModel.orders?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderedItemCell") as! OrderedItemCell
        if !isFiltering {
            if let order = viewModel.orders?[indexPath.row] {
                cell.configureCell(order: order)
            }
        }
        else {
            cell.configureCell(order: filteredOrders[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "ShopHeaderView") as! ShopHeaderView
        headerView.delegate = self
        headerView.setupUI()
        headerView.shopNameLabel.text = viewModel.shop?.shopName
        headerView.shopAddressLabel.text = "\(viewModel.shop?.address ?? "") \(viewModel.shop?.thana ?? "") \(viewModel.shop?.district ?? "")"
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 280
    }
    
}

extension ShopHomeViewController: ShopHeaderViewDelegate {
    func getFilteredOrders(orderType: OrderType) {
        viewModel.getFilteredOrder(orderType: orderType)
    }
    
}

