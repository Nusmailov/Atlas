//
//  EstimateView.swift
//  Atlas
//
//  Created by Nurzhigit Smailov on 2/11/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import UIKit

class EstimateView: UIView {
    //MARK: - Properties
    lazy var estimateLabel: UILabel = {
        let label = UILabel()
        label.font = .getMontserraBoldFont(on: 15)
        label.text = "Оцените приложение"
        label.textColor = UIColor(red: 0.318, green: 0.361, blue: 0.435, alpha: 1)
        return label
    }()
    
    lazy var appleLogoButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "apple"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()
    lazy var documentsButton: ContinueButton = {
        let button = ContinueButton()
        button.setTitle("Правовые документы", for: .normal)
        return button
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
        addSubviews(views: [estimateLabel, appleLogoButton, documentsButton])
        estimateLabel.snp.makeConstraints { (make) in
            make.top.left.equalTo(16)
            make.right.equalTo(-16)
        }
        
        appleLogoButton.snp.makeConstraints { (make) in
            make.top.equalTo(estimateLabel.snp.bottom).offset(16)
            make.left.equalTo(16)
            make.right.equalTo(-16)
            make.height.equalTo(50)
            make.width.equalTo(150)
        }
        
        documentsButton.snp.makeConstraints { (make) in
            make.top.equalTo(appleLogoButton.snp.bottom).offset(16)
            make.left.equalTo(16)
            make.bottom.right.equalTo(-16)
            make.height.equalTo(50)
        }
    }
}
