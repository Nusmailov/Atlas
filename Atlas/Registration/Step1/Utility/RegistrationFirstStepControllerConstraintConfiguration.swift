//
//  RegistrationControllerConstraintConfiguration.swift
//  Santo
//
//  Created by Eldor Makkambayev on 9/26/19.
//  Copyright © 2019 Eldor Makkambayev. All rights reserved.
//

import Foundation
class RegistrationFirstStepControllerConstraintConfiguration {
    
    //Setup constrants for RegistrrationViewController()
    
    static let shared = RegistrationFirstStepControllerConstraintConfiguration()
    
    func setupView(_ controller: RegistrationViewController) -> Void {
        controller.navigationController?.navigationBar.barTintColor = .white
        controller.navigationController?.navigationBar.isHidden = false
        controller.navigationItem.rightBarButtonItem = controller.rightBarLabel
        controller.title = "Регистрация"

        controller.scrollView.addSubview(controller.avatarView)
        controller.avatarView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.right.centerX.equalToSuperview()
        }
        controller.scrollView.addSubview(controller.switcherView)
        controller.switcherView.snp.makeConstraints { (make) in
            make.top.equalTo(controller.avatarView.snp.bottom).offset(43)
            make.centerX.left.right.equalToSuperview()
        }

        controller.scrollView.addSubview(controller.registrationInputView)
        controller.registrationInputView.snp.makeConstraints { (make) in
            make.top.equalTo(controller.switcherView.snp.bottom).offset(15)
            make.centerX.left.right.equalToSuperview()
        }
        controller.scrollView.addSubview(controller.policyCondition)
        controller.policyCondition.snp.makeConstraints { (make) in
            make.top.equalTo(controller.registrationInputView.snp.bottom).offset(15)
            make.left.right.centerX.equalToSuperview()
        }
        controller.scrollView.addSubview(controller.nextButton)
        controller.nextButton.snp.makeConstraints { (make) in
            make.top.equalTo(controller.policyCondition.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.bottom.equalToSuperview().offset(-40)

        }

    }
}
