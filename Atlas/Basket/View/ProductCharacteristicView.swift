//
//  ProductCharacteristicView.swift
//  Atlas
//
//  Created by Eldor Makkambayev on 1/8/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import UIKit

class ProductCharacteristicView: UIView {
    
//    MARK: - Properties
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.667, green: 0.667, blue: 0.667, alpha: 1)
        label.font = .getMullerRegularFont(on: 10)
        
        return label
    }()
    
    lazy var valueTextField: UITextField = {
        let text = UITextField()
        text.textColor = #colorLiteral(red: 0.267, green: 0.267, blue: 0.267, alpha: 1)
        text.font = .getMullerMediumFont(on: 12)
        text.backgroundColor = #colorLiteral(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.03)
        text.layer.cornerRadius = 4
        text.textAlignment = .center
        text.keyboardType = .decimalPad
        return text
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() -> Void {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalTo(4)
        }
        addSubview(valueTextField)
        valueTextField.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.height.equalTo(33)
            make.bottom.right.left.equalToSuperview()
        }
    }
}
