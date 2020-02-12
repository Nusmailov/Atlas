//
//  BannerCollectionView.swift
//  Atlas
//
//  Created by Nurzhigit Smailov on 1/27/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import UIKit

protocol OpenImageDelegate: class {
    func openImage(image_url: String)
}

class ProductDescriptionView: UIView {
    
    // MARK: - Properties
    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 300)
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.delegate = self
        cv.dataSource = self
        cv.register(BannerCollectionViewCell.self, forCellWithReuseIdentifier: "cellId")
        cv.isScrollEnabled = true
        cv.isPagingEnabled = true
        cv.backgroundColor = .white
        cv.showsHorizontalScrollIndicator = false
        return cv
    }()
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.267, green: 0.267, blue: 0.267, alpha: 1)
        label.font = .getMontserraBoldFont(on: 18)
        label.numberOfLines = 0
        label.text = "Клинкер «Амстердам»"
        return label
    }()
    lazy var sizeLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.667, green: 0.667, blue: 0.667, alpha: 1)
        label.font = .getMontserraRegularFont(on: 12)
        label.numberOfLines = 0
        label.text = "29.8х29.8 см 1.33 м2"
        return label
    }()
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.267, green: 0.267, blue: 0.267, alpha: 1)
        label.text = "Предзаказывая товар, вам нужно будет указать дату подготовки вашего заказа. При наступлении даты предзаказа, вам нужно будет забрать ваш заказ со склада."
        label.numberOfLines = 0
        label.font = .getMontserraRegularFont(on: 12)
        return label
    }()
    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.267, green: 0.267, blue: 0.267, alpha: 1)
        label.font = .getMontserraBoldFont(on: 18)
        label.numberOfLines = 0
        label.text = "20 000 тг"
        return label
    }()
    lazy var descriptionTextLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.788, green: 0.788, blue: 0.788, alpha: 1)
        label.font = .getMontserraMediumFont(on: 15)
        label.numberOfLines = 0
        label.text = "Описание"
        return label
    }()
    lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.currentPageIndicatorTintColor = .mainColor
        pageControl.isUserInteractionEnabled = false
        pageControl.hidesForSinglePage = true
        return pageControl
    }()
    lazy var heartButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.imageEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        button.layer.cornerRadius = 17
        button.setImage(UIImage(named: "emptyHeart"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()
    lazy var quantityView: ProductCharacteristicView = {
        let view = ProductCharacteristicView()
        view.titleLabel.text = "шт:"
        view.valueTextField.text = "2"
        view.valueTextField.keyboardType = .numberPad
        return view
    }()
    lazy var areaView: ProductCharacteristicView = {
        let view = ProductCharacteristicView()
        view.titleLabel.text = "м2:"
        view.valueTextField.text = "2.66"
        view.valueTextField.isEnabled = false
        return view
    }()
    lazy var buyButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .mainColor
        button.layer.cornerRadius = 6
        button.setTitle("В корзину", for: .normal)
        button.titleLabel?.font = .getMontserraSemiBoldFont(on: 12)
        return button
    }()
    lazy var checkButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .mainColor
        button.layer.cornerRadius = 6
        button.setTitle("Проверить наличие", for: .normal)
        button.titleLabel?.font = .getMontserraSemiBoldFont(on: 12)
        return button
    }()
    weak var imageDelegate: OpenImageDelegate?
    var product: Product!
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        collectionView.reloadData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setProduct(product: Product) {
        self.product = product
        pageControl.numberOfPages = product.images.count
    }
    
    // MARK: - SetupViews
    func setupViews() {
        addSubviews(views: [collectionView, nameLabel, descriptionLabel, priceLabel, pageControl,
                            sizeLabel, heartButton, quantityView, areaView, buyButton, descriptionTextLabel,
                            checkButton])
        collectionView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(300)
        }
        
        heartButton.snp.makeConstraints { (make) in
            make.top.equalTo(collectionView.snp.top).offset(10)
            make.right.equalTo(collectionView.snp.right).offset(-10)
            make.height.width.equalTo(34)
        }
        
        pageControl.snp.makeConstraints { (make) in
           make.top.equalTo(collectionView.snp.bottom)
           make.centerX.width.equalToSuperview()
        }
        
        sizeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(pageControl.snp.bottom).offset(8)
            make.left.equalTo(16)
            make.right.equalTo(-16)
        }
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(sizeLabel.snp.bottom).offset(4)
            make.left.equalTo(16)
            make.right.equalTo(-16)
        }
        priceLabel.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp.bottom).offset(4)
            make.left.equalTo(16)
            make.right.equalTo(-16)
        }
        quantityView.snp.makeConstraints { (make) in
            make.top.equalTo(priceLabel.snp.bottom).offset(4)
            make.left.equalTo(16)
            make.width.equalTo(100)
        }
        areaView.snp.makeConstraints { (make) in
            make.centerY.equalTo(quantityView)
            make.left.equalTo(quantityView.snp.right).offset(8)
            make.width.equalTo(100)
        }
        
        buyButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(areaView)
            make.left.equalTo(areaView.snp.right).offset(8)
            make.right.equalTo(-32)
            make.height.equalTo(35)
        }
        
        descriptionTextLabel.snp.makeConstraints { (make) in
            make.top.equalTo(quantityView.snp.bottom).offset(4)
            make.left.equalTo(16)
        }
        
        descriptionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(descriptionTextLabel.snp.bottom).offset(4)
            make.left.equalTo(16)
            make.right.equalTo(-16)
        }
        
        checkButton.snp.makeConstraints { (make) in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(16)
            make.left.equalTo(16)
            make.right.equalTo(-16)
            make.height.equalTo(40)
            make.bottom.equalToSuperview()
        }
    }
}

//MARK: - UICollectionViewDelegate
extension ProductDescriptionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return product.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! BannerCollectionViewCell
        cell.setImage(image: product.images[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width, height: 320)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        imageDelegate?.openImage(image_url: product.images[indexPath.item].image_path)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        guard let indexPath = collectionView.indexPathsForVisibleItems.first else {return}
        pageControl.currentPage = indexPath.item
    }
}
