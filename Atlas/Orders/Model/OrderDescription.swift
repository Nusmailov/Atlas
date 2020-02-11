//
//  OrderDescription.swift
//  Atlas
//
//  Created by Nurzhigit Smailov on 2/11/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import Foundation


class OrderDescription: Codable {
    var order: Order
    var baskets: [BasketProduct]
}
