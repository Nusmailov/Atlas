//
//  ProductBasketViewModel.swift
//  Atlas
//
//  Created by Nurzhigit Smailov on 1/30/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import Foundation

class BasketViewModel {
    
    //MARK: - Properties
    weak var delegate: ProcessViewDelegate?
    var productList = [BasketProduct]()
    var page = 1
    var max_page = 1
    
    deinit {
        print("BasketViewModel deallocated")
    }
    
    //MARK: - Requests
    func getBasketList() {
        ParseManager.shared.getRequest(url: ProductApi.basketList,
            success: { (result: [BasketProduct]) in
            self.productList = result
            for i in self.productList {
                BasketModel.shared.basketList[i.id] = i.product.in_basket
            }
            self.delegate?.hideLoader()
            self.delegate?.updateUI()
        }) { (error) in
            self.delegate?.showErrorMessage(error)
        }
    }
    
    func addToBasket(product_id: Int, count: Int = 0) {
        var parameters = Parameters()
        parameters["product_id"] = product_id
        if count != 0 {
            parameters["product_quantity"] = count
        }
        
        ParseManager.shared.postRequest(url: ProductApi.basket, parameters: parameters,
            success: { (result: BasketProduct) in
                BasketModel.shared.basketList[product_id] = true
                self.delegate?.updateUI()
        }) { (error) in
            self.delegate?.showErrorMessage(error)
        }
    }
    
    func removeBasket(product_id: Int) {
        var parameters = Parameters()
        parameters["product_id"] = product_id
        ParseManager.shared.deleteRequest(url: ProductApi.busket, url_parameters: parameters,
            success: { (result: Int) in
                BasketModel.shared.basketList[product_id] = false
                for i in 0 ..< self.productList.count {
                    if self.productList[i].id == product_id {
                        self.productList.remove(at: i)
                        break
                    }
                }
                self.delegate?.updateUI()
        }) { (error) in
            self.delegate?.showErrorMessage(error)
        }
    }
    
    func totalPrice() -> String {
        var sum = 0.0
        for i in productList {
            sum += Double(i.product.product_price) * (i.product.area * Double(i.product_quantity))
        }
        return String(format:"%.2f", sum)
    }
    
    func updateBasket() {
        var parameters = Parameters()
        for  i in productList {
            parameters["arr[\(i.id)]"] = i.product_quantity
        }
        ParseManager.shared.multipartFormData(url: ProductApi.updateBasket, parameters: parameters, success: {
            (result: [BasketProduct]) in
            self.delegate?.updateUI()
        }) { (error) in
            self.delegate?.showErrorMessage(error)
        }
    }
}
