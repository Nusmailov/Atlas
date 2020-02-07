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
        view.dateSelectView.button.addTarget(self, action: #selector(openCalendarView), for: .touchUpInside)
        return view
    }()
    var parameters = Parameters()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    //MARK: - SetupViews
    func setupViews() {
        contentView.addSubviews(views: [checkoutView])
        checkoutView.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalToSuperview()
        }
    }
    
    //MARK: - Actions
    @objc func openCalendarView() {
        let vc = CalendarViewController()
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
//        self.navigationController?.present(vc, animated: true)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
