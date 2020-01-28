//
//  TileView.swift
//  Atlas
//
//  Created by Tuigynbekov Yelzhan on 10/24/19.
//  Copyright © 2019 Yelzhan Tuigynbekov. All rights reserved.
//

import UIKit
class TileView: UIView {

    //MARK:- Preasure
    lazy var image: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "plitka 1")
        
        return image
    }()
    
    lazy var favouriteButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "Path 8890.1"), for: .normal)
        
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
        button.setTitle("Купить", for: .normal)
        button.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        button.titleLabel?.font = .getMullerBoldFont(on: 12)
        button.backgroundColor = #colorLiteral(red: 0.7843137255, green: 0.2039215686, blue: 0.2784313725, alpha: 1)
        button.layer.cornerRadius = 6
        
        return button
    }()
    
    lazy var backetButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "box"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()
    
    //MARK:- Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupBackground()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- SetupViews
    func setupViews() -> Void {
        
        addSubviews(views: [image, favouriteButton, tilesizeLabel, tilenameLabel, prLabel, buyButton, priceLabel, backetButton])
        
        image.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(15)
        }
        favouriteButton.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12.8)
        }
        tilesizeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(image.snp.bottom).offset(22)
            make.left.equalTo(10)
        }
        tilenameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(tilesizeLabel.snp.bottom).offset(2)
            make.left.equalTo(10)
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
            make.right.equalTo(backetButton.snp.left).offset(-8)
            make.bottom.equalTo(-12)
            make.height.equalTo(33)
        }
        
        backetButton.snp.makeConstraints { (make) in
            make.right.equalTo(-8)
            make.centerY.equalTo(buyButton)
            make.height.width.equalTo(27)
        }
    }
    
    func setupBackground() -> Void {
        backgroundColor = #colorLiteral(red: 0.9725490196, green: 0.9803921569, blue: 0.9882352941, alpha: 1)
        layer.cornerRadius = 11
    }

}
