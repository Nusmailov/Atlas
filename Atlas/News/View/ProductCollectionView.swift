//
//  ProductCollectionView.swift
//  Delivery
//
//  Created by Nurzhigit Smailov on 8/20/19.
//  Copyright © 2019 Nurzhigit Smailov. All rights reserved.
//

import UIKit

protocol ProductDelegate: class {
    func didOpenDescriptionVC(product: Product)
    func openTwoDirectionVC(products: [Product], category_id: Int)
    
    func addToBusket(product_id: Int)
    func addToFavorite(product_id: Int)
}

class   ProductCollectionView: UIView {
    // MARK: - Properties
    private let cellId = "productCell"
    lazy var collectionView : UICollectionView = {
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.backgroundColor = .white
        collectionView.allowsSelection = true
        collectionView.backgroundColor = #colorLiteral(red: 0.9411764706, green: 0.9490196078, blue: 0.9568627451, alpha: 1)
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    lazy var label: UILabel = {
        let label = UILabel()
        label.font = .getMullerBoldFont(on: 20)// UIFont(name: Font.GTWalsheimBold, size: 20)
        label.textColor = #colorLiteral(red: 0.3176470588, green: 0.3607843137, blue: 0.4352941176, alpha: 1)
        return label
    }()
    lazy var totalViewButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(openTwoDirectionViewController), for: .touchUpInside)
        let attribute: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 14), .foregroundColor: #colorLiteral(red: 0.1647058824, green: 0.5960784314, blue: 1, alpha: 1),
            .underlineStyle: NSUnderlineStyle.single.rawValue]
        let registrationButtonText = NSMutableAttributedString(string: "all", attributes: attribute)
        button.setAttributedTitle(registrationButtonText, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15)
        return button
    }()
    public var delegate: ProductDelegate?
    var products = [Product]()
    var requestText = ""
    var category_id = 0
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        backgroundColor = #colorLiteral(red: 0.9411764706, green: 0.9490196078, blue: 0.9568627451, alpha: 1)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setProducts(products: [Product]) {
        self.products = products
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    func setPaginationInfo(category_id: Int) {
        self.category_id = category_id
    }
    
    func setupViews() {
        addSubview(label)
        addSubview(totalViewButton)
        addSubview(collectionView)
        collectionView.backgroundColor = #colorLiteral(red: 0.9411764706, green: 0.9490196078, blue: 0.9568627451, alpha: 1)
        label.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
        }
        totalViewButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(label)
            make.right.equalToSuperview().offset(-16)
        }
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(label.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(250)
        }
    }
    
    // MARK: - Actions
    @objc func openTwoDirectionViewController () {
        delegate?.openTwoDirectionVC(products: products, category_id: category_id)
    }
}

// MARK: - CollectionViewDelegates
extension ProductCollectionView: UICollectionViewDelegate, UICollectionViewDataSource,
                                    UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5//products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ProductCollectionViewCell
//        cell.setProduct(product: products[indexPath.item])
//        cell.setContstraint(index: indexPath.item)
//        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (frame.width)/2, height: collectionView.frame.height - 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didOpenDescriptionVC(product: products[indexPath.item])
    }
}


extension ProductCollectionView: ProductAddingDelegate {
    func addToBusket(product_id: Int) {
        delegate?.addToBusket(product_id: product_id)
    }
    
    func addToFavorite(product_id: Int) {
        delegate?.addToFavorite(product_id: product_id)
    }
}
