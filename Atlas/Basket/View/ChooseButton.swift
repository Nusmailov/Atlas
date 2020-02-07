//
//  ContinueButton.swift
//  InMaster
//
//  Created by Nurzhigit Smailov on 10/21/19.
//  Copyright © 2019 Nurzhigit Smailov. All rights reserved.
//

import UIKit

class ContinueButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        setTitle("Выбрать", for: .normal)
        titleLabel?.font = .getMontserraBoldFont(on: 17)
        setTitleColor(.white, for: .normal)
        backgroundColor = .mainColor
        layer.cornerRadius = 20
    }
}
