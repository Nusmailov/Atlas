//
//  ProfileImageView.swift
//  Santo
//
//  Created by Eldor Makkambayev on 9/26/19.
//  Copyright © 2019 Eldor Makkambayev. All rights reserved.
//

import UIKit

class ProfileImageView: UIView {

    //MARK: - Properties
    lazy var titleLabel: UILabel = {
        let title = UILabel()
        title.text = "Фотография"
        title.textColor = .mainColor
        title.font = .getMullerBoldFont(on: 15)
        return title
    }()
    lazy var avatar: UIImageView = {
        let avatar = UIImageView()
        avatar.image = #imageLiteral(resourceName: "Group")
        avatar.layer.cornerRadius = 50
        avatar.layer.masksToBounds = true
        avatar.isUserInteractionEnabled = true
        
        return avatar
    }()
    lazy var downloadImageLabel: UILabel = {
        let label = UILabel()
        label.text = "Загрузите фотографию"
        label.textColor = .lightGray
        
        return label
    }()

    //MARK: - Start functions
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    
    //MARK: - Setup functions
    private func setupView() -> Void {
        addSubview(titleLabel)
        addSubview(avatar)
        addSubview(downloadImageLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(35)
            make.right.equalTo(-30)
            make.top.equalTo(20)
        }
        
        avatar.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(19)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(100)
        }
        
        downloadImageLabel.snp.makeConstraints { (make) in
            make.top.equalTo(avatar.snp.bottom).offset(20)
            make.centerX.bottom.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
