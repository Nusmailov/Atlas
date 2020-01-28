//
//  PoliticalViewController.swift
//  Atlas
//
//  Created by Nurzhigit Smailov on 1/28/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import UIKit

class PoliticalViewController: ViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }

}
