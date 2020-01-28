//
//  OrderQuantityView.swift
//  Atlas
//
//  Created by Nurzhigit Smailov on 1/24/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import UIKit

class OrderQuantityView: UIView {
    
    //MARK: - Properties
    lazy var mainView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 4
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        view.alpha = 0.03
        return view
    }()
    lazy var textLabel: UILabel = {
        let label = UILabel()
//        label.font = .getMontserraSemiBoldFont(on: 12)
        label.font = .getMontserraBoldFont(on: 12)
        label.textColor = .black
        label.text = "20 000 ₸ м2"
        label.textAlignment = .center
        label.alpha = 1
        return label
    }()
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .getMontserraRegularFont(on: 10)
        label.text = "Цена:"
        label.textColor = UIColor(red: 0.667, green: 0.667, blue: 0.667, alpha: 1)
        return label
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
        addSubview(titleLabel)
        addSubview(mainView)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalTo(4)
        }
        
        mainView.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.bottom.left.right.equalToSuperview()
        }
        
        mainView.addSubview(textLabel)
        
        textLabel.snp.makeConstraints { (make) in
            make.left.top.equalTo(8)
            make.right.bottom.equalTo(-8)
        }
    }
}
