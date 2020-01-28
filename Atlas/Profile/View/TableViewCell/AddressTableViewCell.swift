//
//  AddressTableViewCell.swift
//  Delivery
//
//  Created by Nurzhigit Smailov on 8/26/19.
//  Copyright © 2019 Nurzhigit Smailov. All rights reserved.
//

import UIKit

class AddressTableViewCell: UITableViewCell {
    
    lazy var mainView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 9
        view.backgroundColor = UIColor(red: 0.973, green: 0.98, blue: 0.988, alpha: 1)
        
        return view
    }()
    lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "Trash"), for: .normal)
        button.tintColor = #colorLiteral(red: 1, green: 0.2901960784, blue: 0.2901960784, alpha: 1)
        button.addTarget(self, action: #selector(removeAddress), for: .touchUpInside)
        return button
    }()
    lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.font = .getMullerRegularFont(on: 14)
        label.numberOfLines = 0
        label.textColor = #colorLiteral(red: 0.275, green: 0.282, blue: 0.333, alpha: 1)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        backgroundColor = .white
        selectionStyle = .none
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Setupviews
    func setupViews() {
        addSubview(deleteButton)
        addSubview(mainView)
        mainView.addSubview(addressLabel)
        selectionStyle = .none
        deleteButton.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(8)
            make.bottom.equalToSuperview().offset(-8)
            make.right.equalToSuperview().offset(-16)
            make.width.equalTo(25)
        }
        
        mainView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(2)
            make.left.equalTo(16)
            make.right.equalTo(deleteButton.snp.left).offset(-8)
            make.bottom.equalToSuperview().offset(-2)
        }
        
        addressLabel.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().offset(16)
            make.bottom.right.equalToSuperview().offset(-16)
        }
    }

    
    @objc func removeAddress() {
        
    }
}
