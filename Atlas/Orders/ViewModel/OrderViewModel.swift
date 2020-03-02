//
//  OrderViewModel.swift
//  Atlas
//
//  Created by Nurzhigit Smailov on 1/23/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import Foundation


class OrderViewModel {
    var orderList = [Order]()
    var basketList = [BasketProduct]()
    var max_page = 1
    var page = 1
    weak var delegate: ProcessViewDelegate?
    
    func getOrderList() {
        ParseManager.shared.getRequest(url: OrderApi.orderList, success: {
            (result: PaginationResult<[Order]>) in
            self.max_page = result.last_page
            self.page = result.current_page
            self.orderList = result.data
            self.delegate?.hideLoader()
            self.delegate?.updateUI()
        }) { (error) in
            self.delegate?.showErrorMessage(error)
        }
    }
    
    func getById(order_id: Int) {
        delegate?.showLoader()
        ParseManager.shared.getRequest(url: OrderApi.order, parameters: ["id" : order_id], success: {
            (result: OrderDescription) in
            self.basketList = result.baskets
            self.delegate?.hideLoader()
            self.delegate?.updateUI()
        }) { (error) in
            self.delegate?.showErrorMessage(error)
        }
    }
}
