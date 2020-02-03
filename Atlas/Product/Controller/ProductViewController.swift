//
//  ProductViewController.swift
//  Atlas
//
//  Created by Nurzhigit Smailov on 1/27/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import UIKit

class ProductViewController: ScrollViewController {
    //MARK: - Properties
    lazy var imageCollectionView: BannerCollectionView = {
        let view = BannerCollectionView()
        return view
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    //MARK: - SetupViews
    func setupViews() {
        contentView.addSubviews(views: [imageCollectionView])
        imageCollectionView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
        }
    }
}
