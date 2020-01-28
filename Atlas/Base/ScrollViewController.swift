//
//  ScrollViewController.swift
//  Santo
//
//  Created by Eldor Makkambayev on 9/26/19.
//  Copyright © 2019 Eldor Makkambayev. All rights reserved.
//

import Foundation
import UIKit
//import SVProgressHUD

class ScrollViewController: ViewController {
    
    //MARK: - Properties
    lazy var scrollView = UIScrollView()
    lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    //MARK: - Start functions
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScrollView()
        hideKeyboardWhenTappedAround()
    }
    
    //MARK: - Setup functions
    func setupScrollView() {
        view.backgroundColor = .white
        scrollView.alwaysBounceVertical = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.keyboardDismissMode = .onDrag
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.width.equalTo(UIScreen.main.bounds.width)
        }
        
        contentView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.width.equalTo(view)
        }
    }
    
    //MARK: - functions
    func addToScrollView(_ views: [UIView]) -> Void {
        for view in views {
            scrollView.addSubview(view)
        }
    }
    
    @objc func handleSwipes(sender: UISwipeGestureRecognizer) {
        if (sender.direction == .right) {
            cancelButton()
        }
    }
    
    @objc func cancelButton() {
        dismiss(animated: true, completion: nil)
    }

}
