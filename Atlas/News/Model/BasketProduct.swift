//
//  BasketProduct.swift
//  Atlas
//
//  Created by Nurzhigit Smailov on 1/30/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import Foundation


class BasketProduct: Codable {
    var id: Int
    var user_id: Int
    var order_id: Int?
    var product_id: Int
    var area: Double
    var product_quantity: Int
    var cost: Double
}

class FavouriteProduct: Codable {
    var id: Int
    var user_id: Int
    var product_id: Int
}
