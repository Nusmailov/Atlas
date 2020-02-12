//
//  User.swift
//  Atlas
//
//  Created by Eldor Makkambayev on 1/13/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import Foundation

struct User: Codable {
    let id: Int
    let name: String
    let token: String?
    let contract_type: String?
    let contract_number: Int?
    let image_path: String?
    let requisites: String?
    let email: String?
    let contact: String?
    let email_verified_at: Int?
    let device_token: String?
    let device_type: String?
    let sound: Int
    let push: Int
    let city_id: Int
    let language: String
}

class UserModel: Codable {
    let result: User
     
    init(user: User) {
        self.result = user
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.result = try values.decode(User.self, forKey: .result)
    }
}

struct SearchUser: Codable {
    let id: Int
    let name: String
    let avatar_image: String?
    let role: String
    let phone: String
}

