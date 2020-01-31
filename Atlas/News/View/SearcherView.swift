//
//  SearcherView.swift
//  Delivery
//
//  Created by Nurzhigit Smailov on 8/21/19.
//  Copyright © 2019 Nurzhigit Smailov. All rights reserved.
//

import UIKit

class SearcherView: UIView {
    // MARK: - Properties
    lazy var searchTextField:  UITextField = {
        let text = UITextField()
        text.layer.cornerRadius = 20.0
        text.backgroundColor = #colorLiteral(red: 0.9450980392, green: 0.9490196078, blue: 0.9529411765, alpha: 1)
        text.placeholder = "Поиск"
        text.returnKeyType = .search
        text.attributedPlaceholder = NSAttributedString(string: "Поиск", attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.3176470588, green: 0.3607843137, blue: 0.4352941176, alpha: 1)])
        return text
    }()
    lazy var busketButton: BasketCountButton = {
        let button = BasketCountButton()
        return button
    }()
    let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 30))
    
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
        addSubview(busketButton)
        addSubview(searchTextField)
        
        busketButton.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalTo(-16)
            make.width.equalTo(30)
        }
        
        searchTextField.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().offset(8)
            make.right.equalTo(busketButton.snp.left).offset(-8)
            make.bottom.equalToSuperview().offset(-8)
            make.height.equalTo(40)
        }
        searchTextField.leftView = paddingView
        searchTextField.leftViewMode = .always
    }
}
