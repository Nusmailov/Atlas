//
//  SpecialAgreeView.swift
//  Delivery
//
//  Created by Nurzhigit Smailov on 10/17/19.
//  Copyright © 2019 Nurzhigit Smailov. All rights reserved.
//

import UIKit

protocol SpecialAgreeDelegate: class {
    func agreeSpecial()
    func cancelSpecial()
}

class SpecialAgreeView: UIView {
    
    // MARK: - Properties
    lazy var agreeButton: UIButton = {
        let button = UIButton()
        button.setTitle("agree", for: .normal)
        button.titleLabel?.font = .getMullerBoldFont(on: 18)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.1647058824, green: 0.5960784314, blue: 1, alpha: 1)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(agree), for: .touchUpInside)
        return button
    }()
    lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("cancel", for: .normal)
        button.titleLabel?.font = .getMullerBoldFont(on: 18)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .red
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        return button
    }()
    lazy var mainView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.backgroundColor = .white
        return view
    }()
    var delegate: SpecialAgreeDelegate?
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - SetupViews
    func setupViews() {
        addSubview(mainView)
        mainView.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().offset(8)
            make.bottom.right.equalToSuperview().offset(-8)
        }
        mainView.addSubview(agreeButton)
        mainView.addSubview(cancelButton)
        
        agreeButton.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(8)
            make.right.equalToSuperview().offset(-8)
            make.height.equalTo(50)
        }
        cancelButton.snp.makeConstraints { (make) in
            make.top.equalTo(agreeButton.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(8)
            make.bottom.right.equalToSuperview().offset(-8)
            make.height.equalTo(50)
        }
    }
    
    // MARK: - Actions
    @objc func agree() {
        delegate?.agreeSpecial()
    }
    
    @objc func cancel() {
        delegate?.cancelSpecial()
    }
}
