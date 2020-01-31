//
//  ProductBasketViewModel.swift
//  Atlas
//
//  Created by Nurzhigit Smailov on 1/30/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import Foundation


protocol ProductBasketDelegate: ProcessViewDelegate {
    func addedBasket(product_id: Int)
    func removedBasket(product_id: Int)
}

class ProductBasketViewModel {
    
    var delegate: ProductBasketDelegate?
    var productList = [Product]()
    
    func addToBasket(product_id: Int) {
        var parameters = Parameters()
        parameters["product_id"] = product_id
        ParseManager.shared.postRequest(url: ProductApi.basket, parameters: parameters,
            success: { (result: BasketProduct) in
                self.delegate?.addedBasket(product_id: product_id)
        }) { (error) in
            self.delegate?.showErrorMessage(error)
        }
    }
    
    func removeBasket(product_id: Int) {
        var parameters = Parameters()
        parameters["product_id"] = product_id
        ParseManager.shared.deleteRequest(url: ProductApi.busket, url_parameters: parameters,
            success: { (result: Int) in
                self.delegate?.removedBasket(product_id: product_id)
        }) { (error) in
            self.delegate?.showErrorMessage(error)
        }
    }
    
    func getBasketList() {
        ParseManager.shared.getRequest(url: ProductApi.basketList, success: { (result: [Product]) in
            self.productList = result
            self.delegate?.updateUI()
        }) { (error) in
            self.delegate?.showErrorMessage(error)
        }
    }
}
