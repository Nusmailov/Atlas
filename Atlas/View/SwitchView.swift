//
//  SwitchView.swift
//  Santo
//
//  Created by Eldor Makkambayev on 9/26/19.
//  Copyright © 2019 Eldor Makkambayev. All rights reserved.
//

import Foundation
import UIKit

enum Side {
    case left
    case right
}

class SwtchView: UIView {
    
    //MARK: - Properties
    var selectLeftSide: (()->())?
    var selectRightSide: (()->())?

    private var side: Side = .left{
        didSet {
            setupSwitcherColor()
        }
    }
    lazy var leftLabel: UILabel = {
        let leftLabel = UILabel()
        leftLabel.text = "left"
        leftLabel.font = UIFont.getMullerBoldFont(on: 13)
        leftLabel.textAlignment = .center
        
        return leftLabel
    }()
    lazy var rightLabel: UILabel = {
        let rightLabel = UILabel()
        rightLabel.text = "right"
        rightLabel.font = UIFont.getMullerBoldFont(on: 13)
        rightLabel.textAlignment = .center
        
        return rightLabel
    }()
    lazy var leftButton: UIButton = {
        let leftButton = UIButton()
        leftButton.round(corners: [.topLeft, .bottomLeft], radius: 20)
        leftButton.tag = 0
        leftButton.backgroundColor = .clear
        leftButton.layer.masksToBounds = true
        
        return leftButton
    }()
    lazy var rightButton: UIButton = {
        let rightButton = UIButton()
        rightButton.round(corners: [.topLeft, .bottomLeft], radius: 20)
        rightButton.tag = 1
        rightButton.backgroundColor = .clear
        rightButton.layer.masksToBounds = true
        
        return rightButton
    }()

    //MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
        setupAction()
        setupSwitcherColor()
    }
    
    //MARK: - Setup functions
    private func setupView() -> Void  {
        layer.borderColor = UIColor.mainColor.cgColor
        layer.borderWidth = 1
        backgroundColor = .white
        layer.masksToBounds = true

        addSubview(leftLabel)
        leftLabel.snp.makeConstraints { (make) in
            make.top.bottom.left.equalToSuperview()
            make.right.equalTo(snp.centerX)
        }
        addSubview(rightLabel)
        rightLabel.snp.makeConstraints { (make) in
            make.top.bottom.right.equalToSuperview()
            make.left.equalTo(snp.centerX)
        }
        addSubview(leftButton)
        leftButton.snp.makeConstraints { (make) in
            make.top.bottom.left.equalToSuperview()
            make.right.equalTo(snp.centerX)
        }
        addSubview(rightButton)
        rightButton.snp.makeConstraints { (make) in
            make.top.bottom.right.equalToSuperview()
            make.left.equalTo(snp.centerX)
        }
    }
    
    private func setupSwitcherColor() -> Void {
        leftLabel.backgroundColor = (self.side == .left) ? .mainColor : .white
        rightLabel.backgroundColor = (self.side == .right) ? .mainColor : .white
        leftLabel.textColor = (self.side == .left) ? .white : .black
        rightLabel.textColor = (self.side == .right) ? .white : .black
    }
    
    private func setupAction() -> Void {
        leftButton.addTarget(self, action: #selector(sideButtonAction(_:)), for: .touchUpInside)
        rightButton.addTarget(self, action: #selector(sideButtonAction(_:)), for: .touchUpInside)
    }
    
    //MARK: - Objective functions
    @objc func sideButtonAction(_ sender: UIButton) -> Void {
        side = (sender.tag == 0) ? .left : .right
        sender.tag == 0 ? selectLeftSide?(): selectRightSide?()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
