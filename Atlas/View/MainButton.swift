//
//  MainButton.swift
//  Santo
//
//  Created by Eldor Makkambayev on 9/26/19.
//  Copyright © 2019 Eldor Makkambayev. All rights reserved.
//

import Foundation
import UIKit

class MainButton: UIView {
    
    //MARK: - Properties
    var title: String
    lazy var mainButton: UIButton = {
        var sib = UIButton()
        sib.setTitle(title, for: .normal)
        sib.titleLabel?.font = .getMullerBoldFont(on: 17)
        sib.tintColor = .white
        sib.backgroundColor = .mainColor
        sib.layer.cornerRadius = 25
        
        return sib
    }()
    
    //MARK: - Initialization
    init(title: String) {
        self.title = title
        super.init(frame: .zero)
        setupView()
    }
    
    //MARK: - Setup functions
    private func setupView() -> Void {
        addSubview(mainButton)
        mainButton.snp.makeConstraints { (make) in
            make.right.left.bottom.top.equalToSuperview()
            make.height.equalTo(50)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
