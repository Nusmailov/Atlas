//
//  ContactInfoViewController.swift
//  Delivery
//
//  Created by Nurzhigit Smailov on 8/23/19.
//  Copyright © 2019 Nurzhigit Smailov. All rights reserved.
//

import UIKit

class ContactInfoViewController: UIViewController {
    // MARK: - Properties
    lazy var webView: UIWebView = {
        let view = UIWebView()
        return view
    }()
    
    // MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.init(red: 81/255, green: 92/255,
                                                                                   blue: 111/255, alpha: 1.0)]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationItem.title = "Контакты"
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 1, green: 0.4117647059, blue: 0.4117647059, alpha: 1)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        view.backgroundColor = UIColor(patternImage: UIImage(named: MediaType.background)!)
        setupViews()
    }
    
    // MARK: - SetupViews
    func  setupViews() {
        view.addSubview(webView)
        webView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        let url = URL(string: "http://194.4.58.28:9999/api/info/offices")
        webView.loadRequest(URLRequest(url: url!))
        webView.backgroundColor = .white
    }
}
