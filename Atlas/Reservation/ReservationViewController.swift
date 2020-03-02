//
//  ReservationViewController.swift
//  Atlas
//
//  Created by Nurzhigit Smailov on 2/27/20.
//  Copyright © 2020 Nurzhigit Smailov. All rights reserved.
//

import UIKit

class ReservationViewController: UIViewController {
    
    //MARK: - Properties
    lazy var statusBar: ReservationStatusBarView = {
        let view = ReservationStatusBarView()
        return view
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
        navigationController?.setNavigationBarHidden(true, animated: animated)
        
    }
    
    //MARK: - SetupViews
    func setupViews() {
        
    }
    
}
