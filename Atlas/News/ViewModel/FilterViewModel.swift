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
    
    func getSearch(parameters: Parameters) {
        ParseManager.shared.postRequest(url: ProductApi.search, parameters: parameters, success: { (result: PaginationResult<[Product]>) in
            self.productList = result.data
            self.max_page = result.last_page
            self.page = result.current_page
            self.delegate?.hideLoader()
            self.delegate?.updateUI()
        }) { (error) in
            self.delegate?.showErrorMessage(error)
        }
    }
    
    func getPopularProducts() {
        ParseManager.shared.getRequest(url: ProductApi.popularProducts,
            success: { (result: PaginationResult<[Product]>) in
            self.productList = result.data
            self.max_page = result.last_page
            self.page = result.current_page
            self.delegate?.hideLoader()
            self.delegate?.updateUI()
        }) { (error) in
            self.delegate?.showErrorMessage(error)
        }
    }
}
