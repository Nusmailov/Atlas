//
//  ConfidantionLabelTopLineView.swift
//  Santo
//
//  Created by Eldor Makkambayev on 9/24/19.
//  Copyright © 2019 Eldor Makkambayev. All rights reserved.
//

import UIKit

class ConfidantionLabelTopLineView: UIView {
    
    //MARK: - Properties
    lazy var line: UIView = {
        var line = UIView()
        line.backgroundColor = .mainColor
        
        return line
    }()
    lazy var line1: UIView = {
        var line = UIView()
        line.backgroundColor = .mainColor
        
        return line
    }()

    //MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    //MARK: - Setup functions
    private func setupView() -> Void {
        addSubview(line1)
        line1.snp.makeConstraints { (make) in
            make.left.equalTo(37)
            make.top.bottom.equalToSuperview()
            make.right.equalTo(snp.centerX).offset(-18)
            make.height.equalTo(1)
        }
        
        addSubview(line)
        line.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-37)
            make.top.bottom.equalToSuperview()
            make.height.equalTo(1)
            make.left.equalTo(snp.centerX).offset(18)
        }

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
