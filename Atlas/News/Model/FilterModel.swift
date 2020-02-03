//
//  FilterModel.swift
//  Atlas
//
//  Created by Nurzhigit Smailov on 2/3/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import Foundation


class FilterModel: Codable {
    var current_page: Int
    var last_page: Int
    var products: [Product]
}
