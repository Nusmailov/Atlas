//
//  InfoTitleView.swift
//  Atlas
//
//  Created by Nurzhigit Smailov on 1/24/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import UIKit

class InfoTitleView: UIView {
    //MARK: - Properties
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.318, green: 0.361, blue: 0.435, alpha: 1)
        label.font = .getMontserraBoldFont(on: 15)
        label.text = "Номер договора"
        return label
    }()
    lazy var textLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.275, green: 0.282, blue: 0.333, alpha: 1)
        label.font = .getMontserraRegularFont(on: 13)
        return label
    }()
    lazy var mainView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.973, green: 0.98, blue: 0.988, alpha: 1)
        view.layer.cornerRadius = 9
        return view
    }()
    
    //MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - SetupViews
    func setupViews() {
        addSubviews(views: [titleLabel, mainView])
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalTo(16)
            make.right.equalTo(-16)
        }
        
        mainView.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.left.equalTo(16)
            make.right.equalTo(-16)
            make.bottom.equalToSuperview()
            make.height.equalTo(40)
        }
        
        mainView.addSubview(textLabel)
        
        textLabel.snp.makeConstraints { (make) in
            make.left.equalTo(16)
            make.top.equalTo(8)
            make.bottom.equalTo(-8)
        }
    }
    
}
