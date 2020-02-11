//
//  ContactInfoText.swift
//  Atlas
//
//  Created by Nurzhigit Smailov on 2/11/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import Foundation



enum ContactInfoText: String {
    case privacy = "privacy"
    case payment = "payment"
    case us_first = "us_first"
    
    var text: String {
        switch self {
        case .privacy:
            return "privacy"
        case .payment:
            return "payment"
        case .us_first:
            return "us_first"
        }
    }
    var title: String {
        switch self {
        case .privacy:
            return "Правовые документы"
        case .us_first:
            return "О нас"
        case .payment:
            return "Информация о платежах"
        }
    }
}
