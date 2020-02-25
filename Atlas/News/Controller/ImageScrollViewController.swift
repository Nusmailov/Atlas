//
//  ImageScrollViewController.swift
//  Atlas
//
//  Created by Nurzhigit Smailov on 2/25/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import UIKit

class ImageScrollViewController: UIViewController {
    
    var imageScrollView: ImageScrollView!
    var image_path = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        downloadImage(from: Product.getImageUrl(url: image_path))
    }
    
    func setupViews() {
        imageScrollView = ImageScrollView(frame: view.bounds)
        view.addSubview(imageScrollView)
        imageScrollView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL) {
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() {
                self.imageScrollView.set(image: UIImage(data: data)!)
            }
        }
    }
}
