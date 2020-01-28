//
//  LoginControllerConstraintConfiguration.swift
//  Santo
//
//  Created by Eldor Makkambayev on 9/26/19.
//  Copyright © 2019 Eldor Makkambayev. All rights reserved.
//

import Foundation
import  UIKit
class LoginControllerConstaintConfiguration {
    
    //Setup constraints for LoginViewController()
    
    static let shared = LoginControllerConstaintConfiguration()
    
    func setupView(_ controller: LoginViewController) -> Void {
        controller.scrollView.addSubview(controller.logoView)
        controller.logoView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
        }
        controller.scrollView.addSubview(controller.autorizationInputView)
        controller.autorizationInputView.snp.makeConstraints { (make) in
            make.top.equalTo(controller.logoView.snp.bottom).offset(80)
            make.width.equalToSuperview()
        }
        controller.scrollView.addSubview(controller.signInEventsView)
        controller.signInEventsView.snp.makeConstraints { (make) in
            make.top.equalTo(controller.autorizationInputView.snp.bottom).offset(11)
            make.left.right.centerX.equalToSuperview()
        }
        controller.scrollView.addSubview(controller.confButton)
        controller.confButton.snp.makeConstraints { (make) in
            make.top.equalTo(controller.signInEventsView.snp.bottom).offset(25)
            make.centerX.equalToSuperview()
//            make.height.equalTo(100)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-50)
        }
    }
}
