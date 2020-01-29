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
    
}
