//
//  CheckoutViewController.swift
//  Atlas
//
//  Created by Nurzhigit Smailov on 2/5/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import UIKit

class CheckoutViewController: ScrollViewController {
    
    //MARK: - Properties
    lazy var checkoutView: CheckoutView = {
        let view = CheckoutView()
        return view
    }()

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    //MARK: - SetupViews
    func setupViews() {
        contentView.addSubviews(views: [checkoutView])
        checkoutView.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalToSuperview()
        }
    }
}
