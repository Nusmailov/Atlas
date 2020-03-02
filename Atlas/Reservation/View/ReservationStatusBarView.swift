//
//  ReservationStatusBarView.swift
//  Atlas
//
//  Created by Nurzhigit Smailov on 2/27/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import UIKit

class ReservationStatusBarView: UIView {
    
    //MARK: - Properties
    lazy var backButton: UIButton = {
        let button = UIButton()
        return button
    }()
    lazy var requisitLabel: UILabel = {
        let label = UILabel()
        label.text = "Реквизиты"
        return label
    }()
    lazy var refreshButton: UIButton = {
        let button = UIButton()
        return button
    }()
    lazy var sendRequisitButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - SetupViews
    func setupViews() {
        addSubview(backButton)
        addSubview(requisitLabel)
        addSubview(refreshButton)
        addSubview(sendRequisitButton)
        
        backButton.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-16)
            make.height.width.equalTo(40)
        }
        requisitLabel.snp.makeConstraints { (make) in
            make.left.equalTo(backButton.snp.right).offset(16)
            make.centerY.equalTo(backButton)
        }
        sendRequisitButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(backButton)
            make.right.equalTo(-16)
            make.height.width.equalTo(40)
        }
        refreshButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(backButton)
            make.right.equalTo(sendRequisitButton.snp.left).offset(-16)
            make.height.width.equalTo(40)
        }
    }
    
}
