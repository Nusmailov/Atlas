//
//  SettingsViewController.swift
//  Delivery
//
//  Created by Nurzhigit Smailov on 8/23/19.
//  Copyright © 2019 Nurzhigit Smailov. All rights reserved.
//

import UIKit

class SettingsViewController: ScrollViewController {
    
    // MARK: - Properties
    lazy var mainSettingsView: SelectSettingsView = {
        let view = SelectSettingsView()
        view.layer.cornerRadius = 10
        view.backgroundColor = .white
        view.soundView.switchView.addTarget(self, action: #selector(soundOnOff), for: .valueChanged)
        view.pushView.switchView.addTarget(self, action: #selector(pushOnOff), for: .valueChanged)
        return view
    }()
    lazy var changeAccountButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(closeApp), for: .touchUpInside)
        button.setTitle("Сменить аккаунт", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .mainColor
        button.layer.cornerRadius = 10
        button.titleLabel?.font = .getMullerBoldFont(on: 18)
        return button
    }()
    lazy var pickerCityView: UIPickerView  = {
        let view = UIPickerView()
        return view
    }()
    lazy var pickerLanguageView: UIPickerView  = {
        let view = UIPickerView()
        return view
    }()
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "back"), for: .normal)
        button.addTarget(self, action: #selector(cancelButton), for: .touchUpInside)
        button.imageEdgeInsets = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 30)
        button.transform = CGAffineTransform(scaleX: -1, y: 1)
        return button
    }()
    lazy var profileViewModel: ProfileViewModel = {
        let viewModel = ProfileViewModel()
        viewModel.delegate = self
        return viewModel
    }()
    lazy var refreshControl = UIRefreshControl()
    var parameters = Parameters()
    
    // MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "Настройки"
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 1, green: 0.4117647059, blue: 0.4117647059, alpha: 1)
        self.navigationItem.setHidesBackButton(true, animated: true)
        let barButton = UIBarButtonItem(customView: backButton)
        self.navigationItem.rightBarButtonItem = barButton
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    // MARK: - Setupviews
    func setupViews() {
        let leftSwipe = UISwipeGestureRecognizer(target: self, action:#selector(handleSwipes))
        leftSwipe.direction = .left
        contentView.addGestureRecognizer(leftSwipe)
        scrollView.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9568627451, blue: 0.968627451, alpha: 1)
        contentView.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9568627451, blue: 0.968627451, alpha: 1)
        contentView.addSubview(mainSettingsView)
        contentView.addSubview(changeAccountButton)
        
        mainSettingsView.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        
        changeAccountButton.snp.makeConstraints { (make) in
            make.top.equalTo(mainSettingsView.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(50)
            make.bottom.equalTo(contentView.snp.bottom).offset(-16)
        }
    }
    
    // MARK: - Actions
    @objc func closeApp() {
        UserManager.deleteCurrentSession()
        AppCenter.shared.start()
    }
    
    @objc override func handleSwipes(sender: UISwipeGestureRecognizer) {
        if (sender.direction == .left) {
            cancelButton()
        }
    }
    
    @objc override func cancelButton() {
        self.navigationController?.view.layer.add(CATransition().popFromRight(), forKey: nil)
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func pushOnOff(switcher: UISwitch) {
        let onOff = switcher.isOn ? 1 : 0
        parameters["push"] = onOff
        profileViewModel.editUser(parameters: parameters)
    }
    
    @objc func soundOnOff(switcher: UISwitch) {
        let onOff = switcher.isOn ? 1 : 0
        parameters["sound"] = onOff
        profileViewModel.editUser(parameters: parameters)
    }
}

extension SettingsViewController: ProcessViewDelegate {
    func updateUI() {
        try? UserManager.createSessionWithUser(UserModel.init(user: profileViewModel.user!))
    }
}
