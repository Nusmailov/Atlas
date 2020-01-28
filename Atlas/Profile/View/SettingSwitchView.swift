//
//  SettingSwitchView.swift
//  Atlas
//
//  Created by Nurzhigit Smailov on 1/27/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import UIKit

class SettingSwitchView: UIView {
    
    //MARK: - Properties
    lazy var textLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.3176470588, green: 0.3607843137, blue: 0.4352941176, alpha: 1)
        label.font = .getMontserraMediumFont(on: 14)
        label.text = "Been implemented"
        return label
    }();
    lazy var switchView: UISwitch = {
        let view = UISwitch()
        return view
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
        layer.borderWidth = 0.2
        layer.borderColor = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1)
        layer.cornerRadius = 10
        isUserInteractionEnabled = true
        backgroundColor = UIColor(red: 0.973, green: 0.98, blue: 0.988, alpha: 1)
        
        addSubview(textLabel)
        addSubview(switchView)
        textLabel.snp.makeConstraints { (make) in
            make.left.equalTo(8)
            make.centerY.equalToSuperview()
        }
        switchView.snp.makeConstraints { (make) in
            make.right.equalTo(-8)
            make.centerY.equalToSuperview()
        }
    }
}
