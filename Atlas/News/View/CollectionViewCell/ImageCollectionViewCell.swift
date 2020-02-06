//
//  ImageCollectionViewCell.swift
//  Atlas
//
//  Created by Nurzhigit Smailov on 2/6/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    // MARK: - Properties
    lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = #imageLiteral(resourceName: "Mail opened")
        return view
    }()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - SetupViews
    func setupViews() {
        addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.center.equalToSuperview()
        }
    }
}
