
//
//  ImageViewController.swift
//  InMaster
//
//  Created by Nurzhigit Smailov on 11/13/19.
//  Copyright © 2019 Nurzhigit Smailov. All rights reserved.
//

import UIKit
import SDWebImage

class ImageViewController: UIViewController {
    
    //MARK: - Properties
    lazy var image: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
    var path: String?
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        loadImage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.tintColor = .mainColor
    }
    
    //MARK: - SetupViews
    func setupViews() {
        view.addSubview(image)
        image.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        view.backgroundColor = .white
    }
    
    //MARK: - LoadImage
    func loadImage() {
        if path != nil {
            let url = Product.getImageUrl(url: path!)
            image.sd_imageIndicator = SDWebImageActivityIndicator.gray
            image.sd_setImage(with: url)
        }
    }
}
