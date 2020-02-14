//
//  CheckoutInfoView.swift
//  Atlas
//
//  Created by Nurzhigit Smailov on 2/5/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import UIKit
import DropDown

protocol SelectTypeOrderDelegate: class {
    func showHide(state: Bool)
    func changeText(text: String)
}
protocol SelectDataSendDelegate: class {
    func sendData(text: String)
}

class CheckoutInfoView: UIView {
    
    //MARK: - Properties
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.318, green: 0.361, blue: 0.435, alpha: 1)
        label.font = .getMontserraBoldFont(on: 15)
        label.text = "Способ доставки"
        return label
    }()
    lazy var dropView: DropDown = {
        let dropView = DropDown()
        dropView.direction = .bottom
        return dropView
    }()
    lazy var button: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.backgroundColor = UIColor(red: 0.973, green: 0.98, blue: 0.988, alpha: 1)
        button.addTarget(self, action: #selector(showList), for: .touchUpInside)
        button.titleLabel?.textAlignment = .left
        button.titleLabel?.font = .getMontserraRegularFont(on: 13)
        button.contentHorizontalAlignment = .left
        button.setTitleColor(UIColor(red: 0.275, green: 0.282, blue: 0.333, alpha: 1), for: .normal)
        return button
    }()
    lazy var nextImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "next")
        image.contentMode = .scaleAspectFit
        return image
    }()
    weak var delegate: SelectTypeOrderDelegate?
    weak var sendDelegate: SelectDataSendDelegate?
    
    //MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - setupViews
    func setupViews() {
        addSubviews(views: [titleLabel, button])
        dropView.anchorView = button
        DropDown.startListeningToKeyboard()
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
        }
        
        button.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.left.bottom.right.equalToSuperview()
            make.height.equalTo(45)
        }
        
        dropView.selectionAction = { [weak self] (index, item) in
            self?.button.setTitle("    \(item)", for: .normal)
            
            let checking = ChechkoutText.init(rawValue: item)
            self?.delegate?.showHide(state: checking!.showHide)
            self?.delegate?.changeText(text: checking!.text)
            self?.sendDelegate?.sendData(text: checking!.typeText)
        }
        
        button.addSubview(nextImage)
        nextImage.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalTo(-16)
            make.height.equalTo(18)
            make.width.equalTo(9)
        }
    }
    
    //MARK: - Actions
    @objc func showList() {
        dropView.show()
    }
}
