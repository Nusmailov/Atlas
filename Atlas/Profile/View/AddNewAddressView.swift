//
//  AddNewAddressView.swift
//  Delivery
//
//  Created by Nurzhigit Smailov on 8/27/19.
//  Copyright © 2019 Nurzhigit Smailov. All rights reserved.
//

import UIKit

class AddNewAddressView: UIView {
    
    // MARK: - Properties
    lazy var cardLabel:  UILabel = {
        let label = UILabel()
        label.font = .getMullerRegularFont(on: 16)
        label.textColor = #colorLiteral(red: 0.3176470588, green: 0.3607843137, blue: 0.4352941176, alpha: 1)
        label.text = "Добавить новый адрес"
        return label
    }()
    lazy var cityTextField: UITextField = {
        let text = UITextField()
        text.layer.borderWidth = 0.2
        text.layer.borderColor = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1)
        text.isEnabled = true
        text.text = "Город"
        text.layer.cornerRadius = 10
        return text
    }()
    lazy var streetTextField: InputTextField = {
        let text = InputTextField(frame: .zero, inputType: .plainText, title: "", placeholder: "Улица", icon: nil, heightAnchor: 40)
        text.layer.cornerRadius = 9
        
        return text
    }()
    lazy var apartmentTextField: InputTextField = {
        let text = InputTextField(frame: .zero, inputType: .plainText, title: "", placeholder: "Квартира", icon: nil, heightAnchor: 40)
        text.layer.cornerRadius = 9
        text.textField.keyboardType = UIKeyboardType.numberPad
        
        return text
    }()
    lazy var blockTextField: InputTextField = {
        let text = InputTextField(frame: .zero, inputType: .plainText, title: "", placeholder: "Дом", icon: nil, heightAnchor: 40)
        text.layer.cornerRadius = 9
        text.textField.keyboardType = UIKeyboardType.numberPad
        
        return text
    }()
    
    fileprivate let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 30))
    fileprivate let cityPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 30))
    fileprivate let apartmentPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 30))
    fileprivate let blockPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 30))
    
   
    lazy var doneButton: UIButton = {
        let button = UIButton()
        button.setTitle("Готово", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .mainColor
        button.layer.cornerRadius = 10
        button.titleLabel?.font = .getMullerBoldFont(on: 18)
        return button
    }()
    lazy var mapButton: UIButton = {
        let button = UIButton()
        button.setTitle("Указать на карте", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .mainColor
        button.layer.cornerRadius = 10
        button.titleLabel?.font = .getMullerBoldFont(on: 18)
        return button
    }()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - SetupViews
    func setupViews() {
        addSubview(cardLabel)
        addSubview(cityTextField)
        addSubview(streetTextField)
        addSubview(apartmentTextField)
        addSubview(blockTextField)
        addSubview(doneButton)
        addSubview(mapButton)
        
        cardLabel.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        streetTextField.snp.makeConstraints { (make) in
            make.top.equalTo(cardLabel.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(45)
        }
        streetTextField.textField.leftView = paddingView
        streetTextField.textField.leftViewMode = .always
        
        blockTextField.snp.makeConstraints { (make) in
            make.top.equalTo(streetTextField.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(16)
            make.right.equalTo(self.snp.centerX).offset(-8)
            
            make.height.equalTo(45)
        }
        blockTextField.textField.leftView = blockPaddingView
        blockTextField.textField.leftViewMode = .always
        
        apartmentTextField.snp.makeConstraints { (make) in
            make.top.equalTo(streetTextField.snp.bottom).offset(16)
            make.left.equalTo(self.snp.centerX).offset(8)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(45)
        }
        apartmentTextField.textField.leftView = apartmentPaddingView
        apartmentTextField.textField.leftViewMode = .always
        
        doneButton.snp.makeConstraints { (make) in
            make.top.equalTo(apartmentTextField.snp.bottom).offset(8)
            make.height.equalTo(45)
            make.left.equalTo(16)
            make.right.equalTo(-16)
        }
        
        mapButton.snp.makeConstraints { (make) in
            make.top.equalTo(doneButton.snp.bottom).offset(4)
            make.height.equalTo(45)
            make.left.equalTo(16)
            make.right.equalTo(-16)
            make.bottom.equalToSuperview()
        }
    }
}
