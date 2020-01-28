//
//  Order.swift
//  Delivery
//
//  Created by Nurzhigit Smailov on 9/4/19.
//  Copyright © 2019 Nurzhigit Smailov. All rights reserved.
//

import Foundation
import UIKit

class Order: Decodable {
    var id: Int
    var type: String
    var user_id: Int?
    var courier_id: Int?
    var status: Int?
    var status_info: String?
    var delivery_date: String?
    var delivery_hour: String?
    var pay_type: Int?
    var pay_type_info: String?
    var pay_bool: Int?
    var bonus: Int?
    var total_price: Double?
    var products: [ProductOrder]?
    var address: Address?
    var card: CloudCard?
    
    private enum CodingKeys: String, CodingKey  {
        case id
        case type
        case user_id
        case courier_id
        case status
        case status_info
        case delivery_date
        case delivery_hour
        case pay_type
        case pay_type_info
        case pay_bool
        case bonus
        case total_price
        case products
        case address
        case card
    }
}

class OrderData: Decodable {
    var current_page: Int
    var count_pages: Int
    var count_date: Int
    var offset: Int
    var limit: Int
    var data: [Order]?
    
    private enum CodingKeys: String, CodingKey {
        case current_page
        case count_pages
        case count_date
        case offset
        case limit
        case data
    }
}

enum OrderStatus: String {
    case pendingReview = "PendingReview"
    case processed = "Processed"
    case reject = "Reject"
    case acceptedFStock = "AcceptedFStock"
    case awaitingPoDate = "AwaitingPoDate"
    
    var textColor: UIColor {
        switch self {
        case .reject:
            return .red
        case .acceptedFStock:
            return .green
        default:
            return UIColor(red: 1, green: 0.753, blue: 0, alpha: 1)
        }
    }
    
    var circleColor:UIColor {
        switch self {
        case .reject:
            return .whiteBlue
        case .acceptedFStock:
            return .whiteBlue
        default:
            return UIColor(red: 0.784, green: 0.204, blue: 0.278, alpha: 1)
        }
    }
}
