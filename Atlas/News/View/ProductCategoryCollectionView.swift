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
        label.font = .getMullerBoldFont(on: 20)// UIFont(name: Font.GTWalsheimBold, size: 20)
        label.textColor = #colorLiteral(red: 0.3176470588, green: 0.3607843137, blue: 0.4352941176, alpha: 1)
        label.numberOfLines = 0
        return label
    }()
    lazy var collectionView: UICollectionView = {
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout.scrollDirection = .horizontal
        collectionViewFlowLayout.estimatedItemSize = CGSize(width: 120, height: 50)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: String.init(describing: CategoryCell.self))
        collectionView.backgroundColor = .white//#colorLiteral(red: 0.9411764706, green: 0.9490196078, blue: 0.9568627451, alpha: 1)
        collectionView.alwaysBounceHorizontal = true
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    var catsList = [Cats]()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func setCatsList(catsList: [Cats]) {
        self.catsList = catsList
        collectionView.reloadData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - SetupViews
    func setupViews() {
        addSubview(collectionView)
        addSubview(headerLabel)
        
        headerLabel.snp.makeConstraints { (make) in
            make.top.right.equalToSuperview()
            make.left.equalToSuperview().offset(16)
        }
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(headerLabel.snp.bottom)
            make.left.equalToSuperview().offset(8)
            make.right.equalToSuperview().offset(-8)
            make.height.equalTo(60)
            make.bottom.equalToSuperview()
        }
    }
}
