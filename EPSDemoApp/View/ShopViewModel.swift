//
//  ShopViewModel.swift
//  EPSDemoApp
//
//  Created by Sabbir Hossain on 2/2/23.
//

import Foundation


class ShopViewModel {
    
    var shop: Shop?
    var orders: [Order]?
    
    var orderLoadedAction: (()->())?
    
    func getShopDetails(completion: ((_ success: Bool) -> Void)? = nil) {
        // Prepare URL
        let url = URL(string: "http://test.bdbizhub.com/Api/App/Shop")
        
        guard let requestUrl = url else { fatalError() }
        
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        
        // Set HTTP Request Header
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let newTodoItem = ShopPost(UserID: 120, CompanyID: 29, ShopFK: 8)
        do {
            let jsonData = try JSONEncoder().encode(newTodoItem)
            request.httpBody = jsonData
            
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                
                if let error = error {
                    print("Error took place \(error)")
                    return
                }
                guard let data = data else {return}
                do{
                    let shop = try JSONDecoder().decode(Shop.self, from: data)
                    self.shop = shop
                    self.orderLoadedAction?()
                }catch let jsonErr{
                    print(jsonErr)
                }
            }
            task.resume()
        } catch let error {
            debugPrint(error.localizedDescription)
        }
    }
    
    func getOrderDetails(completion: ((_ success: Bool) -> Void)? = nil) {
        // Prepare URL
        let url = URL(string: "http://test.bdbizhub.com/Api/App/Orders")
        
        guard let requestUrl = url else { fatalError() }
        
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        
        // Set HTTP Request Header
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let newTodoItem = OrderPost(UserID: 120, CompanyID: 29, ShopFK: 8, StatusID: 0)
        do {
            let jsonData = try JSONEncoder().encode(newTodoItem)
            request.httpBody = jsonData
            
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                
                if let error = error {
                    print("Error took place \(error)")
                    completion?(false)
                }
                guard let data = data else {return}
                do{
                    let orders = try JSONDecoder().decode([Order].self, from: data)
                    self.orders = orders
                    completion?(true)
                    self.orderLoadedAction?()
                }catch let jsonErr{
                    print(jsonErr)
                }
            }
            task.resume()
        } catch let error {
            debugPrint(error.localizedDescription)
        }
    }
    
    func getFilteredOrder(orderType: OrderType) {
        var statusID = 0
        switch orderType {
        case .Confirmed:
            statusID = 12
        case .PartiallyDelivered:
            statusID = 15
        case .Delivered:
            statusID = 9
        default:
            break
        }
        getOrderDetails { [weak self]success in
            if success {
                self?.orders = self?.orders?.filter({ order in
                    return order.statusID == statusID
                })
                self?.orderLoadedAction?()
            }
        }
    }
}
