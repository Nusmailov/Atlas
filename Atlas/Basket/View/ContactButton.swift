//
//  ContactButton.swift
//  Atlas
//
//  Created by Nurzhigit Smailov on 2/7/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import UIKit

class ContactButton: UIButton {
    lazy var image: UIImageView = {
        let image = UIImageView()
        
        return image
    }()
    lazy var titleTextLabel: UILabel = {
        let label = UILabel()
        label.text = "Наш колл-центр"
        label.textColor = UIColor(red: 0.318, green: 0.361, blue: 0.435, alpha: 1)
        label.font = .getMontserraBoldFont(on: 13)
        return label
    }()
    lazy var infoTextLabel: UILabel = {
        let label = UILabel()
        label.text = "+7 (775) 198-41-42, +7 (771) 373-06-32"
        label.textColor = UIColor(red: 0.729, green: 0.729, blue: 0.729, alpha: 1)
        label.font = .getMontserraBoldFont(on: 13)
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        addSubviews(views: [image, titleTextLabel, infoTextLabel])
        image.snp.makeConstraints { (make) in
            make.left.top.bottom.equalToSuperview()
            make.height.width.equalTo(44)
        }
        titleTextLabel.snp.makeConstraints { (make) in
            make.top.equalTo(image.snp.top)
            make.left.equalTo(image.snp.right).offset(16)
        }
        infoTextLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleTextLabel.snp.bottom).offset(1)
            make.left.equalTo(image.snp.right).offset(16)
            make.right.equalTo(-16)
        }
    }
}
