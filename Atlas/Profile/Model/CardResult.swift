//
//  CardResult.swift
//  Delivery
//
//  Created by Nurzhigit Smailov on 10/21/19.
//  Copyright © 2019 Nurzhigit Smailov. All rights reserved.
//

import Foundation

class CardResult:Decodable {
    var ds: Bool
    var html: String?
    var transaction_id: Int
    
    private enum CodingKeys: String, CodingKey {
        case ds = "3ds"
        case html
        case transaction_id
    }
    
}

