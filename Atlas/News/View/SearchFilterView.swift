//
//  SearchFilterView.swift
//  Atlas
//
//  Created by Nurzhigit Smailov on 2/4/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import UIKit

class SearchFilterView: UIView {
    //MARK: - Properties
    lazy var textField: UITextField = {
        let text = UITextField()
        text.backgroundColor = UIColor(red: 0.973, green: 0.98, blue: 0.988, alpha: 1)
        text.layer.cornerRadius = 10
        text.placeholder = "Волновая плитка"
        text.returnKeyType = .search
        return text
    }()
    let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 30))
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - setupViews
    func setupViews() {
        addSubview(textField)
        textField.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview()
            make.height.equalTo(40)
        }
        textField.leftView = paddingView
        textField.leftViewMode = .always
    }
    
    
    
}
