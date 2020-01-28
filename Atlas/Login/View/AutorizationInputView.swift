//
//  SignInInputView.swift
//  Santo
//
//  Created by Eldor Makkambayev on 9/24/19.
//  Copyright © 2019 Eldor Makkambayev. All rights reserved.
//

import UIKit

class AutorizationInputView: UIView {
    
    //MARK: - Properties
    lazy var welcomeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .mainTitleColor
        label.text = "Добро пожаловать"
        label.font = UIFont.getMullerBoldFont(on: 25)
        
        return label
    }()

    lazy var authorizationTitle: UILabel = {
        let label = UILabel()
        label.text = "Авторизация"
        label.font = UIFont.getMullerBoldFont(on: 18)
        label.textColor = .mainTitleColor
        
        return label
    }()
    lazy var phoneTextField: InputTextField = {
        let textField = InputTextField(frame: .zero, inputType: .phone, title: "", placeholder: "", icon: #imageLiteral(resourceName: "Phone rotate"), heightAnchor: 45)
        textField.textField.tag = 0
        textField.layer.cornerRadius = 22.5
        textField.phoneTextField.textColor = .mainColor
        
        return textField
    }()
    lazy var passwordTextField: InputTextField = {
        let textField = InputTextField(frame: .zero, inputType: .secureText, title: "", placeholder: "************", icon: nil, heightAnchor: 45)
        textField.textField.tag = 1
        textField.layer.cornerRadius = 22.5
        textField.textField.textColor = .mainColor
        textField.textField.attributedPlaceholder = NSAttributedString(string: "************",
                                                      attributes: [
                                                        NSAttributedString.Key.foregroundColor:  UIColor.mainColor,
                                                        NSAttributedString.Key.font: UIFont.getMullerMediumFont(on: 14)])

        
        return textField
    }()
    
    //MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    //MARK: - Setup functions
    private func setupView() -> Void {
        addSubview(welcomeLabel)
        welcomeLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalTo(25)
            make.right.equalTo(-15)
        }

        addSubview(authorizationTitle)
        authorizationTitle.snp.makeConstraints { (make) in
            make.top.equalTo(welcomeLabel.snp.bottom).offset(22)
            make.centerX.equalToSuperview()
            make.left.equalTo(25)
            make.right.equalTo(-20)
        }
        
        addSubview(phoneTextField)
        phoneTextField.snp.makeConstraints { (make) in
            make.top.equalTo(authorizationTitle.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.left.equalTo(20)
            make.right.equalTo(-20)
        }
        
        addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints { (make) in
            make.top.equalTo(phoneTextField.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.bottom.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
