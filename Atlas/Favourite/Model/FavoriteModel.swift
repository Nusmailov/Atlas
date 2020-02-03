//
//  FavoriteModel.swift
//  Atlas
//
//  Created by Nurzhigit Smailov on 1/31/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import Foundation


class FavoriteModel {
    private init() {}
    static let shared = FavoriteModel()
    var favoriteList = [Int : Bool]()
}
