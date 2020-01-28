//
//  ProductView.swift
//  Delivery
//
//  Created by Nurzhigit Smailov on 9/10/19.
//  Copyright © 2019 Nurzhigit Smailov. All rights reserved.
//

import UIKit

protocol CategoryDelegate: class{
    func openCategoryProducts(products: [Product], category_id: Int)
    func getSub(id: Int)
}

class CategoryCollectionView: UIView {
    
    // MARK: - Properties
    lazy var productLabel: UILabel = {
        let label = UILabel()
        label.text = "products"
        label.font = .getMullerBoldFont(on: 30) //UIFont(name: Font.GTWalsheimBold, size: 30)
        label.textColor = #colorLiteral(red: 0.3176470588, green: 0.3607843137, blue: 0.4352941176, alpha: 1)
        label.numberOfLines = 0
        return label
    }()
    lazy var collectionView: UICollectionView = {
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout.scrollDirection = .horizontal
        collectionViewFlowLayout.estimatedItemSize = .init(width: 215, height: 295)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        collectionView.register(FavoriteCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.backgroundColor = .white//#colorLiteral(red: 0.9411764706, green: 0.9490196078, blue: 0.9568627451, alpha: 1)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    var catsList = [Cats]()
    public var delegate: CategoryDelegate?
    var category_id = 0
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCatsList(catsList: [Cats]) {
        self.catsList = catsList
    }
    
    func setCategoryId(category_id: Int) {
        self.category_id = category_id
    }
    
    // MARK: - SetupViews
    func setupViews() {
        addSubview(productLabel)
        addSubview(collectionView)
        
        productLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-8)
        }
        
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(productLabel.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(295)
            make.bottom.equalToSuperview().offset(-8)
        }
    }
}

// MARK: - CollectionViewDelegate
extension CategoryCollectionView: UICollectionViewDelegate, UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10//catsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! FavoriteCollectionViewCell
//        cell.setCategory(category: catsList[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if catsList[indexPath.item].products == nil { 
//            delegate?.openCategoryProducts(products: catsList[indexPath.item].products ?? [], category_id: catsList[indexPath.item].id)
//        } else  {
//            delegate?.openCategoryProducts(products: catsList[indexPath.item].products!, category_id:  catsList[indexPath.item].id)
//        }
    }
}
