//
//  TitleInputView.swift
//  Santo
//
//  Created by Eldor Makkambayev on 9/26/19.
//  Copyright © 2019 Eldor Makkambayev. All rights reserved.
//

import Foundation
import UIKit

class TitleInputView: UIView {
    
    //MARK: - Properties
    var inputType: InputTypes
    var height: Int
    var icon: UIImage?
    var placeholder: String
    
    lazy var titleLabel: UILabel = {
        let title = UILabel()
        title.textColor = .mainColor
        title.font = .getMullerBoldFont(on: 15)
        
        return title
    }()
    lazy var inputTextView: InputTextField = {
        let inputView = InputTextField(frame: .zero, inputType: inputType, title: "Name", placeholder: placeholder, icon: icon, heightAnchor: height)
        inputView.iconView.tintColor = .inputViewColor
        inputView.layer.cornerRadius = 10
        
        return inputView
    }()
    
    //MARK: - Initialization
    init(frame: CGRect, inputType: InputTypes, title: String, placeholder: String, icon: UIImage?, heightAnchor: Int) {
        self.inputType = inputType
        self.height = heightAnchor
        self.placeholder = placeholder
        self.icon = icon
        super.init(frame: .zero)
        titleLabel.text = title
        setupView()
    }
    
    //MARK: - Setup functions
    private func setupView() -> Void {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(5)
            make.top.equalToSuperview()
        }
        addSubview(inputTextView)
        inputTextView.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.left.right.bottom.centerX.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
