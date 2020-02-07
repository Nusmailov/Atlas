//
//  AddressView.swift
//  Atlas
//
//  Created by Nurzhigit Smailov on 2/7/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import UIKit

class AddressView: UIView {
    //MARK: - Properties
    lazy var addressTextLabel: UILabel = {
        let label = UILabel()
        label.text = "От куда забрать:"
        label.textColor = UIColor(red: 0.771, green: 0.771, blue: 0.771, alpha: 1)
        label.font = .getMontserraRegularFont(on: 12)
        return label
    }()
    lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.text = "г.Астана, Алматинский район, Ул.Акжол 22а, офис 411"
        label.textColor = UIColor(red: 0.318, green: 0.361, blue: 0.435, alpha: 1)
        label.font = .getMontserraRegularFont(on: 13)
        label.numberOfLines = 0
        return label
    }()
    lazy var mapTextLabel: UILabel = {
        let label = UILabel()
        label.text = "Мы на карте"
        label.textColor = UIColor(red: 0.318, green: 0.361, blue: 0.435, alpha: 1)
        label.font = .getMontserraBoldFont(on: 15)
        return label
    }()
    lazy var mapView: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        view.layer.cornerRadius = 10
        return view
    }()
    
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
        addSubviews(views: [addressTextLabel, addressLabel, mapTextLabel, mapView])
        
        addressTextLabel.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
        }
        
        addressLabel.snp.makeConstraints { (make) in
            make.top.equalTo(addressTextLabel.snp.bottom).offset(8)
            make.left.right.equalToSuperview()
        }
        
        mapTextLabel.snp.makeConstraints { (make) in
            make.top.equalTo(addressLabel.snp.bottom).offset(16)
            make.left.right.equalToSuperview()
        }
        
        mapView.snp.makeConstraints { (make) in
            make.top.equalTo(mapTextLabel.snp.bottom).offset(12)
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(200)
        }
    }
}
