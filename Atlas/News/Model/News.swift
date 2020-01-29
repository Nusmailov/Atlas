//
//  News.swift
//  Delivery
//
//  Created by Nurzhigit Smailov on 9/17/19.
//  Copyright © 2019 Nurzhigit Smailov. All rights reserved.
//

import Foundation


class News: Decodable {
    var id: Int
    var banner_image: String
    var transition_url: String
    
    
    private enum CodingKeys: String, CodingKey  {
        case id
        case banner_image
        case transition_url
    }
}
