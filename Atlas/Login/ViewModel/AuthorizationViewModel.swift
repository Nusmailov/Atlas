//
//  AuthorizationViewModel.swift
//  JTI
//
//  Created by Nursultan on 10/17/19.
//  Copyright © 2019 Nursultan. All rights reserved.
//

import Foundation

class AuthorizationViewModel: ViewModelConfigurable {
    var errorMessage: String = "Заполните поля"
    var parameters: Parameters = [:]

    private var phone: String = String()
    private var password: String = String()

    func setPhone(_ phone: String) -> Void {
        let text = phone
        let phoneNumber = String(text.suffix(text.count-2)).replacingOccurrences(of: " ", with: "")
        self.phone = "8\(phoneNumber)"
    }
    
    func setPassword(_ password: String) -> Void {
        self.password = password
    }

    func isValid() -> Bool {
        guard phone != "" else { errorMessage = "Заполните номер телефона"; return false}
        return true
    }

    func getParameters() -> Parameters? {
        guard isValid() else {return nil}
        parameters["tel"] = phone
        parameters["password"] = password
        parameters["device_type"] = "ios"
        parameters["device_token"] = AppDelegate.deviceToken
        return parameters
    }

}

