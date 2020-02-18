//
//  InfoOrderViewController.swift
//  Delivery
//
//  Created by Nurzhigit Smailov on 8/23/19.
//  Copyright © 2019 Nurzhigit Smailov. All rights reserved.
//

import UIKit

class InfoOrderViewController: UIViewController {
    
    //MARK: - Properties
    lazy var webView: UIWebView = {
        let view = UIWebView()
        return view
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Информация о платежах"
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 1, green: 0.4117647059, blue: 0.4117647059, alpha: 1)
        tabBarController?.tabBar.isHidden = true
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    //MARK: - SetupViews
    func setupViews() {
        view.addSubview(webView)
        webView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        let url = URL(string: "http://194.4.58.28:9999/api/info/payment")
        webView.loadRequest(URLRequest(url: url!))
        webView.backgroundColor = .white
    }
    //MARK: - Actions
}
