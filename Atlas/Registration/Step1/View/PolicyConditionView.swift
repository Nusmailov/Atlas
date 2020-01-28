//
//  PolycyCondition.swift
//  Atlas
//
//  Created by Eldor Makkambayev on 11/20/19.
//  Copyright © 2019 Eldor Makkambayev. All rights reserved.
//

import UIKit
import BEMCheckBox

class PolicyConditionView: UIView {

    //MARK: - Properties
    lazy var policyCondition: CheckBoxWithTitleView = {
        let policy = CheckBoxWithTitleView(title: "", chackboxSize: 30, titleSize: 13, checkboxPosition: .left)
        policy.titleLabel.numberOfLines = 0
        policy.titleLabel.font = .getMullerRegularFont(on: 14)
        
        
        let attrs1 = [NSAttributedString.Key.font : UIFont.getMullerRegularFont(on: 14), NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.1725490196, green: 0.6509803922, blue: 1, alpha: 1), .underlineStyle: NSUnderlineStyle.single.rawValue] as [NSAttributedString.Key : Any]
        
        let attrs2 = [NSAttributedString.Key.font : UIFont.getMullerRegularFont(on: 14), NSAttributedString.Key.foregroundColor : UIColor.black]
        let attributedString0 = NSMutableAttributedString(string:"Я согласен с ", attributes:attrs2)
        
        let attributedString1 = NSMutableAttributedString(string:"условиями использования", attributes:attrs1)
        
        let attributedString2 = NSMutableAttributedString(string:" и \n", attributes:attrs2)
        
        let attributedString3 = NSMutableAttributedString(string:"политикой конфиденциальности", attributes:attrs1)
        
        
        attributedString2.append(attributedString3)
        attributedString1.append(attributedString2)
        attributedString0.append(attributedString1)
        
        policy.titleLabel.attributedText = attributedString0
        
        return policy
    }()

    //MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    //MARK: - Setup functions
    private func setupView() -> Void {
        addSubview(policyCondition)
        policyCondition.snp.makeConstraints { (make) in
            make.left.equalTo(30)
            make.bottom.top.equalToSuperview()
            make.right.equalTo(-30)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
