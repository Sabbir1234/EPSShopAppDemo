//
//  Model.swift
//  EPSDemoApp
//
//  Created by Sabbir Hossain on 2/2/23.
//

import Foundation

struct ShopPost: Codable {
    var UserID: Int
    var CompanyID: Int
    var ShopFK: Int
}

struct OrderPost: Codable {
    var UserID: Int
    var CompanyID: Int
    var ShopFK: Int
    var StatusID: Int
}

// MARK: - Shop Model
struct Shop: Codable {
    let shopID, statusID, districtID, thanaID: Int?
    let orderID: Int?
    let latitude, longitude: Double?
    let shopName: String?
    let address: String?
    let district, thana: String?
    let code: String?
    let date: String?
    let confirm, partialDelivered, delivered: Int?
    let phoneNumber: String?
}

// MARK: - Order Model
struct Order: Codable {
    let bookingID, voucherID, userID, compnayID: Int?
    let shopFK, rOuteFK, typeID, clientID: Int?
    let totalItem, statusID: Int?
    let shopName, address, remarks: String?
    let code: String?
    let totalValue, paidAmount, dueAmount, totalDiscount: Int?
    let cd: String?
    let deliveryDate: String?
    let products: String?
}
