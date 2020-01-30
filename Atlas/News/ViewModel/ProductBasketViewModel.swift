//
//  ProductBasketViewModel.swift
//  Atlas
//
//  Created by Nurzhigit Smailov on 1/30/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import Foundation


protocol ProductBasketDelegate: ProcessViewDelegate {
    func addedBasket()
    func removedBasket()
}

class ProductBasketViewModel {
    
    var delegate: ProductBasketDelegate?
    
    func addToBasket(product_id: Int) {
        var parameters = Parameters()
        parameters["product_id"] = product_id
        ParseManager.shared.postRequest(url: ProductApi.basket, parameters: parameters,
            success: { (result: FavouriteProduct) in
            self.delegate?.addedBasket()
        }) { (error) in
            self.delegate?.showErrorMessage(error)
        }
    }
    
    func removeBasket(product_id: Int) {
        var parameters = Parameters()
        parameters["id"] = product_id
        ParseManager.shared.deleteRequest(url: ProductApi.basket, url_parameters: parameters,
            success: { (result: String) in
            self.delegate?.removedBasket()
        }) { (error) in
            self.delegate?.showErrorMessage(error)
        }
    }
}
