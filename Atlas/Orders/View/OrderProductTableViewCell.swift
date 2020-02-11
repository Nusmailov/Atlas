//
//  OrderProductTableViewCell.swift
//  Delivery
//
//  Created by Nurzhigit Smailov on 8/22/19.
//  Copyright © 2019 Nurzhigit Smailov. All rights reserved.
//

import UIKit
import SDWebImage

class OrderProductTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    lazy var mainView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10.0
        view.layer.masksToBounds = true
        view.backgroundColor = .whiteBlue
        return view
    }()
    lazy var productImageView: UIImageView = {
        let view = UIImageView()
        view.image = #imageLiteral(resourceName: "plitka 1")
        view.contentMode = .scaleAspectFit
        return view
    }()
    lazy var nameProductLabel: UILabel = {
        let label = UILabel()
        label.font = .getMontserraBoldFont(on:13)
        label.textColor = #colorLiteral(red: 0.3176470588, green: 0.3607843137, blue: 0.4352941176, alpha: 1)
        label.numberOfLines = 0
        label.text = "Клинкер «Амстердам» универсальный"
        return label
    }()
    lazy var priceView: ProductCharacteristicView = {
        let view = ProductCharacteristicView()
        view.titleLabel.text = "Цена:"
        view.valueTextField.isEnabled = false
        return view
    }()
    lazy var quantityView: ProductCharacteristicView = {
        let view = ProductCharacteristicView()
        view.titleLabel.text = "Шт:"
        view.valueTextField.isEnabled = false
        return view
    }()
    lazy var sizeView: ProductCharacteristicView = {
        let view = ProductCharacteristicView()
        view.titleLabel.text = "м2:"
        view.valueTextField.isEnabled = false
        return view
    }()
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .getMontserraRegularFont(on: 11)
        label.textColor = UIColor(red: 0.173, green: 0.184, blue: 0.2, alpha: 0.8)
        label.text = "Повседневная практика показывает, что постоянный количественный . . . Повседневная практика показывает, что постоянный количественный . . . Повседневная практика показывает, что постоянный количественный . . ."
        label.numberOfLines = 0
        return label
    }()
    lazy var allSizeLabel: UILabel = {
        let label = UILabel()
        label.font = .getMontserraRegularFont(on: 10)
        label.textColor = UIColor(red: 0.667, green: 0.667, blue: 0.667, alpha: 1)
        label.text = "29.8х29.8 см 1.33 м2"
        return label
    }()
    
    var basketProduct: BasketProduct! {
        didSet {
            quantityView.valueTextField.text = "\(basketProduct.product_quantity)"
            sizeView.valueTextField.text = "\(basketProduct.area)"
            priceView.valueTextField.text = "\(basketProduct.cost)₸ м2"
            nameProductLabel.text = basketProduct.product.product_name
            descriptionLabel.text = basketProduct.product.product_description
            allSizeLabel.text = "\(basketProduct.product.product_width)x\(basketProduct.product.product_length) см "
            if !basketProduct.product.images.isEmpty {
                productImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
                productImageView.sd_setImage(with: Product.getImageUrl(url: basketProduct.product.images[0].image_path))
            }
        }
    }
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setBasketOrder(basketProduct: BasketProduct) {
        self.basketProduct = basketProduct
    }
    
    // MARK: - Setupviews
    func setupViews() {
        addSubview(mainView)
        mainView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-4)
            make.top.equalToSuperview()
        }
        
        mainView.addSubviews(views: [productImageView, nameProductLabel, priceView,
                                     quantityView, sizeView, allSizeLabel, descriptionLabel])
        
        productImageView.snp.makeConstraints { (make) in
            make.top.leading.equalToSuperview().offset(16)
            make.width.height.equalTo(80)
        }
        
        nameProductLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(16)
            make.left.equalTo(productImageView.snp.right).offset(8)
            make.right.equalToSuperview().offset(-16)
        }
        
        allSizeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(nameProductLabel.snp.bottom).offset(4)
            make.left.equalTo(productImageView.snp.right).offset(8)
            make.right.equalTo(-8)
        }
        
        descriptionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(allSizeLabel.snp.bottom).offset(12)
            make.left.equalTo(productImageView.snp.right).offset(8)
            make.right.equalTo(-8)
        }
        
        priceView.snp.makeConstraints { (make) in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(8)
            make.left.equalTo(8)
            make.bottom.equalTo(-12)
            make.width.equalTo(100)
        }
        
        quantityView.snp.makeConstraints { (make) in
            make.left.equalTo(priceView.snp.right).offset(10)
            make.width.greaterThanOrEqualTo(75)
            make.centerY.equalTo(priceView)
            make.width.equalTo(100)
        }
        
        sizeView.snp.makeConstraints { (make) in
            make.left.equalTo(quantityView.snp.right).offset(10)
            make.width.greaterThanOrEqualTo(75)
            make.centerY.equalTo(priceView)
            make.width.equalTo(100)
        }
    }
    
}
