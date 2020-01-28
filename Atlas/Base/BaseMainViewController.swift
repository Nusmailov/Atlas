//
//  BaseMainViewController.swift
//  Atlas
//
//  Created by Tuigynbekov Yelzhan on 10/24/19.
//  Copyright © 2019 Yelzhan Tuigynbekov. All rights reserved.
//

import UIKit
class BaseMainViewController: ViewController {

    //MARK: - Properties
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupConfigurationBar()
    }
    
    //MARK: - SetupConfigurationBar
    private func setupConfigurationBar() -> Void{
        navigationController?.navigationBar.barTintColor = .white
        
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.shadowImage = UIImage()
        
        let rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "box").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(toBacket))
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    //MARK: - @objc func
    @objc private func toBacket(_: UIButton) -> Void {
        
    }

}
