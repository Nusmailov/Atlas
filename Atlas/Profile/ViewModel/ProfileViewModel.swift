//
//  ProfileViewModel.swift
//  Atlas
//
//  Created by Nurzhigit Smailov on 2/12/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import Foundation

protocol SignOutDelegate: class {
    func signOut()
}

class ProfileViewModel {
    weak var delegate: ProcessViewDelegate?
    weak var signOutDelegate: SignOutDelegate?
    var user: User?
    
    func auth() {
        var parameters = Parameters()
        parameters["device_type"] = "ios"
        parameters["device_token"] = AppDelegate.deviceToken
        ParseManager.shared.getRequest(url: ProfileApi.auth, parameters: parameters,
            success: { (result: User) in
                self.user = result
                self.delegate?.updateUI()
        }) { (error) in
            self.delegate?.showErrorMessage(error)
        }
    }
    
    func editUser(parameters: Parameters) {
        ParseManager.shared.postRequest(url: ProfileApi.editUser, parameters: parameters, success: {
            (result: User) in
            self.user = result
            try? UserManager.createSessionWithUser(UserModel.init(user: result))    
            self.delegate?.updateUI()
        }) { (error) in
            self.delegate?.showErrorMessage(error)
        }
    }
    
    func userPhoto(parameters: Parameters) {
        ParseManager.shared.multipartFormData(url: ProfileApi.photo, parameters: parameters, success: {
            (result: User) in
            self.user = result
            self.delegate?.updateUI()
        }) { (error) in
            self.delegate?.showErrorMessage(error)
        }
    }
    
    func signOut() {
        ParseManager.shared.postRequest(url: ProfileApi.signOut, success: {
            (result: User) in
            self.signOutDelegate?.signOut()
        }) { (error) in
            self.delegate?.showErrorMessage(error)
        }
    }
}
