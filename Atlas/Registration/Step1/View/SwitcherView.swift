//
//  SwitcherView.swift
//  Atlas
//
//  Created by Eldor Makkambayev on 11/20/19.
//  Copyright © 2019 Eldor Makkambayev. All rights reserved.
//

import UIKit

class SwitcherView: UIView {
    
    //MARK: - Properties
    
    lazy var titleLabel: UILabel = {
        let title = UILabel()
        title.textColor = .mainColor
        title.font = .getMullerBoldFont(on: 15)
        title.text = "Тип пользователя"
        
        return title
    }()

    lazy var switcherView: SwtchView = {
        let switcher = SwtchView()
        switcher.layer.cornerRadius = 16
        switcher.leftLabel.text = "Физ.лицо"
        switcher.rightLabel.text = "Юр.лицо"
        
        return switcher
    }()
    
    //MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    //MARK: - Setup functions
    private func setupView() -> Void {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(25)
            make.top.equalToSuperview()
        }
        addSubview(switcherView)
        switcherView.snp.makeConstraints { (make) in
            make.left.equalTo(34)
            make.top.equalTo(titleLabel.snp.bottom).offset(15)
            make.right.equalTo(-34)
            make.height.equalTo(32)
            make.bottom.equalToSuperview()
        }

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
