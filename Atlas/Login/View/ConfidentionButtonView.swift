//
//  ConfidentionAndRegistrationButtonView.swift
//  Santo
//
//  Created by Eldor Makkambayev on 9/24/19.
//  Copyright © 2019 Eldor Makkambayev. All rights reserved.
//

import Foundation
import UIKit

class ConfidentionButtonView: UIView {
    
    //MARK: - Properties
    lazy var line = ConfidantionLabelTopLineView()
    lazy var btnPrivacy: UIButton = {
        let privacy = UIButton()
        
//        privacy.numberOfLines = 0
                
        let attrs1 = [NSAttributedString.Key.font : UIFont.getMullerRegularFont(on: 13), NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.1725490196, green: 0.6509803922, blue: 1, alpha: 1), .underlineStyle: NSUnderlineStyle.single.rawValue] as [NSAttributedString.Key : Any]
        
        let attrs2 = [NSAttributedString.Key.font : UIFont.getMullerRegularFont(on: 13), NSAttributedString.Key.foregroundColor : UIColor.black]
        
        let attributedString1 = NSMutableAttributedString(string:"Условия использования", attributes:attrs1)
        
        let attributedString2 = NSMutableAttributedString(string:" и \n", attributes:attrs2)
        
        let attributedString3 = NSMutableAttributedString(string:"Политику конфиденциальности", attributes:attrs1)
        
        
        attributedString2.append(attributedString3)
        attributedString1.append(attributedString2)
        
//        privacy.attributedText = attributedString1
        privacy.setAttributedTitle(attributedString1, for: .normal)
        privacy.titleLabel?.textAlignment = .center
        privacy.titleLabel?.numberOfLines = 0
        
        return privacy
    }()

    //MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    //MARK: - Setup functions
    private func setupView() -> Void {
        addSubview(line)
        line.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
        }
        
        addSubview(btnPrivacy)
        btnPrivacy.snp.makeConstraints { (make) in
            make.top.equalTo(line.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
