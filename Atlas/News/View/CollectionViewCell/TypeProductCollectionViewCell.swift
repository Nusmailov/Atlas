//
//  CategoryCollectionViewCell.swift
//  Delivery
//
//  Created by Nurzhigit Smailov on 9/10/19.
//  Copyright © 2019 Nurzhigit Smailov. All rights reserved.
//

import UIKit
import SDWebImage

class TypeProductCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    lazy var categoryBackView: UIView = {
        let button = UIImageView()
        button.layer.cornerRadius = 10
        return button
    }()
    lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 14)// UIFont(name: Font.GTWalsheimBold, size: 14)
        label.textColor = .white
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    lazy var categoryImageView: UIImageView = {
        let view = UIImageView()
        view.image = #imageLiteral(resourceName: "plitka 1")
        view.contentMode = .scaleAspectFit
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        return view
    }()
    var category: Cats! {
        didSet {
            categoryLabel.text = category.name
            let colorBack = UIColor(cgColor: color(from: String(category.color?.suffix(category.color!.count - 1) ?? "FFFFFF")))
            categoryBackView.backgroundColor = colorBack
            guard let link = category.image else { return }
            categoryImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
            categoryImageView.sd_setImage(with: Product.getImageUrl(url: link))
        }
    }
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCategory(category: Cats) {
        self.category =  category
    }
    
    // MARK: - SetupViews
    func setupViews() {
        layer.cornerRadius = 10
        addSubview(categoryBackView)
        
        categoryBackView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(8)
            make.left.equalToSuperview().offset(4)
            make.right.bottom.equalToSuperview().offset(-4)
            make.width.equalTo(100)
            make.height.equalTo(140)
        }
        
        categoryBackView.addSubview(categoryImageView)
        categoryBackView.addSubview(categoryLabel)
        
        categoryImageView.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().offset(2)
            make.right.equalToSuperview().offset(-2)
            make.width.height.equalTo(80)
        }
        
        categoryLabel.snp.makeConstraints { (make) in
            make.top.equalTo(categoryImageView.snp.bottom).offset(2)
            make.bottom.right.equalToSuperview().offset(-8)
            make.left.equalToSuperview().offset(8)
            make.centerX.equalToSuperview()
        }
    }
    
}

extension UIView {
    func color(from hexString : String) -> CGColor {
        if let rgbValue = UInt(hexString, radix: 16) {
            let red   = CGFloat((rgbValue >> 16) & 0xff) / 255
            let green = CGFloat((rgbValue >>  8) & 0xff) / 255
            let blue  = CGFloat((rgbValue    ) & 0xff) / 255
            return UIColor(red: red, green: green, blue: blue, alpha: 1.0).cgColor
        } else {
            return UIColor.black.cgColor
        }
    }
}
