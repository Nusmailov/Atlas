//
//  CodeTextFieldView.swift
//  Atlas
//
//  Created by Tuigynbekov Yelzhan on 10/19/19.
//  Copyright © 2019 Yelzhan Tuigynbekov. All rights reserved.
//

import UIKit
class CodeTextFieldView: UIView {
    
    //MARK:- Preasire
    lazy var passhereLabel: UILabel = {
        let label = UILabel()
        label.text = "Введите его сюда:"
        label.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 12)
        
        return label
    }()
    lazy var firstInputTextField: UITextField = {
        let text = UITextField()
        text.layer.cornerRadius = 10
        text.backgroundColor = #colorLiteral(red: 0.9725490196, green: 0.9803921569, blue: 0.9882352941, alpha: 1)
        text.layer.borderWidth = 1.0
        text.layer.borderColor = #colorLiteral(red: 0.9058823529, green: 0.9058823529, blue: 0.9058823529, alpha: 1)
        text.keyboardType = UIKeyboardType.numberPad
        text.textAlignment = .center
        text.isSecureTextEntry = false
        text.textColor = .mainColor
        text.tintColor = .mainColor
        text.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: .editingChanged)
        return text
    }()
    lazy var secondInputTextField: UITextField = {
        let text = UITextField()
        text.layer.cornerRadius = 10
        text.backgroundColor = #colorLiteral(red: 0.9725490196, green: 0.9803921569, blue: 0.9882352941, alpha: 1)
        text.isSecureTextEntry = false
        text.layer.borderWidth = 1.0
        text.layer.borderColor = #colorLiteral(red: 0.9058823529, green: 0.9058823529, blue: 0.9058823529, alpha: 1)
        text.keyboardType = UIKeyboardType.numberPad
        text.textAlignment = .center
        text.textColor = .mainColor
        text.tintColor = .mainColor
        text.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: .editingChanged)
        return text
    }()
    lazy var thirdInputTextField: UITextField = {
        let text = UITextField()
        text.layer.cornerRadius = 10
        text.backgroundColor = #colorLiteral(red: 0.9725490196, green: 0.9803921569, blue: 0.9882352941, alpha: 1)
        text.layer.borderWidth = 1.0
        text.isSecureTextEntry = false
        text.layer.borderColor = #colorLiteral(red: 0.9058823529, green: 0.9058823529, blue: 0.9058823529, alpha: 1)
        text.keyboardType = UIKeyboardType.numberPad
        text.textAlignment = .center
        text.textColor = .mainColor
        text.tintColor = .mainColor
        text.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: .editingChanged)
        return text
    }()
    lazy var fourthInputTextField: UITextField = {
        let text = UITextField()
        text.layer.cornerRadius = 10
        text.backgroundColor = #colorLiteral(red: 0.9725490196, green: 0.9803921569, blue: 0.9882352941, alpha: 1)
        text.layer.borderWidth = 1.0
        text.layer.borderColor = #colorLiteral(red: 0.9058823529, green: 0.9058823529, blue: 0.9058823529, alpha: 1)
        text.isSecureTextEntry = false
        text.keyboardType = UIKeyboardType.numberPad
        text.textAlignment = .center
        text.textColor = .mainColor
        text.tintColor = .mainColor
        text.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: .editingChanged)
        return text
    }()
    lazy var sendagainLabel: UILabel = {
        let label = UILabel()
        label.text = "Отправить код повторно через 0:48"
        label.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 13)
        
        return label
    }()
    
    //MARK:- Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK:- SetupViews
    func setupViews() -> Void {
        addSubview(passhereLabel)
        addSubview(firstInputTextField)
        addSubview(secondInputTextField)
        addSubview(thirdInputTextField)
        addSubview(fourthInputTextField)
        addSubview(sendagainLabel)
        
        passhereLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        firstInputTextField.snp.makeConstraints { (make) in
            make.right.equalTo(secondInputTextField.snp.left).offset(-15)
            make.height.width.equalTo(50)
            make.top.equalTo(passhereLabel.snp.bottom).offset(11)
        }
        secondInputTextField.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview().offset(-35)
            make.height.width.equalTo(50)
            make.top.equalTo(passhereLabel.snp.bottom).offset(11)
        }
        thirdInputTextField.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview().offset(35)
            make.height.width.equalTo(50)
            make.top.equalTo(passhereLabel.snp.bottom).offset(11)
        }
        fourthInputTextField.snp.makeConstraints { (make) in
            make.left.equalTo(thirdInputTextField.snp.right).offset(15)
            make.height.width.equalTo(50)
            make.top.equalTo(passhereLabel.snp.bottom).offset(11)
        }
        sendagainLabel.snp.makeConstraints { (make) in
            make.top.equalTo(firstInputTextField.snp.bottom).offset(21)
            make.bottom.centerX.equalToSuperview()
        }
    }
    
    //MARK: - @objc function
    @objc func textFieldDidChange(textField: UITextField) {
        let text = textField.text
        if text?.count == 1 {
            switch textField {
            case firstInputTextField:
                firstInputTextField.layer.borderColor = UIColor.mainColor.cgColor
                secondInputTextField.becomeFirstResponder()
            case secondInputTextField:
                secondInputTextField.layer.borderColor = UIColor.mainColor.cgColor
                thirdInputTextField.becomeFirstResponder()
            case thirdInputTextField:
                thirdInputTextField.layer.borderColor = UIColor.mainColor.cgColor
                fourthInputTextField.becomeFirstResponder()
            case fourthInputTextField:
                fourthInputTextField.layer.borderColor = UIColor.mainColor.cgColor
                fourthInputTextField.resignFirstResponder()
            default:
                break
            }
        }
        if text?.count == 0 {
            switch textField {
            case secondInputTextField:
                secondInputTextField.layer.borderColor = #colorLiteral(red: 0.9333333333, green: 0.8941176471, blue: 0.9568627451, alpha: 1)
                firstInputTextField.becomeFirstResponder()
            case thirdInputTextField:
                thirdInputTextField.layer.borderColor = #colorLiteral(red: 0.9333333333, green: 0.8941176471, blue: 0.9568627451, alpha: 1)
                secondInputTextField.becomeFirstResponder()
            case fourthInputTextField:
                fourthInputTextField.layer.borderColor = #colorLiteral(red: 0.9333333333, green: 0.8941176471, blue: 0.9568627451, alpha: 1)
                thirdInputTextField.becomeFirstResponder()
            default:
                break
            }
        }
    }
}
