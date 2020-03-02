//
//  ProductViewModel.swift
//  Atlas
//
//  Created by Nurzhigit Smailov on 2/6/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import Foundation


class ProductViewModel {
    //MARK: - Properties
    weak var delegate: ProcessViewDelegate?
    var productList = [Product]()
    
    
    //MARK: - Functions
    func getByList(product_id: Int) {
        ParseManager.shared.getRequest(url: ProductApi.bywithit, parameters: ["id" : product_id], success: {
            (result: [Product]?) in
            self.productList = result ?? []
            self.delegate?.updateUI()
        }) { (error) in
            self.delegate?.showErrorMessage(error)
        }
    }
    
    func checkPrimary() {
        
    }
}
