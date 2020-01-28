//
//  Office.swift
//  Delivery
//
//  Created by Nurzhigit Smailov on 9/10/19.
//  Copyright © 2019 Nurzhigit Smailov. All rights reserved.
//

import Foundation

class Office: Decodable {
    var id: Int
    var city_id: Int
    var address: String
    var description: String
    var created_at: String
    var updated_at: String
    
    private enum CodingKeys: String, CodingKey  {
        case id
        case city_id
        case address
        case description
        case created_at
        case updated_at
    }
}
