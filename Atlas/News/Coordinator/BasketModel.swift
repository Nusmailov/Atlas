//
//  BasketModel.swift
//  Atlas
//
//  Created by Nurzhigit Smailov on 1/31/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import Foundation


class BasketModel {
    private init() {}
    static let shared = BasketModel()
    var basketList = [Int : Bool]()
}
