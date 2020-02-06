//
//  ProductViewModel.swift
//  Atlas
//
//  Created by Nurzhigit Smailov on 2/6/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import Foundation


class ProductViewModel {
    weak var delegate: ProcessViewDelegate?
    var productList = [Product]()
    
    func getByList(product_id: Int) {
        ParseManager.shared.getRequest(url: ProductApi.bywithit, parameters: ["id" : product_id], success: { (result: [Product]) in
            self.productList = result
            self.delegate?.updateUI()
        }) { (error) in
            self.delegate?.showErrorMessage(error)
        }
    }
}
