//
//  SignInEventsView.swift
//  Santo
//
//  Created by Eldor Makkambayev on 9/26/19.
//  Copyright © 2019 Eldor Makkambayev. All rights reserved.
//

import Foundation
import UIKit
import BEMCheckBox

class SignInEventsView: UIView, BEMCheckBoxDelegate {
    
    //MARK: - Properties
    
    lazy var rememberMeCheckbox: BEMCheckBox = {
        let check = BEMCheckBox(frame: CGRect(x: 15, y: 530, width: 18, height: 18))
        check.on = true
        check.onTintColor = #colorLiteral(red: 0.9490196078, green: 0.9607843137, blue: 0.9764705882, alpha: 1)
        check.onCheckColor = .mainColor
        check.boxType = BEMBoxType.square
        check.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        check.onFillColor = #colorLiteral(red: 0.9490196078, green: 0.9607843137, blue: 0.9764705882, alpha: 1)
        check.offFillColor = #colorLiteral(red: 0.7843137255, green: 0.2039215686, blue: 0.2784313725, alpha: 0.7)
        check.onAnimationType = BEMAnimationType.bounce
        check.offAnimationType = BEMAnimationType.bounce
        
        return check
    }()
    lazy var rememberMeLabel: UILabel = {
        var rml = UILabel()
        rml.text = "Запомнить меня"
        rml.font = .getMullerRegularFont(on: 12)
        
        return rml
    }()
    lazy var signInButton = MainButton(title: "Войти")
    lazy var forgetButton: UIButton = {
        let rb = UIButton()
        rb.titleLabel?.font = .getMullerRegularFont(on: 12)
        rb.titleLabel?.textColor = .blue
        let yourAttributes : [NSAttributedString.Key: Any] = [NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.1725490196, green: 0.6509803922, blue: 1, alpha: 1),
                                                              NSAttributedString.Key.underlineStyle : NSUnderlineStyle.single.rawValue]
        let attString = NSMutableAttributedString(string: "Забыли пароль?",
                                                  attributes: yourAttributes)
        
        rb.setAttributedTitle(attString, for: .normal)
        
        return rb
    }()
    lazy var regButton: UIButton = {
        let rb = UIButton()
        rb.titleLabel?.font = .getMullerRegularFont(on: 13)
        rb.titleLabel?.textColor = .blue
        let yourAttributes : [NSAttributedString.Key: Any] = [NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.1725490196, green: 0.6509803922, blue: 1, alpha: 1),
                                                              NSAttributedString.Key.underlineStyle : NSUnderlineStyle.single.rawValue]
        let attString = NSMutableAttributedString(string: "Зарегистрироваться",
                                                  attributes: yourAttributes)
        
        rb.setAttributedTitle(attString, for: .normal)
        
        return rb
    }()

    //MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    //MARK: - Setup functions
    private func setupView() -> Void {
        addSubview(forgetButton)
        forgetButton.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(37)
        }
        addSubview(rememberMeCheckbox)
        rememberMeCheckbox.snp.makeConstraints { (make) in
            make.centerY.equalTo(forgetButton)
            make.right.equalToSuperview().offset(-38)
            make.height.equalTo(16)
            make.width.equalTo(16)
        }
        addSubview(rememberMeLabel)
        rememberMeLabel.snp.makeConstraints { (make) in
            make.right.equalTo(rememberMeCheckbox.snp.left).offset(-6)
            make.centerY.equalTo(rememberMeCheckbox)
        }
        addSubview(signInButton)
        signInButton.snp.makeConstraints { (make) in
            make.top.equalTo(forgetButton.snp.bottom).offset(12)
            make.height.equalTo(50)
            make.left.equalTo(40)
            make.right.equalTo(-40)
            make.bottom.equalToSuperview()
        }
    }
 
    //    MARK: - Simple functions
    
    func didTap(_ checkBox: BEMCheckBox) {
        UserDefaults.standard.set(checkBox.on, forKey: AppConstants.saveMe)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
