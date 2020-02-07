//
//  BannerCollectionViewCell.swift
//  Atlas
//
//  Created by Nurzhigit Smailov on 1/27/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import UIKit
import SDWebImage

class BannerCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.image = #imageLiteral(resourceName: "no-image")
        view.contentMode = .scaleAspectFit
        view.layer.masksToBounds = true
        view.backgroundColor = .white
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
    }()
    var image: ImageModel! {
        didSet {
            imageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
            imageView.contentMode = .scaleAspectFill
            imageView.sd_setImage(with: Product.getImageUrl(url: image.image_path))
        }
    }
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func setImage(image: ImageModel) {
        self.image = image
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - SetupViews
    func setupViews() {
        addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}
