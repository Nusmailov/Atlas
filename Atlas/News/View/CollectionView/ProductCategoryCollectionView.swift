//
//  ProductCategoryCollectionView.swift
//  Delivery
//
//  Created by Nurzhigit Smailov on 9/12/19.
//  Copyright © 2019 Nurzhigit Smailov. All rights reserved.
//

import UIKit

class ProductCategoryCollectionView: UIView {
    
    // MARK: - Properties
    lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.font = .getMullerRegularFont(on: 12)
        label.textColor = UIColor(red: 0.771, green: 0.771, blue: 0.771, alpha: 1)
        label.numberOfLines = 0
        label.text = "Выберите категорию:"
        return label
    }()
    lazy var collectionView: UICollectionView = {
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout.scrollDirection = .horizontal
        collectionViewFlowLayout.estimatedItemSize = CGSize(width: 120, height: 50)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: String.init(describing: CategoryCell.self))
        collectionView.backgroundColor = .white
        collectionView.alwaysBounceHorizontal = true
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    var sectionList = [Section]()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func setSectionList(sectionList: [Section]) {
        self.sectionList = sectionList
        collectionView.reloadData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - SetupViews
    func setupViews() {
        addSubview(headerLabel)
        addSubview(collectionView)
        
        headerLabel.snp.makeConstraints { (make) in
            make.top.right.equalToSuperview()
            make.left.equalToSuperview().offset(16)
        }
        
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(headerLabel.snp.bottom).offset(4)
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
            make.height.equalTo(30)
            make.bottom.equalToSuperview()
        }
    }
}
