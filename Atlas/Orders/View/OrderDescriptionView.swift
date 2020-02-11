//
//  OrderDescriptionView.swift
//  Delivery
//
//  Created by Nurzhigit Smailov on 8/22/19.
//  Copyright © 2019 Nurzhigit Smailov. All rights reserved.
//

import UIKit

class OrderDescriptionView: UIView {
    // MARK: - Properties
    lazy var label:(String) -> UILabel = { value in
        let label = UILabel()
        label.text = value
        label.font = .getMontserraBoldFont(on: 15)
        label.textColor = UIColor(red: 0.318, green: 0.361, blue: 0.435, alpha: 1)
        return label
    }
    func view() -> UIView {
        let view = UIView()
        view.backgroundColor = .whiteBlue
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1
        view.layer.borderColor = #colorLiteral(red: 0.9411764706, green: 0.9490196078, blue: 0.9568627451, alpha: 1)
        return view
    }
    lazy var mainView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.backgroundColor = .white
        return view
    }()
    lazy var dateOrderLabel: UILabel = {
        let label = UILabel()
        label.text = "Статус: Доставлено 24.05.19"
        label.font = .getMontserraRegularFont(on: 13)
        label.textColor = UIColor(red: 0.275, green: 0.282, blue: 0.333, alpha: 1)
        
        return label
    }()
    lazy var typeOrderLabel: UILabel = {
        let label = UILabel()
        label.text = "Алматы, пр-т Абая 2, кв 39"
        label.font = .getMontserraRegularFont(on: 13)
        label.textColor = UIColor(red: 0.275, green: 0.282, blue: 0.333, alpha: 1)
        return label
    }()
    lazy var paymentTypeOrderLabel: UILabel = {
        let label = UILabel()
        label.text = "Наличными"
        label.font = .getMontserraRegularFont(on: 13)
        label.textColor = UIColor(red: 0.275, green: 0.282, blue: 0.333, alpha: 1)
        return label
    }()
    lazy var overAllPriceOrderLabel: UILabel = {
        let label = UILabel()
        label.font = .getMontserraRegularFont(on: 13)
        label.textColor = UIColor(red: 0.275, green: 0.282, blue: 0.333, alpha: 1)
        label.text = "10000"
        return label
    }()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - SetupViews
    func setupViews() {
        addSubview(mainView)
        
        mainView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        mainView.backgroundColor = .white
        let dateLabel: UILabel = {
            let label = UILabel()
            label.text = "Статус"
            label.font = .getMontserraBoldFont(on: 15)
            return label
        }()
        let typeLabel: UILabel = {
            let label = UILabel()
            label.text = "Тип заказа"
            label.font = .getMontserraBoldFont(on: 15)
            return label
        }()
        let paymentTypeLabel: UILabel = {
            let label = UILabel()
            label.text = "Оплата"
            label.font = .getMontserraBoldFont(on: 15)
            return label
        }()
        let overAllPriceLabel: UILabel = {
            let label = UILabel()
            label.text = "Итого"
            label.font = .getMontserraBoldFont(on: 15)
            return label
        }()
        let productsLabel: UILabel = {
            let label = UILabel()
            label.text = "Товары"
            label.font = .getMontserraBoldFont(on: 15)
            return label
        }()
        
        let dateView = view()
        let typeView = view()
        let paymentView = view()
        let overAllPriceView = view()
        
        mainView.addSubview(dateLabel)
        mainView.addSubview(typeLabel)
        mainView.addSubview(paymentTypeLabel)
        mainView.addSubview(overAllPriceLabel)
        
        mainView.addSubview(dateView)
        mainView.addSubview(typeView)
        mainView.addSubview(paymentView)
        mainView.addSubview(overAllPriceView)
        mainView.addSubview(productsLabel)
        
        dateLabel.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        
        dateView.snp.makeConstraints { (make) in
            make.top.equalTo(dateLabel.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        
        dateView.addSubview(dateOrderLabel)
        
        dateOrderLabel.snp.makeConstraints { (make) in
            make.top.leading.equalToSuperview().offset(16)
            make.bottom.right.equalToSuperview().offset(-16)
        }
        
        //address
        typeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(dateView.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        
        typeView.snp.makeConstraints { (make) in
            make.top.equalTo(typeLabel.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        
        typeView.addSubview(typeOrderLabel)
        
        typeOrderLabel.snp.makeConstraints { (make) in
            make.top.leading.equalToSuperview().offset(16)
            make.bottom.right.equalToSuperview().offset(-16)
        }
        
        // PAYMENT
        paymentTypeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(typeView.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        
        paymentView.snp.makeConstraints { (make) in
            make.top.equalTo(paymentTypeLabel.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        
        paymentView.addSubview(paymentTypeOrderLabel)
        
        paymentTypeOrderLabel.snp.makeConstraints { (make) in
            make.top.leading.equalToSuperview().offset(16)
            make.bottom.right.equalToSuperview().offset(-16)
        }
        
        // Overall price
        overAllPriceLabel.snp.makeConstraints { (make) in
            make.top.equalTo(paymentView.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        
        overAllPriceView.snp.makeConstraints { (make) in
            make.top.equalTo(overAllPriceLabel.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            
        }
        
        overAllPriceView.addSubview(overAllPriceOrderLabel)
        
        overAllPriceOrderLabel.snp.makeConstraints { (make) in
            make.top.leading.equalToSuperview().offset(16)
            make.bottom.right.equalToSuperview().offset(-16)
        }
        
        productsLabel.snp.makeConstraints { (make) in
            make.top.equalTo(overAllPriceView.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(16)
            make.right.bottom.equalToSuperview().offset(-16)
        }
    }
    
}
