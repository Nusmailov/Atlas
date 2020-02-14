//
//  ChechkoutText.swift
//  Atlas
//
//  Created by Nurzhigit Smailov on 2/5/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import Foundation


enum ChechkoutText: String {
    case preOrder = "Предзаказ"
    case reservation = "Бронирование"
    case orderStorage = "Заказ с хранением"
    case regularOrder = "Обычный заказ"
    
    var showHide: Bool {
        switch self {
        case .preOrder:
            return true
        default:
            return false
        }
    }
    
    var typeText: String {
        switch self {
        case .preOrder:
            return "Preorder"
        case .reservation:
            return "Reservation"
        case .orderStorage:
            return "Storage"
        case .regularOrder:
            return "Regular"            
        }
    }
    
    var text: String {
        switch self {
        case .preOrder:
            return "Предзаказывая товар, вам нужно будет указать дату подготовки вашего заказа. При наступлении даты предзаказа, вам нужно будет забрать ваш заказ со склада."
        case .reservation:
            return "Бронирование - пользуясь данной опцией вы получаете 2 часа на бронирование товара, за это время необходимо провести оплату по счету путём банковского перевода"
        case .orderStorage:
            return "Хранение-пользуясь данной опцией вы получаете возможность вывозить товар по мере потребности. Необходимо согласовать график вывоза товара и провести 100% предоплату."
        case .regularOrder:
            return "Обычный заказ - после Оформления заказа, необходимо провести оплату и организовать самовывоз."
        }
    }
}
