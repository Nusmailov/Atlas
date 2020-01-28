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
    lazy var refreshControl = UIRefreshControl()
    
    // MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "Настройки"
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 1, green: 0.4117647059, blue: 0.4117647059, alpha: 1)
        self.navigationItem.setHidesBackButton(true, animated: true)
        var image = #imageLiteral(resourceName: "back")
        image = image.withRenderingMode(.alwaysOriginal)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style:.plain,
                                                                target: self, action: #selector(cancelButton))
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
        
        pickerCityView.delegate = self
        pickerLanguageView.delegate = self
        
        mainSettingsView.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        
        mainSettingsView.cityTextField.inputView =  pickerCityView
        mainSettingsView.chooseLanguageTextField.inputView =  pickerLanguageView
        
        mainSettingsView.cityTextField.isUserInteractionEnabled = true
        mainSettingsView.chooseLanguageTextField.isUserInteractionEnabled = true
        
//        changeAccountButton.isHidden = !appStoreBool
        changeAccountButton.snp.makeConstraints { (make) in
            make.top.equalTo(mainSettingsView.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(60)
            make.bottom.equalTo(contentView.snp.bottom).offset(-16)
        }
    }
    
    // MARK: - Actions
    @objc func closeApp() {

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
    
}

// MARK: - PickerViewDelegate
extension SettingsViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

    }
}
