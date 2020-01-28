//
//  FirstAndLastNameInputView.swift
//  Santo
//
//  Created by Eldor Makkambayev on 9/26/19.
//  Copyright © 2019 Eldor Makkambayev. All rights reserved.
//

import Foundation
import UIKit

class RegistrationInputView: UIView {
    
    //MARK: - Properties
    var isPhysLico = true {
        didSet{
            self.isPhysLico ? closeEntityView() : openEntityView()
        }
    }
    lazy var emailInputView: TitleInputView = {
        let email = TitleInputView(frame: .zero, inputType: .plainText, title: "*Введите ваш E-mail", placeholder: "Пример: example@mail.ru", icon: nil, heightAnchor: 40)
        email.inputTextView.iconView.tintColor = .inputViewColor
        email.layer.cornerRadius = 10
        email.inputTextView.textField.keyboardType = .emailAddress
        
        return email
    }()
    lazy var entityInputView = ForEntityInputView()
    lazy var firstNameInputView: TitleInputView = {
        let firstName = TitleInputView(frame: .zero, inputType: .plainText, title: "*Введите ваше имя", placeholder: "Пример: Асель", icon: nil, heightAnchor: 40)
        firstName.inputTextView.iconView.tintColor = .inputViewColor
        firstName.layer.cornerRadius = 10

        return firstName
    }()
    lazy var secondNameInputView: TitleInputView = {
        let secondName = TitleInputView(frame: .zero, inputType: .plainText, title: "Введите вашу фамилию", placeholder: "Пример: Муратова", icon: nil, heightAnchor: 40)
        secondName.inputTextView.iconView.tintColor = .inputViewColor
        secondName.layer.cornerRadius = 10
        
        return secondName
    }()
    lazy var phoneInputView: TitleInputView = {
        let textField = TitleInputView(frame: .zero, inputType: .phone, title: "*Введите ваш номер", placeholder: "", icon: nil, heightAnchor: 40)
        textField.layer.cornerRadius = 10
        textField.inputTextView.phoneTextField.keyboardType = .decimalPad
        
        return textField
    }()
    lazy var passwordInputView: TitleInputView = {
        let password = TitleInputView(frame: .zero, inputType: .secureText, title: "*Придумайте пароль", placeholder: "••••••••", icon: #imageLiteral(resourceName: "Path 15"), heightAnchor: 40)
        password.inputTextView.iconView.tintColor = .inputViewColor
        password.layer.cornerRadius = 10
        
        return password
    }()
    lazy var repeatPasswordInputView: TitleInputView = {
        let password = TitleInputView(frame: .zero, inputType: .secureText, title: "*Повторите пароль", placeholder: "••••••••", icon: #imageLiteral(resourceName: "Path 15"), heightAnchor: 40)
        password.inputTextView.iconView.tintColor = .inputViewColor
        password.layer.cornerRadius = 10
        
        return password
    }()

    //MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
        self.isPhysLico ? closeEntityView() : openEntityView()

    }
    
    //MARK: - Setup functions
    private func setupView() -> Void {
        addSubview(emailInputView)
        emailInputView.snp.makeConstraints { (make) in
            make.centerX.top.equalToSuperview()
            make.left.equalTo(20)
            make.right.equalTo(-20)
        }
        addSubview(entityInputView)
        entityInputView.snp.makeConstraints { (make) in
            make.top.equalTo(emailInputView.snp.bottom).offset(15)
            make.right.left.equalToSuperview()
        }
        addSubview(firstNameInputView)
        firstNameInputView.snp.makeConstraints { (make) in
            make.top.equalTo(entityInputView.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
            make.left.equalTo(20)
            make.right.equalTo(-20)
        }
        addSubview(secondNameInputView)
        secondNameInputView.snp.makeConstraints { (make) in
            make.top.equalTo(firstNameInputView.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
            make.width.equalTo(firstNameInputView)
        }
        addSubview(phoneInputView)
        phoneInputView.snp.makeConstraints { (make) in
            make.top.equalTo(secondNameInputView.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
            make.width.equalTo(firstNameInputView)
        }
        addSubview(passwordInputView)
        passwordInputView.snp.makeConstraints { (make) in
            make.top.equalTo(phoneInputView.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
            make.width.equalTo(firstNameInputView)
        }
        addSubview(repeatPasswordInputView)
        repeatPasswordInputView.snp.makeConstraints { (make) in
            make.top.equalTo(passwordInputView.snp.bottom).offset(15)
            make.width.equalTo(firstNameInputView)
            make.bottom.centerX.equalToSuperview()
        }
    }
    
    //    MARK: - Simple functions
    private func initialConstrains() -> Void {
        entityInputView.alpha = 0
        entityInputView.snp.remakeConstraints { (make) in
            make.top.equalTo(emailInputView.snp.bottom).offset(0)
            make.height.equalTo(0)
            make.right.left.equalToSuperview()
        }
    }
    
    private func lastConstrains() -> Void {
        entityInputView.alpha = 1
        entityInputView.snp.remakeConstraints({ (make) in
            make.top.equalTo(emailInputView.snp.bottom).offset(15)
            make.right.left.equalToSuperview()
//            make.height.equalTo(135)//144
        })
    }

    private func closeEntityView() -> Void {
        
        UIView.animate(withDuration: 0.5) {
            self.initialConstrains()
            self.superview?.layoutIfNeeded()
        }
    }
    
    private func openEntityView() -> Void {
        
        UIView.animate(withDuration: 0.5) {
            self.lastConstrains()
            self.superview?.layoutIfNeeded()
        }
    }


    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
