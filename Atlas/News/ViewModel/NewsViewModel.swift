//
//  NewsViewModel.swift
//  Atlas
//
//  Created by Nurzhigit Smailov on 1/28/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import Foundation

protocol BannerProcessDelegate: ProcessViewDelegate {
    func updateBannerCollectionView()
}

protocol CategorySectionProcessDelegate: ProcessViewDelegate {
    func updateSectionCollectionView()
}

class NewsViewModel {
    let token = UserManager.getCurrentToken()
    var newsList = [News]()
    var sectionList = [Section]()
    var delegate: ProcessViewDelegate?
    var bannerDelegate: BannerProcessDelegate?
    var categorySectionDelegate: CategorySectionProcessDelegate?
    var productList = [String: [Product]]()
    var productKeys = [String]()
    
    func getBannerList() {
        self.categorySectionDelegate?.showLoader()
        ParseManager.shared.getRequest(url: NewsApi.getBanner,
            success: { (result: [News]) in
            self.categorySectionDelegate?.hideLoader()
            self.newsList = result
            self.bannerDelegate?.updateBannerCollectionView()
        }) { (error) in
            self.delegate?.showErrorMessage(error)
        }
    }
    
    func getCategoryList() {
        self.categorySectionDelegate?.showLoader()
        ParseManager.shared.getRequest(url: NewsApi.sections,
            success: { (result: SectionData) in
            self.categorySectionDelegate?.hideLoader()
            self.sectionList = result.sections
            self.categorySectionDelegate?.updateSectionCollectionView()
        }) { (error) in
            self.categorySectionDelegate?.showErrorMessage(error)
        }
    }
    
    func getProductList() {
        self.delegate?.showLoader()
        productList.removeAll()
        productKeys.removeAll()
        ParseManager.shared.getRequest(url: NewsApi.products,
            success: { (result: TotalProduct) in
                self.productList["Самые продоваемые"] = result.popular
                self.productKeys.append("Самые продоваемые")
                for i in result.sections {
                    self.productList[i.section_name] = i.products
                    self.productKeys.append(i.section_name)
                }
                self.delegate?.updateUI()
        }) { (error) in
            self.delegate?.showErrorMessage(error)
        }
    }
    
    func addRemoveFavourite(product_id: Int, state: Bool) {
        for i in productKeys {
            for j in 0 ..< productList[i]!.count {
                if productList[i]![j].id == product_id {
                    productList[i]![j].in_favorite = state
                }
            }
        }
    }
    
    func addRemoveBasket(product_id: Int, state: Bool) {
        for i in productKeys {
            for j in 0 ..< productList[i]!.count {
                if productList[i]![j].id == product_id {
                    productList[i]![j].in_basket = state
                }
            }
        }
    }
}
