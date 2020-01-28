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
    
    lazy var backView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.03)
        view.layer.cornerRadius = 4
        
        return view
    }()
    
    lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.267, green: 0.267, blue: 0.267, alpha: 1)
        label.font = .getMullerMediumFont(on: 12)
        
        return label
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
        addSubview(backView)
        backView.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.height.equalTo(33)
            make.bottom.right.left.equalToSuperview()
        }
        backView.addSubview(valueLabel)
        valueLabel.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
