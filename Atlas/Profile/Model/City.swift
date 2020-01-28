//
//  City.swift
//  Delivery
//
//  Created by Nurzhigit Smailov on 9/18/19.
//  Copyright © 2019 Nurzhigit Smailov. All rights reserved.
//

import Foundation

class City: Decodable {
    var id: Int
    var name: String
    
    init (id: Int, name: String) {
        self.id = id
        self.name = name
    }
    private enum CodingKeys: String, CodingKey {
        case id
        case name
    }
}
