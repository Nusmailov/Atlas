//
//  BonusView.swift
//  Delivery
//
//  Created by Nurzhigit Smailov on 8/26/19.
//  Copyright © 2019 Nurzhigit Smailov. All rights reserved.
//

import UIKit
//import SwiftPhoneNumberFormatter

class BonusView: UIView {
    // MARK: - Properties
    let bonusLabel: UILabel = {
        let label = UILabel()
        label.font = .getMullerBoldFont(on: 18)
        label.numberOfLines = 0
        label.textColor = #colorLiteral(red: 0.3176470588, green: 0.3607843137, blue: 0.4352941176, alpha: 1)
        return label
    }()
    lazy var textView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.borderColor = #colorLiteral(red: 0.9568627451, green: 0.9607843137, blue: 0.9803921569, alpha: 1)
        view.layer.borderWidth = 1
        return view
    }()
    lazy var bonusCountLabel: UILabel = {
        let label = UILabel()
        label.font = .getMullerRegularFont(on: 14)
        label.numberOfLines = 0
        label.textColor = #colorLiteral(red: 0.3176470588, green: 0.3607843137, blue: 0.4352941176, alpha: 1)
        return label
    }()
    lazy var takeBonusButton: AddButtonView = {
        let button = AddButtonView()
        button.buttonView.addTarget(self, action: #selector(hideShowPhoneView), for: .touchUpInside)
        button.buttonView.setTitle("getBonus", for: .normal)
        return button
    }()
    lazy var restText: UILabel = {
        let label = UILabel()
        label.text = "bonustext"
        label.font = .getMullerRegularFont(on: 14)
        label.numberOfLines = 0
        label.textColor = #colorLiteral(red: 0.3176470588, green: 0.3607843137, blue: 0.4352941176, alpha: 1)
        return label
    }()
    lazy var phoneNumberTextField: PhoneTextField  = {
        let text = PhoneTextField()
//        text.placeholder = DefaultString.phoneNumberEnter
        text.layer.borderWidth = 0.2
        text.layer.borderColor = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1)
        text.isEnabled = true
        text.layer.cornerRadius = 10
        text.keyboardType = UIKeyboardType.namePhonePad
//        text.config.defaultConfiguration = PhoneFormat(defaultPhoneFormat: "(###) ###-##-##")
//        text.prefix = "+7 "
        text.attributedPlaceholder = NSAttributedString(string: "", attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.3176470588, green: 0.3607843137, blue: 0.4352941176, alpha: 1)])
        return text
    }()
    var bonus: Int! {
        didSet {
            DispatchQueue.main.async {
                self.bonusCountLabel.text = "accumulated - \(String(describing: self.bonus!)) Bonus"
            }
        }
    }
    let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 30))
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        bonusLabel.text = "Bonus"
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - SetupViews
    func setupViews() {
        addSubview(bonusLabel)
        addSubview(textView)
        addSubview(takeBonusButton)
        addSubview(restText)
        addSubview(phoneNumberTextField)
        
        restText.isHidden = true
        phoneNumberTextField.isHidden = true
        
        bonusLabel.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        textView.snp.makeConstraints { (make) in
            make.top.equalTo(bonusLabel.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        
        textView.addSubview(bonusCountLabel)
        bonusCountLabel.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().offset(16)
            make.bottom.right.equalToSuperview().offset(-16)
        }
        
        takeBonusButton.snp.makeConstraints { (make) in
            make.top.equalTo(textView.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-16)
            make.height.equalTo(45)
        }
        phoneNumberTextField.leftView = paddingView
        phoneNumberTextField.leftViewMode = .always
    }
    
    // MARK: - Actions
    func setBonus(bonus: Int) {
        self.bonus = bonus
    }
    
    @objc func hideShowPhoneView() {
        restText.isHidden = !restText.isHidden
        phoneNumberTextField.isHidden = !phoneNumberTextField.isHidden
        self.takeBonusButton.buttonView.imageView?.transform = CGAffineTransform(scaleX: 1, y: -1)
        if  !phoneNumberTextField.isHidden {
            self.restText.snp.makeConstraints { (make) in
                make.top.equalTo(self.textView.snp.bottom).offset(16)
                make.left.equalToSuperview().offset(16)
                make.right.equalToSuperview().offset(-16)
            }
            self.phoneNumberTextField.snp.makeConstraints { (make) in
                make.top.equalTo(self.restText.snp.bottom).offset(16)
                make.left.equalToSuperview().offset(16)
                make.right.equalToSuperview().offset(-16)
                make.height.equalTo(50)
            }
            self.takeBonusButton.snp.remakeConstraints { (make) in
                make.top.equalTo(self.phoneNumberTextField.snp.bottom).offset(16)
                make.left.equalToSuperview().offset(16)
                make.right.equalToSuperview().offset(-16)
                make.bottom.equalToSuperview().offset(-16)
                make.height.equalTo(50)
            }
            self.takeBonusButton.buttonView.imageView?.transform = CGAffineTransform(scaleX: -1, y: 1)
        } else {
            takeBonusButton.snp.remakeConstraints { (make) in
                make.top.equalTo(textView.snp.bottom).offset(16)
                make.left.equalToSuperview().offset(16)
                make.right.equalToSuperview().offset(-16)
                make.bottom.equalToSuperview().offset(-16)
                make.height.equalTo(50)
            }
            self.takeBonusButton.buttonView.imageView?.transform = CGAffineTransform(scaleX: 1, y: -1)
        }
    }
}
