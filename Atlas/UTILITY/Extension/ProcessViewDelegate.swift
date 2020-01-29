//
//  ProcessViewDelegate.swift
//  Atlas
//
//  Created by Nurzhigit Smailov on 1/29/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import Foundation


protocol ProcessViewDelegate: class {
    func updateUI()
    func showErrorMessage(_ message: String)
    func showSuccess(_ message: String)
    func showLoader()
    func hideLoader()
}
