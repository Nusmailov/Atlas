//
//  ProductFavouriteViewModel.swift
//  Atlas
//
//  Created by Nurzhigit Smailov on 1/29/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import Foundation

protocol ProductFavouriteDelegate: ProcessViewDelegate {
    func addedFavourite()
    func removedFavourite()
}

class ProductFavouriteViewModel {
    var delegate: ProductFavouriteDelegate?
    
    func addToFavorite(product_id: Int) {
        var parameters = Parameters()
        parameters["product_id"] = product_id
        ParseManager.shared.postRequest(url: ProductApi.favorite, parameters: parameters,
            success: { (result: FavouriteProduct) in
            self.delegate?.addedFavourite()
        }) { (error) in
            self.delegate?.showErrorMessage(error)
        }
    }
    
    func removeFavourite(product_id: Int) {
        var parameters = Parameters()
        parameters["id"] = product_id
        ParseManager.shared.deleteRequest(url: ProductApi.favorite, url_parameters: parameters,
            success: { (result: String) in
                self.delegate?.removedFavourite()
        }) { (error) in
            self.delegate?.showErrorMessage(error)
        }
    }
    
}
