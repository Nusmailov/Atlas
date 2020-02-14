//
//  Order.swift
//  Delivery
//
//  Created by Nurzhigit Smailov on 9/4/19.
//  Copyright © 2019 Nurzhigit Smailov. All rights reserved.
//

import Foundation
import UIKit

class Order: Codable {
    var id: Int
    var user_id: Int
    var area_sum: Double
    var cost_sum: Double
    var order_date: String?
    var order_type: String
    var order_status: String
    var order_type_name: String
    var order_status_name: String
    
    private enum CodingKeys: String, CodingKey  {
        case id
        case user_id
        case area_sum
        case cost_sum
        case order_date
        case order_type
        case order_status
        case order_type_name
        case order_status_name
    }
}

class OrderData: Codable {
    var current_page: Int
    var last_page: Int
    var data: [Order]
    
    private enum CodingKeys: String, CodingKey {
        case current_page
        case last_page
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

class OrderApi {
    static let orderList = "order/list"
    static let order = "order"
    static let doOrder = "order"
}
