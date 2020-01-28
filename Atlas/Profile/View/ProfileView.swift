//
//  ProfileView.swift
//  Delivery
//
//  Created by Nurzhigit Smailov on 8/26/19.
//  Copyright © 2019 Nurzhigit Smailov. All rights reserved.
//

import UIKit

class ProfileView: UIView {
    
    // MARK: - Propertiess
    lazy var userImageView: UIImageView = {
        let view = UIImageView()
        view.image = #imageLiteral(resourceName: "Ellipse 2.5")
        view.contentMode = .scaleAspectFit
        view.layer.cornerRadius = 40
        view.layer.masksToBounds = true
        
        return view
    }()
    lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.font = .getMullerBoldFont(on: 18)
        label.textColor = #colorLiteral(red: 0.3176470588, green: 0.3607843137, blue: 0.4352941176, alpha: 1)
        label.numberOfLines = 0
        label.text = "Баратов Азиз"
        return label
    }()
    lazy var userPhoneLabel: UILabel = {
        let label = UILabel()
        label.font = .getMullerRegularFont(on: 14)
        label.numberOfLines = 0
        label.textColor = #colorLiteral(red: 0.3176470588, green: 0.3607843137, blue: 0.4352941176, alpha: 1)
        label.text = "+7 (777) 777 77-77"
        return label
    }()
    lazy var contractView: InfoTitleView = {
        let view = InfoTitleView()
        return view
    }()
    lazy var typeContractView: InfoTitleView = {
        let view = InfoTitleView()
        view.titleLabel.text = "Тип договора"
        view.textLabel.text = "Диллерский"
        return view
    }()
    lazy var propsView: InfoTitleView = {
        let view = InfoTitleView()
        view.titleLabel.text = "Реквизиты"
        view.textLabel.text = "6546847987154654"
        return view
    }()
    
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - SetupViews
    func setupViews() {
        addSubview(userImageView)
        addSubview(userNameLabel)
        addSubview(userPhoneLabel)
        addSubviews(views: [contractView, typeContractView, propsView])
        
        userImageView.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().offset(16)
            make.width.height.equalTo(80)
        }
        
        userNameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(userImageView.snp.top).offset(8)
            make.left.equalTo(userImageView.snp.right).offset(8)
            make.right.equalToSuperview().offset(-16)
        }
        
        userPhoneLabel.snp.makeConstraints { (make) in
            make.top.equalTo(userNameLabel.snp.bottom).offset(8)
            make.left.equalTo(userImageView.snp.right).offset(8)
            make.right.equalToSuperview().offset(-16)
        }
        
        contractView.snp.makeConstraints { (make) in
            make.top.equalTo(userImageView.snp.bottom).offset(16)
            make.left.right.equalToSuperview()
        }
        
        typeContractView.snp.makeConstraints { (make) in
            make.top.equalTo(contractView.snp.bottom).offset(16)
            make.left.right.equalToSuperview()
        }
        
        propsView.snp.makeConstraints { (make) in
            make.top.equalTo(typeContractView.snp.bottom).offset(16)
            make.left.bottom.right.equalToSuperview()
        }
    }
}
