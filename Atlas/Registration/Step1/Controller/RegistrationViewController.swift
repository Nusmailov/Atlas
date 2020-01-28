//
//  RegistrationViewController.swift
//  Atlas
//
//  Created by Tuigynbekov Yelzhan on 10/18/19.
//  Copyright © 2019 Yelzhan Tuigynbekov. All rights reserved.
//

import UIKit
class RegistrationViewController: ScrollViewController {
    
    //MARK: - Properties
    lazy var avatarView = ProfileImageView()
    lazy var switcherView: SwitcherView = {
        let view = SwitcherView()
        view.switcherView.selectLeftSide = {
            self.registrationInputView.isPhysLico = true
        }
        view.switcherView.selectRightSide = {
            self.registrationInputView.isPhysLico = false
        }
        return view
    }()
    lazy var registrationInputView = RegistrationInputView()
    lazy var nextButton = MainButton(title: "Продолжить")
    lazy var policyCondition: PolicyConditionView = {
        let view = PolicyConditionView()
        
        return view
    }()
    lazy var imagePicker: ImagePicker = {
        
        let rootController = UIApplication.shared.keyWindow!.rootViewController!
        let imagePicker = ImagePicker(presentationController: rootController, delegate: self)
        
        return imagePicker
    }()

    
    lazy var rightBarLabel: UIBarButtonItem = {
        var label = UIBarButtonItem()
        label = UIBarButtonItem(title: "1 шаг", style: .plain, target: self, action: nil)
        label.tintColor = #colorLiteral(red: 0.7843137255, green: 0.2039215686, blue: 0.2784313725, alpha: 1)
        
        return label
    }()
    
    
    //MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupAction()
        setupBackground()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationDetail()
    }
    //MARK:- SetupViews
    private func setupViews() -> Void {
        RegistrationFirstStepControllerConstraintConfiguration.shared.setupView(self)

    }

    private func setupAction() -> Void {
        nextButton.mainButton.addTarget(self, action: #selector(getNextStep), for: .touchUpInside)
    }
    
    func setupBackground() -> Void {
        view.backgroundColor = .white
    }
    
    //MARK:- Setupnavigation
    func setupNavigationDetail() -> Void {
        title = "Регистрация"
        navigationController?.navigationBar.isHidden = false
        navigationItem.rightBarButtonItem = rightBarLabel
        navigationController?.navigationBar.tintColor = .mainColor
        navigationController?.navigationBar.topItem?.title = ""
    }
    
    //    MARK: - Objc functions
    
    @objc func getNextStep() -> Void{
        navigationController?.pushViewController(ConfirmationViewController(), animated: true)
    }
}
extension RegistrationViewController: ImagePickerDelegate {
    
    func didSelect(image: UIImage?) {
        avatarView.avatar.image = image
    }
}
