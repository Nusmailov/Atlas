//
//  AddButtonView.swift
//  Delivery
//
//  Created by Nurzhigit Smailov on 8/26/19.
//  Copyright © 2019 Nurzhigit Smailov. All rights reserved.
//

import UIKit

class AddButtonView: UIView {
    
    //MARK: - Properties
        lazy var buttonView: UIButton = {
            let button = UIButton()
            button.layer.cornerRadius = 12
            button.backgroundColor = .mainColor
            button.setTitleColor(.white, for: .normal)
            button.tintColor = .white
            button.titleLabel?.font = .getMullerBoldFont(on: 16)
            button.setImage(#imageLiteral(resourceName: "open"), for: .normal)
            button.semanticContentAttribute = .forceRightToLeft
            button.sizeToFit()
            button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0);

            
            return button
        }()
            
    //        ButtonView = {
    //        let button = ButtonView()
    //
    //        return button
    //    }()
        
        lazy var addnewAddressView: AddNewAddressView = {
            let view = AddNewAddressView()
            
            return view
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
            backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            
            onlyButtonSetupViews()
        }
        
        func onlyButtonSetupViews() -> Void {
            addSubview(buttonView)
            buttonView.snp.makeConstraints { (make) in
                make.top.equalToSuperview().offset(10)
                make.height.equalTo(47)
                make.left.equalTo(16)
                make.right.equalTo(-16)
    //            make.width.equalToSuperview()
                make.bottom.equalToSuperview().offset(-10)
            }
        }
        
        func allSetupViews() -> Void {
            addSubview(addnewAddressView)
            addSubview(buttonView)
            
            addnewAddressView.snp.makeConstraints { (make) in
                make.top.equalToSuperview().offset(10)
                make.height.equalTo(40)
                make.width.equalToSuperview()
            }
            buttonView.snp.makeConstraints { (make) in
                make.top.equalTo(addnewAddressView.snp.bottom).offset(10)
                make.height.equalTo(47)
                make.width.equalToSuperview()
                make.bottom.equalToSuperview().offset(-10)
            }
            
        }
        
    }
