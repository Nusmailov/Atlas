//
//  FilterViewModel.swift
//  Atlas
//
//  Created by Nurzhigit Smailov on 2/3/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import Foundation


class FilterViewModel {
    
    //MARK: - Properties
    var delegate: ProcessViewDelegate?
    var productList = [Product]()
    var max_page = 1
    var page = 1
    
    //MARK: - Functions
    func getProduct(category_id: Int, page: Int) {
        var parameters = Parameters()
        parameters["id"] = category_id
        if page == 1 {
            self.productList.removeAll()
        }
        delegate?.showLoader()
        ParseManager.shared.getRequest(url: ProductApi.sectionProducts, parameters: parameters,
               success: { (result: FilterModel) in
                self.delegate?.hideLoader()
                self.productList = result.products
                self.max_page = result.last_page
                self.page = result.current_page
                self.delegate?.updateUI()
        }) { (error) in
            self.delegate?.showErrorMessage(error)
        }
    }
}
