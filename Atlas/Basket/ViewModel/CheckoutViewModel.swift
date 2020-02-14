//
//  CheckoutViewModel.swift
//  Atlas
//
//  Created by Nurzhigit Smailov on 2/13/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import Foundation


protocol CheckoutDelegate: ProcessViewDelegate {
    func orderDone()
}

class CheckoutViewModel {
    //MARK: - Properties
    weak var delegate: CheckoutDelegate?
    
    
    //MARK: - Functions
    func doOrder(parameters: Parameters) {
        guard isValid(parameters: parameters) else { return }
        ParseManager.shared.postRequest(url: OrderApi.doOrder, parameters: parameters, success: { (result: Order) in
            self.delegate?.orderDone()
        }) { (error) in
            self.delegate?.showErrorMessage(error)
        }
    }
    
    func isValid(parameters: Parameters) -> Bool{
        guard parameters["order_type"] != nil else {
            self.delegate?.showErrorMessage("Выберите тип заказа")
            return false
        }
        return true
    }
}
