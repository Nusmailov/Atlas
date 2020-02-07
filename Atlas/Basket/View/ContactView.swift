//
//  ContactView.swift
//  Atlas
//
//  Created by Nurzhigit Smailov on 2/7/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import UIKit

class ContactView: UIView {
    //MARK: - Properties
    lazy var contactTextLabel: UILabel = {
        let label = UILabel()
        label.text = "Контакты"
        label.textColor = UIColor(red: 0.318, green: 0.361, blue: 0.435, alpha: 1)
        label.font = .getMontserraBoldFont(on: 15)
        return label
    }()
    lazy var phoneView: ContactButton = {
        let button = ContactButton()
        button.image.image = #imageLiteral(resourceName: "Contact")
        return button
    }()
    lazy var emailView: ContactButton = {
        let button = ContactButton()
        button.image.image = #imageLiteral(resourceName: "mail")
        return button
    }()
    lazy var webView: ContactButton = {
        let button = ContactButton()
        button.image.image = #imageLiteral(resourceName: "web")
        return button
    }()
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - setupViews
    func setupViews() {
        addSubviews(views: [contactTextLabel, phoneView, emailView, webView])
        contactTextLabel.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
        }
        phoneView.snp.makeConstraints { (make) in
            make.top.equalTo(contactTextLabel.snp.bottom).offset(10)
            make.left.right.equalToSuperview()
        }
        emailView.snp.makeConstraints { (make) in
            make.top.equalTo(phoneView.snp.bottom).offset(10)
            make.left.right.equalToSuperview()
        }
        webView.snp.makeConstraints { (make) in
            make.top.equalTo(emailView.snp.bottom).offset(10)
            make.bottom.left.right.equalToSuperview()
        }
    }

}
