//
//  LoginLogoView.swift
//  Atlas
//
//  Created by Eldor Makkambayev on 11/20/19.
//  Copyright © 2019 Eldor Makkambayev. All rights reserved.
//

import UIKit

class LoginLogoView: UIView {

    //MARK: - Properties

    lazy var logoImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.image = UIImage.init(named: "main")
        
        return image
    }()
    lazy var logoTitleImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.image = UIImage.init(named: "textmain")
        
        return image
    }()
    
    //MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    //MARK: - Setup functions
    private func setupView() -> Void {
        addSubview(logoImage)
        logoImage.snp.makeConstraints { (make) in
            make.top.equalTo(20)
            make.left.equalTo(16)
            make.right.equalTo(-16)
            make.height.width.equalTo(250)
            make.bottom.centerX.equalToSuperview()
        }
//        addSubview(logoTitleImage)
//        logoTitleImage.snp.makeConstraints { (make) in
//            make.bottom.centerX.width.equalToSuperview()
//            make.top.equalTo(logoImage.snp.bottom).offset(15)
//        }
    }
    
    //    MARK: - Simple functions
    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
