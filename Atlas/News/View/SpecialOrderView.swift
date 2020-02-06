//
//  SpecialOrderView.swift
//  Delivery
//
//  Created by Nurzhigit Smailov on 8/20/19.
//  Copyright © 2019 Nurzhigit Smailov. All rights reserved.
//

import UIKit

protocol SpecialOrderDelegate: class {
    func didOpenSpecialOrderVC()
}

class SpecialOrderView: UIView {
    // MARK: - Properties
    lazy var specialLabel: UILabel = {
        let label = UILabel()
        label.text = "special"
        label.font = .getMullerBoldFont(on: 26)// UIFont(name: Font.GTWalsheimBold, size: 26)
        label.textColor = #colorLiteral(red: 0.3176470588, green: 0.3607843137, blue: 0.4352941176, alpha: 1)
        label.numberOfLines = 0
        return label
    }()
    lazy var specialImage: UIImageView = {
        let image = UIImageView()
//        image.image = UIImage(named: MediaType.specialOrder)
        return image
    }()
    lazy var mainView: UIView  = {
        let view = UIView()
        view.layer.cornerRadius = 10.0
        view.layer.masksToBounds = true
        view.backgroundColor = .white
        return view
    }()
    lazy var findQuestionLabel: UILabel = {
        let label = UILabel()
        label.text = "notFound"
        label.font = .getMullerBoldFont(on: 20)
        label.textColor = #colorLiteral(red: 0.3176470588, green: 0.3607843137, blue: 0.4352941176, alpha: 1)
        label.numberOfLines = 0
        return label
    }()
    lazy var textLabel: UILabel = {
        let label = UILabel()
        label.text = "specialText"
        label.font = .getMullerRegularFont(on: 16)
        label.textColor = #colorLiteral(red: 0.3176470588, green: 0.3607843137, blue: 0.4352941176, alpha: 1)
        label.numberOfLines = 0
        return label
    }()
    lazy var orderButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(openOrderViewCotroller), for: .touchUpInside)
        button.setTitle("order", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.1647058824, green: 0.5960784314, blue: 1, alpha: 1)
        button.layer.cornerRadius = 10
        button.titleLabel?.font = .getMullerBoldFont(on: 18)
        return button
    }()
    lazy var yourNumberLabel: UILabel = {
        let label = UILabel()
        label.font = .getMullerRegularFont(on: 18)
        label.textColor = #colorLiteral(red: 0.3176470588, green: 0.3607843137, blue: 0.4352941176, alpha: 1)
        label.numberOfLines = 0
//        guard let phone = UserManager.getCurrentUser()?.result.phone else { return label }
        label.text = "\("yourPhone")\n  +7 \(0000000000)"
        return label
    }()
    
    public weak var openDelegate: SpecialOrderDelegate?
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        backgroundColor = .white
        layer.cornerRadius = 10
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - SetupViews
    func setupViews() {
       
        addSubview(specialLabel)
        addSubview(specialImage)
        addSubview(findQuestionLabel)
        addSubview(textLabel)
        addSubview(orderButton)
        addSubview(yourNumberLabel)
        specialLabel.snp.makeConstraints { (make) in
            make.leading.top.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        specialImage.snp.makeConstraints { (make) in
            make.top.equalTo(specialLabel.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(130)
        }
        findQuestionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(specialImage.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        textLabel.snp.makeConstraints { (make) in
            make.top.equalTo(findQuestionLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        yourNumberLabel.snp.makeConstraints { (make) in
            make.top.equalTo(textLabel.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        orderButton.snp.makeConstraints { (make) in
            make.top.equalTo(yourNumberLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(60)
            make.bottom.equalToSuperview().offset(-16)
        }
    }
    // MARK: - Actions
    @objc func openOrderViewCotroller() {
        openDelegate?.didOpenSpecialOrderVC()
    }
}
