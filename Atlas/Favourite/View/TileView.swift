//
//  TileView.swift
//  Atlas
//
//  Created by Tuigynbekov Yelzhan on 10/24/19.
//  Copyright © 2019 Yelzhan Tuigynbekov. All rights reserved.
//

import UIKit
import SDWebImage

class TileView: UIView {

    //MARK: - Properties
    lazy var image: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "no-image")
        image.contentMode = .scaleAspectFit
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 10
        return image
    }()
    lazy var favouriteButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "Path 8890.1"), for: .normal)
        button.backgroundColor = .white
        button.imageEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        button.layer.cornerRadius = 14
        button.addTarget(self, action: #selector(addToFavorite), for: .touchUpInside)
        return button
    }()
    lazy var tilesizeLabel: UILabel = {
        let label = UILabel()
        label.text = "29.8х29.8 см 1.33 м2"
        label.textColor = #colorLiteral(red: 0.6666666667, green: 0.6666666667, blue: 0.6666666667, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 10)
        return label
    }()
    lazy var tilenameLabel: UILabel = {
        let label = UILabel()
        label.text = "Клинкер «Амстердам»"
        label.textColor = #colorLiteral(red: 0.2666666667, green: 0.2666666667, blue: 0.2666666667, alpha: 1)
        label.font = .getMullerBoldFont(on: 13)
        label.numberOfLines = 2
        return label
    }()
    lazy var prLabel: UILabel = {
        let label = UILabel()
        label.text = "Цена:"
        label.textColor = #colorLiteral(red: 0.6666666667, green: 0.6666666667, blue: 0.6666666667, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 10)
        return label
    }()
    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.text = "20 000 тенге м2"
        label.textColor = #colorLiteral(red: 0.2666666667, green: 0.2666666667, blue: 0.2666666667, alpha: 1)
        label.numberOfLines = 2
        label.font = .getMullerBoldFont(on: 13)
        return label
    }()
    lazy var buyButton: UIButton = {
        let button = UIButton()
        button.setTitle("В корзину", for: .normal)
        button.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        button.titleLabel?.font = .getMullerBoldFont(on: 12)
        button.backgroundColor = #colorLiteral(red: 0.7843137255, green: 0.2039215686, blue: 0.2784313725, alpha: 1)
        button.layer.cornerRadius = 6
        button.addTarget(self, action: #selector(toBuy), for: .touchUpInside)
        return button
    }()
    lazy var basketButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "box"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(addToBasket), for: .touchUpInside)
        return button
    }()
    
    var product: Product! {
        didSet {
            priceLabel.text = "\(product.product_price) ₸ м2"
            tilenameLabel.text = product.product_name
            tilesizeLabel.text = "\(product.product_length)x\(product.product_width) см"
    
            let favorite = FavoriteModel.shared.favoriteList[product.id]
            let heart = favorite == true ? UIImage(named: "Path 8890.1") : UIImage(named: "emptyHeart")
            favouriteButton.setImage(heart, for: .normal)
            
            let basket_state = BasketModel.shared.basketList[product.id]
            let basket = basket_state == true ? UIImage(named: "Cart#2-2") : UIImage(named: "box")
            basketButton.setImage(basket, for: .normal)
            if basket_state == true {
                buyButton.isEnabled = false
                buyButton.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
            } else {
                buyButton.isEnabled = true
                buyButton.backgroundColor = .mainColor
            }
            if !product.images.isEmpty {
                image.sd_imageIndicator = SDWebImageActivityIndicator.gray
                image.contentMode = .scaleAspectFill
                image.sd_setImage(with: Product.getImageUrl(url: product.images[0].image_path))
            } else {
                image.image = #imageLiteral(resourceName: "no-image")
                image.contentMode = .scaleAspectFit
            }
        }
    }
    weak var delegate: ProductDelegate?
    
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupBackground()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setProduct(product: Product) {
        self.product = product
    }
    
    //MARK: - SetupViews
    func setupViews() -> Void {
        addSubviews(views: [image, favouriteButton, tilesizeLabel, tilenameLabel, prLabel, buyButton, priceLabel, basketButton])
        
        image.snp.makeConstraints { (make) in
            make.height.equalTo(125)
            make.left.right.top.equalToSuperview()
        }
        
        favouriteButton.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
            make.height.width.equalTo(28)
        }
        
        tilesizeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(image.snp.bottom).offset(4)
            make.left.equalTo(10)
        }
        
        tilenameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(tilesizeLabel.snp.bottom).offset(2)
            make.left.equalTo(10)
            make.right.equalTo(-10)
        }
        
        prLabel.snp.makeConstraints { (make) in
            make.top.equalTo(tilenameLabel.snp.bottom).offset(5)
            make.left.equalTo(10)
        }
        
        priceLabel.snp.makeConstraints { (make) in
            make.top.equalTo(prLabel.snp.bottom).offset(2)
            make.left.equalTo(10)
        }
        
        buyButton.snp.makeConstraints { (make) in
            make.top.equalTo(priceLabel.snp.bottom).offset(5)
            make.left.equalTo(10)
            make.right.equalTo(basketButton.snp.left).offset(-8)
            make.bottom.equalTo(-12)
            make.height.equalTo(33)
        }
        
        basketButton.snp.makeConstraints { (make) in
            make.right.equalTo(-8)
            make.centerY.equalTo(buyButton)
            make.height.width.equalTo(27)
        }
    }
    
    func setupBackground() -> Void {
        backgroundColor = #colorLiteral(red: 0.9725490196, green: 0.9803921569, blue: 0.9882352941, alpha: 1)
        layer.cornerRadius = 11
    }
    
    @objc func addToBasket() {
        
    }
    
    @objc func addToFavorite() {
        if FavoriteModel.shared.favoriteList[product.id] == true {
            delegate?.removeFavorite(product_id: product.id)
        }
        else {
            delegate?.addToFavorite(product_id: product.id)
        }
    }

    @objc func toBuy() {
        if BasketModel.shared.basketList[product.id] == true {
            delegate?.removeBasket(product_id: product.id)
        }
        else {
            delegate?.addToBasket(product_id: product.id)
        }
    }
}
