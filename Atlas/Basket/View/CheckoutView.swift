//
//  CheckoutView.swift
//  Atlas
//
//  Created by Nurzhigit Smailov on 2/5/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import UIKit

class CheckoutView: UIView {
    
    //MARK: - Properties
    lazy var paymentType: CheckoutInfoView = {
        let view = CheckoutInfoView()
        view.dropView.dataSource = ["Самовывоз"]
        return view
    }()
    lazy var typeOrderView: CheckoutInfoView = {
        let view = CheckoutInfoView()
        view.dropView.dataSource = ["Предзаказ", "Бронирование", "Заказ с хранением", "Обычный заказ"]
        view.titleLabel.text = "Тип заказа"
        view.button.setTitle("    Обычный заказ", for: .normal)
        view.delegate = self
        return view
    }()
    lazy var dateSelectView: CheckoutInfoView = {
        let view = CheckoutInfoView()
        view.titleLabel.text = "Дата подготовки заказа"
        return view
    }()
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Обычный заказ - после Оформления заказа, необходимо провести оплату и организовать самовывоз."
        label.textColor = UIColor(red: 0.318, green: 0.361, blue: 0.435, alpha: 1)
        label.font = .getMontserraRegularFont(on: 13)
        label.numberOfLines = 0
        return label
    }()
    lazy var addressView: AddressView = {
        let view = AddressView()
        return view
    }()
    lazy var contactView: ContactView = {
        let view = ContactView()
        return view
    }()
    lazy var totalTextLabel: UILabel = {
        let label = UILabel()
        label.text = "Итого:"
        label.textColor = UIColor(red: 0.318, green: 0.361, blue: 0.435, alpha: 1)
        label.font = .getMontserraBoldFont(on: 15)
        return label
    }()
    lazy var totalPriceLabel: UILabel = {
        let label = UILabel()
        label.text = "20 000 тенге"
        label.textColor = UIColor(red: 0.318, green: 0.361, blue: 0.435, alpha: 1)
        label.font = .getMontserraBoldFont(on: 18)
        return label
    }()
    lazy var realizeButton: ContinueButton = {
        let button = ContinueButton()
        button.layer.cornerRadius = 10
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
    
    //MARK: - SetupViews
    func setupViews() {
        addSubviews(views: [paymentType, typeOrderView, addressView, descriptionLabel,
                            dateSelectView, contactView, totalTextLabel, totalPriceLabel,
                            realizeButton])
        paymentType.snp.makeConstraints { (make) in
            make.top.left.equalTo(16)
            make.right.equalTo(-16)
        }
        typeOrderView.snp.makeConstraints { (make) in
            make.top.equalTo(paymentType.snp.bottom).offset(16)
            make.left.equalTo(16)
            make.right.equalTo(-16)
        }
        descriptionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(typeOrderView.snp.bottom).offset(16)
            make.left.equalTo(16)
            make.right.equalTo(-16)
        }
        dateSelectView.snp.makeConstraints { (make) in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(16)
            make.left.equalTo(16)
            make.right.equalTo(-16)
        }
        addressView.snp.makeConstraints { (make) in
            make.top.equalTo(dateSelectView.snp.bottom).offset(16)
            make.left.equalTo(16)
            make.right.equalTo(-16)
        }
        contactView.snp.makeConstraints { (make) in
            make.top.equalTo(addressView.snp.bottom).offset(16)
            make.left.equalTo(16)
            make.right.equalTo(-16)
        }
        totalTextLabel.snp.makeConstraints { (make) in
            make.top.equalTo(contactView.snp.bottom).offset(16)
            make.left.equalTo(16)
            make.right.equalTo(-16)
        }
        totalPriceLabel.snp.makeConstraints { (make) in
            make.top.equalTo(totalTextLabel.snp.bottom).offset(4)
            make.left.equalTo(16)
            make.right.equalTo(-16)
        }
        realizeButton.snp.makeConstraints { (make) in
            make.top.equalTo(totalPriceLabel.snp.bottom).offset(16)
            make.left.equalTo(16)
            make.height.equalTo(60)
            make.right.bottom.equalTo(-16)
        }
        
    }
}

//MARK: - SelectTypeOrderDelegate
extension CheckoutView: SelectTypeOrderDelegate {
    func showHide(state: Bool) {
        if state {
            UIView.animate(withDuration: .init(floatLiteral: 0.5)) {
                self.dateSelectView.alpha = 1
                self.dateSelectView.snp.remakeConstraints { (make) in
                    make.top.equalTo(self.descriptionLabel.snp.bottom).offset(16)
                    make.left.equalTo(16)
                    make.right.equalTo(-16)
                }
                self.addressView.snp.remakeConstraints { (make) in
                    make.top.equalTo(self.dateSelectView.snp.bottom).offset(16)
                    make.left.equalTo(16)
                    make.right.equalTo(-16)
                }
            }
        } else {
            UIView.animate(withDuration: .init(floatLiteral: 0.5)) {
                self.dateSelectView.alpha = 0
                self.addressView.snp.remakeConstraints { (make) in
                    make.top.equalTo(self.descriptionLabel.snp.bottom).offset(16)
                    make.left.equalTo(16)
                    make.right.equalTo(-16)
                }
            }
        }
    }
    
    func changeText(text: String) {
        descriptionLabel.text = text
    }
}
