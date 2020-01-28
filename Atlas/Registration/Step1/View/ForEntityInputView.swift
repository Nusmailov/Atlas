//
//  ForEntityInputView.swift
//  Atlas
//
//  Created by Eldor Makkambayev on 11/20/19.
//  Copyright © 2019 Eldor Makkambayev. All rights reserved.
//

import UIKit

class ForEntityInputView: UIView {

    //MARK: - Properties
    lazy var requisiteInputView: TitleInputView = {
        let textfield = TitleInputView(frame: .zero, inputType: .plainText, title: "*Реквизиты", placeholder: "54765345453-SBDB", icon: nil, heightAnchor: 40)
        textfield.inputTextView.iconView.tintColor = .inputViewColor
        textfield.layer.cornerRadius = 10
        
        return textfield
    }()
    lazy var numberOfContractInputView: TitleInputView = {
        let textfield = TitleInputView(frame: .zero, inputType: .plainText, title: "*Номер договора", placeholder: "57498498467654-54541665", icon: nil, heightAnchor: 40)
        textfield.inputTextView.iconView.tintColor = .inputViewColor
        textfield.layer.cornerRadius = 10
        
        return textfield
    }()
    
    //MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    //MARK: - Setup functions
    private func setupView() -> Void {
        addSubview(requisiteInputView)
        requisiteInputView.snp.makeConstraints { (make) in
            make.centerX.top.equalToSuperview()
            make.left.equalTo(20)
            make.right.equalTo(-20)
        }
        addSubview(numberOfContractInputView)
        numberOfContractInputView.snp.makeConstraints { (make) in
            make.top.equalTo(requisiteInputView.snp.bottom).offset(15)
            make.centerX.bottom.equalToSuperview()
            make.width.equalTo(requisiteInputView)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
