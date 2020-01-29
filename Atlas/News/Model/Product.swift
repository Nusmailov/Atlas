//
//  Product.swift
//  Delivery
//
//  Created by Nurzhigit Smailov on 9/2/19.
//  Copyright © 2019 Nurzhigit Smailov. All rights reserved.
//

import Foundation

class Product: Codable {
    var id: Int
    var cat_id: Int
    var name: String
    var description: String
    var show_count: Int
    var price: Int
    var in_favorite: Bool
    var in_basket: Bool
    var images: [String]?
    
    
    static func getImageUrl(url: String) -> URL {
        let url = "http://37.46.133.192:781/\(url)"
        return URL.init(string: url)!
    }
    
    
    static func == (first: Product, second: Product) -> Bool {
        return first.id == second.id && first.name == second.name && first.description == second.description
    }
}

class ProductModel: Codable {
    let data: [Product]
    let current_page: Int
    let count_pages: Int
    let count_date: Int
    let offset: Int
    let limit: Int
}
