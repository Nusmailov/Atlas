//
//  BasketCountButton.swift
//  Atlas
//
//  Created by Nurzhigit Smailov on 1/27/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import UIKit

class BasketCountButton: UIButton {
    //MARK: - Properties
    lazy var countLabel: UILabel = {
        let label = UILabel()
        label.font = .getMullerBoldFont(on: 10)
        label.textColor = .white
        label.text = "1"
        label.backgroundColor = .red
        label.layer.cornerRadius = 7.5
        return label
    }()
    lazy var image: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.image = #imageLiteral(resourceName: "Cart#2-2")
        return image
    }()
    lazy var redView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.layer.cornerRadius = 8
        return view
    }()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - SetupViews
    func setupViews() {
        addSubview(image)
        tintColor = .mainColor
        image.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.width.equalTo(32)
        }
        image.addSubview(redView)
        redView.snp.makeConstraints { (make) in
            make.top.equalTo(image.snp.centerY).offset(2)
            make.left.equalTo(image.snp.centerX).offset(2)
            make.height.width.equalTo(16)
        }
        redView.addSubview(countLabel)
        countLabel.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
    }
    
}
