//
//  PhoneTextField.swift
//  Atlas
//
//  Created by Tuigynbekov Yelzhan on 10/18/19.
//  Copyright © 2019 Yelzhan Tuigynbekov. All rights reserved.
//

import UIKit
class PhoneTextField: UITextField {
    
    //MARK:- Preasure
    fileprivate var image: UIButton = {
        let button = UIButton()
        button.setImage(UIImage.init(named: "phone"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
        
        return button
    }()
    
    fileprivate var label: UILabel = {
        let label = UILabel()
        label.text = ""
        
        return label
    }()
    
    //MARK:- Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = #colorLiteral(red: 0.9725490196, green: 0.9803921569, blue: 0.9882352941, alpha: 1)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- SetupViews
    func setupViews() -> Void {
        layer.cornerRadius = 17
        
        leftView = label
        leftViewMode = .always
        rightViewMode = .always
        rightView = image
        textColor = #colorLiteral(red: 0.7843137255, green: 0.2039215686, blue: 0.2784313725, alpha: 1)
        tintColor = #colorLiteral(red: 0.7843137255, green: 0.2039215686, blue: 0.2784313725, alpha: 1)
        font = UIFont.boldSystemFont(ofSize: 15)
        text = "+7"
        delegate = self
        keyboardType = .decimalPad
    }
    
}
//MARK:- UITextFieldDelegate
extension PhoneTextField: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let text = textField.text!
        let spaceIndex = [2, 6, 10, 13]

        if text == "+7" && string == "" {
            return false
        }

        if text.count == 16 && string != "" {
            return false
        }

        if spaceIndex.contains(textField.text!.count) && string != "" {
            textField.text!.append(" ")
        }
        
        return true
    }
    
}
