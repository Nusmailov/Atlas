//
//  DiscountCollectionViewCell.swift
//  Delivery
//
//  Created by Nurzhigit Smailov on 8/19/19.
//  Copyright © 2019 Nurzhigit Smailov. All rights reserved.
//

import UIKit
import SDWebImage

class DiscountCollectionViewCell: UICollectionViewCell {
    // MARK: - Properties
    lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = #imageLiteral(resourceName: "Group 8961")
        view.layer.cornerRadius = 5
        
        return view
    }()
    var news: News! {
        didSet {
            imageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
            imageView.sd_setImage(with: Product.getImageUrl(url: news.banner_image))
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
    
    func setNews(news: News){
        self.news = news
    }
    
    // MARK: - SetupViews
    func setupViews() {
        addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(5)
            make.right.equalTo(-5)
        }
    }
    
}
