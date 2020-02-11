//
//  PrivacyPolicyViewModel.swift
//  Atlas
//
//  Created by Nurzhigit Smailov on 2/11/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import Foundation



class PrivacyPolicyViewModel {
    weak var delegate: ProcessViewDelegate?
    var text = ""
    
    func getInfo(column: String) {
        self.delegate?.showLoader()
        ParseManager.shared.getRequest(url: ContactApi.views,parameters: ["column": column],
            success: { (result: String) in
            self.text = result
            self.delegate?.hideLoader()
            self.delegate?.updateUI()
        }) { (error) in
            self.delegate?.showErrorMessage(error)
        }
    }

}
