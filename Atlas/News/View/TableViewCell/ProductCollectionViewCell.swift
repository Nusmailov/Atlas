//
//  ProductCollectionViewCell.swift
//  Delivery
//
//  Created by Nurzhigit Smailov on 8/20/19.
//  Copyright © 2019 Nurzhigit Smailov. All rights reserved.
//

import UIKit
import SDWebImage


protocol ProductAddingDelegate: class {
    func addToBusket(product_id: Int)
    func addToFavorite(product_id: Int)
}

class ProductCollectionViewCell: UICollectionViewCell {
    // MARK: - Properties
    let mainView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        return view
    }()
    public var delegate: ProductAddingDelegate?
    lazy var productImageView:UIImageView = {
        let view = UIImageView()
        view.image = #imageLiteral(resourceName: "gift")
        view.contentMode = .scaleAspectFit
        view.isUserInteractionEnabled = true
        return view
    }()
    lazy var nameProductLabel: UILabel = {
        let label = UILabel()
        label.font = .getMullerBoldFont(on: 16)
        label.textColor = #colorLiteral(red: 0.3176470588, green: 0.3607843137, blue: 0.4352941176, alpha: 1)
        label.lineBreakMode = .byCharWrapping
        return label
    }()
    lazy var descriptionProductLabel: UILabel = {
        let label = UILabel()
        label.font = .getMullerRegularFont(on: 15)
        label.textColor = #colorLiteral(red: 0.3176470588, green: 0.3607843137, blue: 0.4352941176, alpha: 1)
        label.numberOfLines = 2
        return label
    }()
    lazy var priceView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 5.0
        view.layer.borderColor = #colorLiteral(red: 0.3176470588, green: 0.3607843137, blue: 0.4352941176, alpha: 1)
        view.layer.borderWidth = 2.0
        return view
    }()
    lazy var priceProductLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)// UIFont(name: Font.NeusaBold, size: 16)
        label.textColor = #colorLiteral(red: 0.3176470588, green: 0.3607843137, blue: 0.4352941176, alpha: 1)
        return label
    }()
    lazy var busketButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "box"), for: .normal)
        button.addTarget(self, action: #selector(addToBusket), for: .touchUpInside)
        return button
    }()
    
    lazy var favoriteButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "Half-heart"), for: .normal)
        button.addTarget(self, action: #selector(addToFavorite), for: .touchUpInside)
        button.imageView?.contentMode  = .scaleAspectFit
        return button
    }()
    var product: Product! {
        didSet {
            nameProductLabel.text = product.name
            priceProductLabel.text = "\(String(describing: product.price)) \("tenge")"
            descriptionProductLabel.text = product.description
            if product.in_favorite {
                favoriteButton.setImage(#imageLiteral(resourceName: "Path 8890.1"), for: .normal)
            } else {
                favoriteButton.setImage(#imageLiteral(resourceName: "Half-heart"), for: .normal)
            }
            if product.in_basket {
                busketButton.setImage(#imageLiteral(resourceName: "Cart#2-2"), for: .normal)
            } else {
                busketButton.setImage(#imageLiteral(resourceName: "box"), for: .normal)
            }
            if product?.images?.count != 0  &&  product.images?[0] != "" {
                productImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
                productImageView.sd_setImage(with: Product.getImageUrl(url: (product.images?[0])!))
            } else {
//                productImageView.image = UIImage(named: MediaType.gift)
            }
        }
    }
    var isInBusket = false
    var isInFavorite = false
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func setProduct(product: Product) {
        self.product = product
    }
    
    func setContstraint(index: Int) {
        if index % 2 == 1 {
            mainView.snp.remakeConstraints { (make) in
                make.top.bottom.equalToSuperview()
                make.left.equalTo(2)
                make.right.equalTo(-2)
            }
        }
        else {
            mainView.snp.remakeConstraints { (make) in
                make.top.bottom.equalToSuperview()
                make.left.equalTo(2)
                make.right.equalTo(-2)
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - SetupViews
    func setupViews() {
        addSubview(mainView)
        mainView.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(2)
            make.right.equalTo(-2)
        }
        mainView.addSubviews(views: [productImageView, nameProductLabel, descriptionProductLabel, priceView,
                                    busketButton, favoriteButton])
        
        productImageView.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().offset(8)
            make.right.equalToSuperview().offset(-8)
            make.height.equalTo(120)
        }
        
        favoriteButton.snp.makeConstraints { (make) in
            make.top.equalTo(productImageView.snp.bottom).offset(4)
            make.height.width.equalTo(30)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        nameProductLabel.snp.makeConstraints { (make) in
            make.top.equalTo(productImageView.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(8)
            make.right.equalTo(favoriteButton.snp.left).offset(-8)
        }
        
        descriptionProductLabel.snp.makeConstraints { (make) in
            make.top.equalTo(nameProductLabel.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(8)
            make.right.equalToSuperview().offset(-8)
        }
        
        busketButton.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-8)
            make.bottom.equalToSuperview().offset(-16)
            make.width.height.equalTo(30)
        }
        
        priceView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(8)
            make.right.equalTo(busketButton.snp.left).offset(-8)
            make.bottom.equalToSuperview().offset(-16)
            make.height.equalTo(30)
        }
        
        priceView.addSubview(priceProductLabel)
        priceProductLabel.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
    }
    
    @objc func addToFavorite() {
        if !product.in_favorite {
            favoriteButton.setImage(#imageLiteral(resourceName: "Path 8890.1"), for: .normal)
            delegate?.addToFavorite(product_id: product.id)
        }
    }
    
    @objc func addToBusket() {
        if !product.in_basket {
            busketButton.setImage(#imageLiteral(resourceName: "Path 8890.1"), for: .normal)
            delegate?.addToBusket(product_id: product.id)
        }
    }
}
