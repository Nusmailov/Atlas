//
//  BasketTableViewCell.swift
//  Atlas
//
//  Created by Eldor Makkambayev on 1/7/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import UIKit
import SDWebImage

protocol DeleteBasketDelegate: class {
    func deleteProductBasket(product_id: Int, index: Int)
}

protocol ChangedBasketCountDelegate: class {
    func changedBasketCount(index: Int, count: Int)
}

class BasketTableViewCell: UITableViewCell {
    
    //MARK: - Properties
    lazy var backView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.973, green: 0.98, blue: 0.988, alpha: 1)
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var productImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.image = #imageLiteral(resourceName: "plitka 1")
        return image
    }()

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.267, green: 0.267, blue: 0.267, alpha: 1)
        label.text = "Клинкер «Амстердам» универсальный"
        label.font = .getMullerBoldFont(on: 13)
        label.numberOfLines = 2
        return label
    }()
    
    lazy var volumeLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.667, green: 0.667, blue: 0.667, alpha: 1)
        label.text = "29.8х29.8 см 1.33 м2"
        label.font = .getMullerRegularFont(on: 10)
        return label
    }()
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.173, green: 0.184, blue: 0.2, alpha: 0.8)
        label.text = "Повседневная практика показывает, что постоянный количественный Повседневная практика показывает, что постоянный количественный"
        label.font = .getMullerRegularFont(on: 11)
        label.numberOfLines = 2
        return label
    }()
    lazy var priceView: ProductCharacteristicView = {
        let view = ProductCharacteristicView()
        view.titleLabel.text = "Цена: "
        view.valueTextField.text = "20 000 ₸ м2"
        view.valueTextField.isEnabled = false
        return view
    }()
    lazy var countView: ProductCharacteristicView = {
        let view = ProductCharacteristicView()
        view.titleLabel.text = "Шт: "
        view.valueTextField.text = "2"
        view.valueTextField.keyboardType = .numberPad
        view.valueTextField.delegate =  self
        return view
    }()
    lazy var volumeView: ProductCharacteristicView = {
        let view = ProductCharacteristicView()
        view.titleLabel.text = "м2: "
        view.valueTextField.text = "2,66"
        view.valueTextField.isEnabled = false
        return view
    }()
    lazy var deleteBackView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.03)
        view.layer.cornerRadius = 4
        return view
    }()
    lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "Trash"), for: .normal)
        button.addTarget(self, action: #selector(deleteBasket), for: .touchUpInside)
        return button
    }()
    var basketProduct: BasketProduct! {
        didSet {
            priceView.valueTextField.text = "\(basketProduct.product.product_price) ₸ м2"
            countView.valueTextField.text = "\(basketProduct.product_quantity)"
            volumeView.valueTextField.text = "\(basketProduct.area)"
            descriptionLabel.text = basketProduct.product.product_description
            titleLabel.text = basketProduct.product.product_name
            volumeLabel.text = "\(basketProduct.product.product_length)x\(basketProduct.product.product_width) м2"
            
            if !basketProduct.product.images.isEmpty {
                productImage.sd_imageIndicator = SDWebImageActivityIndicator.gray
                productImage.sd_setImage(with: Product.getImageUrl(url: basketProduct.product.images[0].image_path))
            }
        }
    }
    weak var delegate: DeleteBasketDelegate?
    weak var coundDelegate: ChangedBasketCountDelegate?
    var index: Int!
    
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupView()
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setBasketProduct(basketProduct: BasketProduct) {
        self.basketProduct = basketProduct
    }
    
    private func setupView() -> Void {
        addSubview(backView)
        backView.snp.makeConstraints { (make) in
            make.top.equalTo(4)
            make.left.equalTo(16)
            make.right.equalTo(-16)
            make.bottom.equalTo(-4)
        }
        
        backView.addSubview(productImage)
        productImage.snp.makeConstraints { (make) in
            make.left.equalTo(8)
            make.top.equalTo(12)
            make.height.equalTo(74)
            make.width.equalTo(100)
        }
        
        backView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(productImage.snp.right).offset(8)
            make.top.equalTo(productImage)
            make.right.equalTo(-8)
        }
        
        backView.addSubview(volumeLabel)
        volumeLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
        }
        
        backView.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(volumeLabel.snp.bottom).offset(4)
            make.left.right.equalTo(titleLabel)
        }
        
        backView.addSubview(deleteBackView)
        deleteBackView.snp.makeConstraints { (make) in
            make.right.equalTo(titleLabel)
            make.bottom.equalTo(-12)
            make.height.equalTo(33)
            make.width.equalTo(40)
        }
        
        deleteBackView.addSubview(deleteButton)
        deleteButton.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.height.width.equalTo(20)
        }
        
        backView.addSubview(volumeView)
        volumeView.snp.makeConstraints { (make) in
            make.bottom.equalTo(deleteBackView)
            make.top.equalTo(productImage.snp.bottom).offset(8)
            make.right.equalTo(deleteBackView.snp.left).offset(-8)
            make.width.equalTo(78 * (UIScreen.main.bounds.width / 375))
        }
        
        backView.addSubview(countView)
        countView.snp.makeConstraints { (make) in
            make.bottom.equalTo(deleteBackView)
            make.top.equalTo(volumeView)
            make.right.equalTo(volumeView.snp.left).offset(-8)
            make.width.equalTo(volumeView)
        }
        
        backView.addSubview(priceView)
        priceView.snp.makeConstraints { (make) in
            make.bottom.equalTo(deleteBackView)
            make.top.equalTo(volumeView)
            make.right.equalTo(countView.snp.left).offset(-8)
            make.left.equalTo(8)
        }

    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @objc func deleteBasket() {
        delegate?.deleteProductBasket(product_id: basketProduct.product.id, index: index)
    }
}

//MARK: - UITextFieldDelegate
extension BasketTableViewCell: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        let res = self.basketProduct.product.area
        let count = (Double(countView.valueTextField.text!) ?? 0)
        let area = res * count
        volumeView.valueTextField.text = String(format:"%.2f", area)
        coundDelegate?.changedBasketCount(index: self.index, count: Int(count))
    }
}
