//
//  TotalBasketView.swift
//  Atlas
//
//  Created by Eldor Makkambayev on 1/7/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import UIKit

class TotalBasketView: UIView {

//    MARK: - Properties
    lazy var topLine: UIView = {
        let view = UIView()
        view.layer.backgroundColor = UIColor(red: 0.937, green: 0.933, blue: 0.933, alpha: 1).cgColor
        return view
    }()
    lazy var totalTitle: UILabel = {
        let label = UILabel()
        label.textColor = .mainColor
        label.font = .getMullerRegularFont(on: 13)
        label.text = "Итого:"
        return label
    }()
    
    lazy var totalCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .mainColor
        label.font = .getMullerBoldFont(on: 20)
        label.text = "0₸"
        return label
    }()
    
    lazy var getButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .mainColor
        button.tintColor = .white
        button.titleLabel?.font = .boldSystemFont(ofSize: 13)
        button.layer.cornerRadius = 5
        button.setTitle("Оформить заказ", for: .normal)
        
        return button
    }()

//    MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    MARK: - Setup function
    
    private func setupView() -> Void {
        backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        addSubview(topLine)
        topLine.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(1)
        }
        
        addSubview(totalTitle)
        totalTitle.snp.makeConstraints { (make) in
            make.top.equalTo(5)
            make.left.equalTo(16)
        }
        
        addSubview(totalCountLabel)
        totalCountLabel.snp.makeConstraints { (make) in
            make.left.equalTo(totalTitle)
            make.top.equalTo(totalTitle.snp.bottom).offset(2)
            make.bottom.equalTo(-8)
        }
        
        addSubview(getButton)
        getButton.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalTo(-16)
            make.height.equalTo(35)
            make.width.equalTo(153)
        }
    }
}
