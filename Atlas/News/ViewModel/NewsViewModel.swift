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

protocol BasketCountDelegate: class {
    func updateCount(count: Int)
}

class NewsViewModel {
    
    //MARK: - Properties
    let token = UserManager.getCurrentToken()
    var newsList = [News]()
    var sectionList = [Section]()
    weak var delegate: ProcessViewDelegate?
    weak var bannerDelegate: BannerProcessDelegate?
    weak var categorySectionDelegate: CategorySectionProcessDelegate?
    weak var basketCountDelegate: BasketCountDelegate?
    var productList = [String: [Product]]()
    var productKeys = [String]()
    var categoryIdList = [Int]()
    var sectionIdList = [Int]()
    
    //MARK: - Functions
    func getBannerList() {
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
        ParseManager.shared.getRequest(url: NewsApi.sections,
            success: { (result: SectionData) in
            self.categorySectionDelegate?.hideLoader()
            self.sectionList = result.sections
            for i in result.sections {
                self.categoryIdList.append(i.id)
            }
            self.categorySectionDelegate?.updateSectionCollectionView()
        }) { (error) in
            self.categorySectionDelegate?.showErrorMessage(error)
        }
    }
    
    func getProductList() {
        productList.removeAll()
        productKeys.removeAll()
        sectionIdList.removeAll()
        ParseManager.shared.getRequest(url: NewsApi.products,
            success: { (result: TotalProduct) in
                self.productList["Самые продоваемые"] = result.popular
                self.productKeys.append("Самые продоваемые")
                self.sectionIdList.append(-2)
                for i in result.sections {
                    self.productList[i.section_name] = i.products
                    self.productKeys.append(i.section_name)
                }
                for i in result.sections {
                    self.sectionIdList.append(i.id)
                }
                self.delegate?.updateUI()
        }) { (error) in
            self.delegate?.showErrorMessage(error)
        }
    }
    
    func getBasketCount() {
        ParseManager.shared.getRequest(url: ProductApi.basketCount, success: { (result: Int) in
            self.basketCountDelegate?.updateCount(count: result)
        }) { (error) in
            self.delegate?.showErrorMessage(error)
        }
    }
}
