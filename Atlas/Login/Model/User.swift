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
    let token: String
    let contract_type: String?
    let contract_number: Int?
    let image_path: String?
    let requisites: String?
    let email: String?
    let contact: String?
    let email_verified_at: Int?
    let contract_type_name: String?
    let total_orders: Int?
    let total_cost: String?
    let created_at: String?
    let updated_at: String?
    let deleted_at: String?
}

struct SearchUser: Codable {
    let id: Int
    let name: String
    let avatar_image: String?
    let role: String
    let phone: String
}

