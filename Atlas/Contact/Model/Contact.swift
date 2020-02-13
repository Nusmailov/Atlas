//
//  Contact.swift
//  Atlas
//
//  Created by Nurzhigit Smailov on 2/11/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import Foundation

class Contact: Codable {
    var id: Int
    var address: String
    var lat: Double
    var lng: Double
    var call_phone: [String]
    var email: [String]
    var site: String
    var app_store: String?
    var google_play: String?
}

class ContactApi {
    static let info = "settings"
    static let views = "views"
}
