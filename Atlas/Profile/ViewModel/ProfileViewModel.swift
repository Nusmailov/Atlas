//
//  ProfileViewModel.swift
//  Atlas
//
//  Created by Nurzhigit Smailov on 2/12/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import Foundation



class ProfileViewModel {
    weak var delegate: ProcessViewDelegate?
    var user: User?
    
    func auth() {
        var parameters = Parameters()
        parameters["device_type"] = "ios"
        parameters["device_token"] = ""
        ParseManager.shared.getRequest(url: ProfileApi.auth, parameters: parameters,
            success: { (result: User) in
                self.user = result
                self.delegate?.updateUI()
        }) { (error) in
            self.delegate?.showErrorMessage(error)
        }
    }
}
