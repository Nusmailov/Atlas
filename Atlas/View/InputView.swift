//
//  InputView.swift
//  Santo
//
//  Created by Eldor Makkambayev on 9/24/19.
//  Copyright © 2019 Eldor Makkambayev. All rights reserved.
//

import Foundation
import Foundation
import UIKit

enum InputTypes {
    case phone
    case plainText
    case secureText
    
    var isSecure: Bool {
        return .secureText == self
    }
}

class InputTextField: UIView {
    
    //MARK: - Properties
    private let inputType: InputTypes
    private let placeholder: String
    private let title: String
    private let icon: UIImage?
    var height: Int = 40
    
    lazy var titleLabel: UILabel = {
        let tl = UILabel()
        tl.textColor = #colorLiteral(red: 0.5921568627, green: 0.5960784314, blue: 0.6039215686, alpha: 1)
        tl.font = .getMullerMediumFont(on: 14)
        tl.text = ""
        
        return tl
    }()
    lazy var textField: DismissableTextField = {
        let tf = DismissableTextField()
        tf.isSecureTextEntry = inputType.isSecure
        tf.attributedPlaceholder = NSAttributedString(string: placeholder,
                                                      attributes: [
                                                        NSAttributedString.Key.foregroundColor:  #colorLiteral(red: 0.5921568627, green: 0.5960784314, blue: 0.6039215686, alpha: 1),
                                                        NSAttributedString.Key.font: UIFont.getMullerMediumFont(on: 14)
            ])
        tf.font = .getMullerMediumFont(on: 14)
        tf.textColor = #colorLiteral(red: 0.2298094199, green: 0.2311287162, blue: 0.2350866051, alpha: 1)
        
        return tf
    }()
    lazy var phoneTextField: PhoneTextField = {
        let tf = PhoneTextField()
        tf.backgroundColor = .clear
        tf.textColor = #colorLiteral(red: 0.2298094199, green: 0.2311287162, blue: 0.2350866051, alpha: 1)
        tf.font = .getMullerMediumFont(on: 14)
        
        return tf
    }()
    lazy var iconView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = icon?.withRenderingMode(.alwaysOriginal)
        
        return iv
    }()
    
    //MARK: - Initialization
    init(frame: CGRect, inputType: InputTypes, title: String, placeholder: String, icon: UIImage?, heightAnchor: Int) {
        self.inputType = inputType
        self.placeholder = placeholder
        self.title = title
        self.icon = icon
        self.height = heightAnchor
        super.init(frame: frame)
        setupViews()
        if inputType == .phone {
            textField.keyboardType = .decimalPad
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setup functions
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9607843137, blue: 0.9764705882, alpha: 1)
        
    }
    
    private func setupViews() {
        backgroundColor = .anotherBlue
        addSubview(titleLabel)
        addSubview(iconView)
        
        if inputType == .phone {
            setupPhoneTextField()
        } else {
            setupTextField()
        }
        
        snp.makeConstraints { (make) in
            make.height.equalTo(height)
        }
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(24)
            make.centerY.equalToSuperview()
        }
        iconView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-10)
            make.height.width.equalTo(23)
        }
    }
    
    private func setupTextField() {
        addSubview(textField)
        textField.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalTo(iconView.snp.left).offset(-5)
            make.left.equalTo(titleLabel.snp.right).offset(5)
        }
    }
    
    private func setupPhoneTextField() {
        addSubview(phoneTextField)
        phoneTextField.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalTo(iconView.snp.left).offset(-5)
            make.left.equalTo(titleLabel.snp.right).offset(5)
        }
    }
    
    
}

