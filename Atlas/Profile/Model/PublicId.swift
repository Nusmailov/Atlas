//
//  File.swift
//  Delivery
//
//  Created by Nurzhigit Smailov on 10/18/19.
//  Copyright © 2019 Nurzhigit Smailov. All rights reserved.
//

import Foundation


class PublicId: Decodable {
    var PublicId: String
    
    private enum CodingKeys: String, CodingKey {
        case PublicId
    }
}
