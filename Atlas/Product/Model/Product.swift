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
    var product_name: String
    var section_id: Int
    var product_description: String
    var product_price: Int
    var product_width: Int
    var product_length: Int
    var in_favorite: Bool
    var in_basket: Bool
    var images: [ImageModel]
    
    static func getImageUrl(url: String) -> URL {
        let url = "http://37.46.133.192:781/\(url)"
        return URL.init(string: url)!
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

class ImageModel: Codable {
    var image_path: String
}

class TotalProduct: Codable {
    var popular: [Product]
    var sections: [SectionProduct]
}

class SectionProduct: Codable {
    var id: Int
    var section_name: String
    var products: [Product]
}
