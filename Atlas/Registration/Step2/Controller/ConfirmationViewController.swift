//
//  ConfirmationViewController.swift
//  Atlas
//
//  Created by Tuigynbekov Yelzhan on 10/19/19.
//  Copyright © 2019 Yelzhan Tuigynbekov. All rights reserved.
//

import UIKit
class ConfirmationViewController: ScrollViewController {
    
    //MARK:- Preasure
    lazy var rightBarLabel: UIBarButtonItem = {
        var label = UIBarButtonItem()
        label = UIBarButtonItem(title: "2 шаг", style: .plain, target: self, action: nil)
        label.tintColor = #colorLiteral(red: 0.7843137255, green: 0.2039215686, blue: 0.2784313725, alpha: 1)
        
        return label
    }()
    lazy var logoView = LoginLogoView()
    lazy var regButton = MainButton(title: "Зарегистрироваться")
    lazy var confirmView: ConfirmationView = {
        let view = ConfirmationView()
        
        return view
    }()
    lazy var confidyButtonView = ConfidentionButtonView()

    //MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupActions()
        setupBackground()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationDetail()
    }
    
    //MARK:- SetupViews
    func setupViews() -> Void {
        scrollView.addSubview(logoView)
        logoView.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
        }
        
        scrollView.addSubview(confirmView)
        confirmView.snp.makeConstraints { (make) in
            make.top.equalTo(logoView.snp.bottom).offset(34)
            make.left.right.equalToSuperview()
        }
        scrollView.addSubview(regButton)
        regButton.snp.makeConstraints { (make) in
            make.top.equalTo(confirmView.snp.bottom).offset(57)
            make.left.equalTo(20)
            make.right.equalTo(-20)
        }
        
        scrollView.addSubview(confidyButtonView)
        confidyButtonView.snp.makeConstraints { (make) in
            make.top.equalTo(regButton.snp.bottom).offset(23)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(-30)
        }
    }
    
    private func setupBackground() -> Void {
        view.backgroundColor = .white
    }
    
    private func setupActions() -> Void {
        regButton.mainButton.addTarget(self, action: #selector(registraionAction), for: .touchUpOutside)
    }
    
    //MARK: - Navigation
    func setupNavigationDetail()-> Void{
        title = "Регистрация"
        navigationController?.navigationBar.isHidden = false
        navigationItem.rightBarButtonItem = rightBarLabel
        navigationController?.navigationBar.tintColor = .mainColor
        self.navigationController?.navigationBar.topItem?.title = ""
    }
    
    //MARK:- @objc
    @objc func registraionAction(_: UIButton){
        AppCenter.shared.setRootController(controller: TabBarViewController())
    }

}
