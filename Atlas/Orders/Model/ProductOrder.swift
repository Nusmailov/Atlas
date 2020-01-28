//
//  ProductOrder.swift
//  Delivery
//
//  Created by Nurzhigit Smailov on 9/4/19.
//  Copyright © 2019 Nurzhigit Smailov. All rights reserved.
//

import Foundation


class ProductOrder: Decodable{
    var id: Int
    var count: Int
    var all_price: Int
    var name: String
    var images: [String]
    
    private enum CodingKeys: String, CodingKey  {
        case id
        case name
        case count
        case all_price
        case images
    }
}
