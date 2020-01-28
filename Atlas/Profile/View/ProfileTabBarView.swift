//
//  ProfileTabBarView.swift
//  Delivery
//
//  Created by Nurzhigit Smailov on 10/30/19.
//  Copyright © 2019 Nurzhigit Smailov. All rights reserved.
//

import UIKit

class ProfileTabBarView: UIView {
    //MARK: - Properties
//    lazy var leftButton: UIButton = {
//        let button = UIButton()
//        button.setImage(UIImage(named: MediaType.Settings), for: .normal)
//        return button
//    }()
//    lazy var busketCountButton: BusketCountButton = {
//        let button = BusketCountButton()
//        return button
//    }()
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .getMullerBoldFont(on: 18)
        label.numberOfLines = 2
        label.text = "Профиль"
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0.3176470588, green: 0.3607843137, blue: 0.4352941176, alpha: 1)
        return label
    }()
    lazy var borderLine: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.9137254902, green: 0.9137254902, blue: 0.9137254902, alpha: 1)
        return view
    }()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - SetupViews
    func setupViews() {
//        addSubview(leftButton)
//        addSubview(busketCountButton)
        addSubview(nameLabel)
        addSubview(borderLine)
        
//        leftButton.snp.makeConstraints { (make) in
//            make.top.equalTo(8)
//            make.bottom.equalTo(-8)
//            make.left.equalTo(16)
//            make.width.equalTo(40)
//        }
//        
//        busketCountButton.snp.makeConstraints { (make) in
//            make.top.equalTo(8)
//            make.bottom.equalTo(-12)
//            make.right.equalTo(-16)
//            make.width.equalTo(30)
//        }
        
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(60)
            make.right.equalTo(-60)
            make.centerY.equalToSuperview()
        }
        
        borderLine.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.height.equalTo(0.7)
            make.left.right.equalToSuperview()
        }
    }
    

}
