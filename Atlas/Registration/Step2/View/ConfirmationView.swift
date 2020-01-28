//
//  ConfirmationView.swift
//  Atlas
//
//  Created by Eldor Makkambayev on 11/21/19.
//  Copyright © 2019 Eldor Makkambayev. All rights reserved.
//

import UIKit

class ConfirmationView: UIView {

    //    MARK: - Preporties
    lazy var confirmationLabel: UILabel = {
        let label = UILabel()
        label.text = "Подтверждение"
        label.textColor = .mainColor
        label.font = .getMullerBoldFont(on: 25)
        
        return label
    }()
    lazy var numberLabel: UILabel = {
        let label = UILabel()
        label.text = "+7(707)185-02-65"
        label.textColor = #colorLiteral(red: 0.7843137255, green: 0.2039215686, blue: 0.2784313725, alpha: 1)
        label.font = .getMullerBoldFont(on: 18)
        
        return label
    }()
    lazy var sendcodeLabel: UILabel = {
        let label = UILabel()
        label.text = "На ваш номер отправлен код"
        label.textColor = #colorLiteral(red: 0.7843137255, green: 0.2039215686, blue: 0.2784313725, alpha: 1)
        label.font = UIFont.getMullerRegularFont(on: 14)
        
        return label
    }()
    lazy var codetextfieldView: CodeTextFieldView = {
        let view = CodeTextFieldView()
        
        return view
    }()
    //MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //    MARK: - setup functions
    private func setupView() -> Void {
        addSubview(confirmationLabel)
        addSubview(numberLabel)
        addSubview(sendcodeLabel)
        addSubview(codetextfieldView)
        
        confirmationLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalTo(26)
        }
        numberLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(confirmationLabel.snp.bottom).offset(18)
        }
        sendcodeLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(numberLabel.snp.bottom).offset(9)
        }
        codetextfieldView.snp.makeConstraints { (make) in
            make.top.equalTo(sendcodeLabel.snp.bottom).offset(35)
            make.centerX.bottom.width.equalToSuperview()
            make.height.equalTo(115)
        }

    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
