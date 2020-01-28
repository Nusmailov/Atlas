//
//  Cats.swift
//  Delivery
//
//  Created by Nurzhigit Smailov on 9/17/19.
//  Copyright © 2019 Nurzhigit Smailov. All rights reserved.
//

import Foundation


class Cats: Decodable {
    var id: Int
    var parent_id: Int
    var color: String?
    var image: String?
    var name: String
    var products: [Product]?
    
    private enum CodingKeys: String, CodingKey  {
        case id
        case parent_id
        case color
        case image
        case name
        case products
    }
}
