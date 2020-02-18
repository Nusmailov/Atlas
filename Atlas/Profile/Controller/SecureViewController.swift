//
//  SecureViewController.swift
//  Delivery
//
//  Created by Nurzhigit Smailov on 10/21/19.
//  Copyright © 2019 Nurzhigit Smailov. All rights reserved.
//

import UIKit

class SecureViewController: UIViewController {
    
    lazy var webView: UIWebView = {
        let view = UIWebView()
        return view
    }()
    var html = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setupViews(){
        view.addSubview(webView)
        webView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        webView.loadHTMLString(html, baseURL: nil)
        webView.backgroundColor = .white
    }
}
