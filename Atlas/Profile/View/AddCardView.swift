//
//  AddCardView.swift
//  Delivery
//
//  Created by Nurzhigit Smailov on 8/27/19.
//  Copyright © 2019 Nurzhigit Smailov. All rights reserved.
//

import UIKit

class AddCardView: UIView, UITextViewDelegate {
    // MARK: - Properties
    lazy var cardLabel:  UILabel = {
        let label = UILabel()
        label.font = .getMullerBoldFont(on: 18)
        label.textColor = #colorLiteral(red: 0.3176470588, green: 0.3607843137, blue: 0.4352941176, alpha: 1)
        label.text = "Добавление новой карты"
        return label
    }()
    lazy var fullNameTextField: UITextField = {
        let text = UITextField()
        text.layer.borderWidth = 0.2
        text.layer.borderColor = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1)
        text.isEnabled = true
        text.placeholder = "Имя и Фамилия как на карте"
        text.layer.cornerRadius = 10
        text.autocapitalizationType = .allCharacters
        text.backgroundColor = .whiteBlue
        return text
    }()
    lazy var cardNumberTextField: UITextField = {
        let text = UITextField()
        text.layer.borderWidth = 0.2
        text.layer.borderColor = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1)
        text.isEnabled = true
        text.placeholder = "Введите номер карты:    "
        text.layer.cornerRadius = 10
        text.addTarget(self, action: #selector(didChangeText(textField:)), for: .editingChanged)
        text.keyboardType = UIKeyboardType.numberPad
        text.delegate = self
        text.backgroundColor = .whiteBlue
        return text
    }()
    lazy var monthCardTextField: UITextField = {
        let text = UITextField()
        text.layer.borderWidth = 0.2
        text.layer.borderColor = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1)
        text.isEnabled = true
        text.placeholder = "ММ"
        text.layer.cornerRadius = 10
        text.keyboardType = UIKeyboardType.numberPad
        text.backgroundColor = .whiteBlue
        text.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: .editingChanged)
        return text
    }()
    lazy var yearCardTextField: UITextField = {
        let text = UITextField()
        text.layer.borderWidth = 0.2
        text.layer.borderColor = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1)
        text.isEnabled = true
        text.placeholder = "ГГ"
        text.layer.cornerRadius = 10
        text.keyboardType = UIKeyboardType.numberPad
        text.backgroundColor = .whiteBlue
        text.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: .editingChanged)
        return text
    }()
    lazy var cvcCardTextField: UITextField = {
        let text = UITextField()
        text.layer.borderWidth = 0.2
        text.layer.borderColor = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1)
        text.isEnabled = true
        text.placeholder = "CCV / CVC"
        text.layer.cornerRadius = 10
        text.keyboardType = UIKeyboardType.numberPad
        text.backgroundColor = .whiteBlue
        text.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: .editingChanged)
        return text
    }()
    lazy var textView: UITextView = {
        let view = UITextView()
        view.textColor = .black
        view.backgroundColor  = .orange
        let attributedString = NSMutableAttributedString(string: "Want to learn iOS? You should visit the best source of free iOS tutorials!")
        attributedString.addAttribute(.link, value: "https://www.hackingwithswift.com", range: NSRange(location: 19, length: 55))
        
        view.attributedText = attributedString
        return view
    }()
    lazy var cardImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = #imageLiteral(resourceName: "cardImage")
        return view
    }()
    lazy var agreementLabel: UILabel = {
        let label = UILabel()
        label.font = .getMontserraBoldFont(on: 15)
        label.textColor = UIColor(red: 0.318, green: 0.361, blue: 0.435, alpha: 1)
        label.text = "Добавление новой карты"
        label.numberOfLines = 0
        return label
    }()
    lazy var agreementDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .getMontserraRegularFont(on: 13)
        label.textColor = UIColor(red: 0.318, green: 0.361, blue: 0.435, alpha: 1)
        label.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint"
        label.numberOfLines = 0
        return label
    }()
    lazy var addCardButton: UIButton = {
        let button = UIButton()
//        button.addTarget(self, action: #selector(openOrderViewCotroller), for: .touchUpInside)
        button.setTitle("Добавить", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .mainColor
        button.layer.cornerRadius = 10
        button.titleLabel?.font = .getMullerBoldFont(on: 18)
        return button
    }()
    
    let namePaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 30))
    let numberPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 30))
    let yearPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 30))
    let monthPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 30))
    let cvcPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 30))
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        backgroundColor = .white
        layer.cornerRadius = 10
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - SetupViews
    func setupViews() {
        addSubviews(views: [agreementDescriptionLabel, cardLabel, cardNumberTextField,
                            monthCardTextField, fullNameTextField,
                            yearCardTextField, cvcCardTextField,
                            cardImageView, agreementLabel, addCardButton])
        
        cardLabel.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        fullNameTextField.snp.makeConstraints { (make) in
            make.top.equalTo(cardLabel.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(45)
        }
        fullNameTextField.leftView = namePaddingView
        fullNameTextField.leftViewMode = .always
        
        cardNumberTextField.snp.makeConstraints { (make) in
            make.top.equalTo(fullNameTextField.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(45)
        }
        
        cardNumberTextField.leftView = numberPaddingView
        cardNumberTextField.leftViewMode = .always
        
        monthCardTextField.snp.makeConstraints { (make) in
            make.top.equalTo(cardNumberTextField.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(16)
            make.width.equalTo(45)
            make.height.equalTo(45)
        }
        monthCardTextField.leftView = monthPaddingView
        monthCardTextField.leftViewMode = .always

        yearCardTextField.snp.makeConstraints { (make) in
            make.top.equalTo(cardNumberTextField.snp.bottom).offset(16)
            make.left.equalTo(monthCardTextField.snp.right).offset(16)
            make.width.equalTo(45)
            make.height.equalTo(45)
        }
        yearCardTextField.leftView = yearPaddingView
        yearCardTextField.leftViewMode = .always

        cvcCardTextField.snp.makeConstraints { (make) in
            make.top.equalTo(cardNumberTextField.snp.bottom).offset(16)
            make.left.equalTo(yearCardTextField.snp.right).offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(45)
        }
        cvcCardTextField.leftView = cvcPaddingView
        cvcCardTextField.leftViewMode = .always

        agreementLabel.snp.makeConstraints { (make) in
            make.top.equalTo(cvcCardTextField.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        agreementDescriptionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(agreementLabel.snp.bottom).offset(4)
            make.left.equalTo(16)
            make.right.equalTo(-16)
        }
        
        cardImageView.snp.makeConstraints { (make) in
            make.top.equalTo(agreementDescriptionLabel.snp.bottom).offset(16)
            make.right.left.equalToSuperview()
        }
        addCardButton.snp.makeConstraints { (make) in
            make.top.equalTo(cardImageView.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(16)
            make.height.equalTo(60)
            make.bottom.right.equalToSuperview().offset(-16)
        }
    }
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        UIApplication.shared.open(URL)
        return false
    }
    
    
    // MARK: - Actions
    @objc private func textFieldDidChange(textField: UITextField) {
        guard let text = textField.text else { return }
        
        if cvcCardTextField.text!.count == 3 {
            cvcCardTextField.resignFirstResponder()
        }
        else if text.count == 2 {
            switch textField {
            case monthCardTextField:
                yearCardTextField.becomeFirstResponder()
            case yearCardTextField:
                cvcCardTextField.becomeFirstResponder()
            default:
                break
            }
        }
    }
    
    
}

// MARK: - TextFieldDelegate
extension AddCardView: UITextFieldDelegate {
    
    @objc func didChangeText(textField:UITextField) {
        textField.text = self.modifyCreditCardString(creditCardString: textField.text!)
    }
    
    func modifyCreditCardString(creditCardString : String) -> String {
        let trimmedString = creditCardString.components(separatedBy: .whitespaces).joined()
        
        let arrOfCharacters = Array(trimmedString)
        var modifiedCreditCardString = ""
        
        if(arrOfCharacters.count > 0) {
            for i in 0...arrOfCharacters.count-1 {
                modifiedCreditCardString.append(arrOfCharacters[i])
                if((i+1) % 4 == 0 && i+1 != arrOfCharacters.count){
                    modifiedCreditCardString.append(" ")
                }
            }
        }
        return modifiedCreditCardString
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newLength = (textField.text ?? "").count + string.count - range.length
        if(textField == cardNumberTextField) {
            return newLength <= 19
        }
        return true
    }
}
