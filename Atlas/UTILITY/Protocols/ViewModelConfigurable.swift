//
//  ViewModelConfigurable.swift
//  JTI
//
//  Created by Nursultan on 10/17/19.
//  Copyright © 2019 Nursultan. All rights reserved.
//

import Foundation

protocol ViewModelConfigurable {
    var errorMessage: String {get set}
    var parameters: Parameters {get set}
    func getParameters() -> Parameters?
    func isValid() -> Bool
}
