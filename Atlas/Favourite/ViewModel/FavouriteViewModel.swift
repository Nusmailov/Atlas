//
//  ProductFavouriteViewModel.swift
//  Atlas
//
//  Created by Nurzhigit Smailov on 1/29/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import Foundation

class FavouriteViewModel {
    var delegate: ProcessViewDelegate?
    var favouriteList = [Product]()
    var max_page = 1
    var page = 1
    
    func addToFavorite(product_id: Int) {
        var parameters = Parameters()
        parameters["product_id"] = product_id
        ParseManager.shared.postRequest(url: ProductApi.favorite, parameters: parameters,
            success: { (result: FavouriteProduct) in
                FavoriteModel.shared.favoriteList[product_id] = true
                self.delegate?.updateUI()
        }) { (error) in
            self.delegate?.showErrorMessage(error)
        }
    }
    
    func removeFavourite(product_id: Int) {
        var parameters = Parameters()
        parameters["product_id"] = product_id
        ParseManager.shared.deleteRequest(url: ProductApi.favorite, url_parameters: parameters,
            success: { (result: Int) in
                FavoriteModel.shared.favoriteList[product_id] = false
                for i in 0 ..< self.favouriteList.count {
                    if self.favouriteList[i].id == product_id {
                        self.favouriteList.remove(at: i)
                        break
                    }
                }
                self.delegate?.updateUI()
        }) { (error) in
            self.delegate?.showErrorMessage(error)
        }
    }
    
    func getFavouriteList(page: Int) {
        var parameters = Parameters()
        parameters["page"] = page
        if page == 1 { self.favouriteList.removeAll() }
        self.delegate?.showLoader()
        ParseManager.shared.getRequest(url: ProductApi.favorite, success: { (result: PaginationResult<[Product]>) in
            self.delegate?.hideLoader()
            self.favouriteList.append(contentsOf: result.data)
            self.page = result.current_page
            self.max_page = result.last_page
            for i in self.favouriteList {
                FavoriteModel.shared.favoriteList[i.id] = i.in_favorite
            }
            self.delegate?.updateUI()
        }) { (error) in
            self.delegate?.showErrorMessage(error)
        }
    }
    
}
