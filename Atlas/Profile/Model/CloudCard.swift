//
//  CloudCard.swift
//  Delivery
//
//  Created by Nurzhigit Smailov on 10/15/19.
//  Copyright © 2019 Nurzhigit Smailov. All rights reserved.
//

import Foundation


class CloudCard: Codable {
    var id: Int
    var cardFirstSix: Int
    var cardLastFour: Int
    var cardType: String
    var cardTypeCode: Int
    
    private enum CodingKeys: String, CodingKey {
        case id
        case cardFirstSix
        case cardLastFour
        case cardType
        case cardTypeCode
    }
}
