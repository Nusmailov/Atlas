//
//  ViewController.swift
//  Atlas
//
//  Created by Eldor Makkambayev on 11/20/19.
//  Copyright © 2019 Eldor Makkambayev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.tintColor = .mainColor
    }
}
