//
//  LoaderBaseViewController.swift
//  Atlas
//
//  Created by Eldor Makkambayev on 1/13/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import UIKit

class LoaderBaseViewController: ScrollViewController {
    
    var loader: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView()
        loader.hidesWhenStopped = true
        loader.style = .whiteLarge
        loader.backgroundColor = .lightGray
        loader.layer.cornerRadius = 15
        loader.layer.masksToBounds = true
        loader.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return loader
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(loader)
        loader.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.height.equalTo(80)
        }
    }
}
