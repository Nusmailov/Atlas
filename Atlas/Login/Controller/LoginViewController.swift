//
//  LoginViewController.swift
//  Atlas
//
//  Created by Tuigynbekov Yelzhan on 10/18/19.
//  Copyright © 2019 Yelzhan Tuigynbekov. All rights reserved.
//

import UIKit
import SnapKit
class LoginViewController: LoaderBaseViewController {
    //MARK: - Properties
    private var viewModel: AuthorizationViewModel = AuthorizationViewModel()

    lazy var logoView = LoginLogoView()
    lazy var autorizationInputView = AutorizationInputView()
    lazy var signInEventsView = SignInEventsView()
    lazy var confButton: ConfidentionButtonView = {
        let view = ConfidentionButtonView()
        view.isUserInteractionEnabled = true
        view.btnPrivacy.addTarget(self, action: #selector(privacy), for: .touchUpInside)
        return view
    }()
    
    //MARK: - Start functions
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAction()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    //MARK: - Setup functions
    private func setupView() -> Void {
        LoginControllerConstaintConfiguration.shared.setupView(self)
    }
    
    private func setupAction() -> Void {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(privacy))
        confButton.addGestureRecognizer(gesture)
        
        signInEventsView.regButton.addTarget(self, action: #selector(goToRegController), for: .touchUpInside)
        signInEventsView.signInButton.mainButton.addTarget(self, action: #selector(getSignIn), for: .touchUpInside)
    }
    
    //MARK: - Simple functions
    func goToMainController() -> Void {
        AppCenter.shared.window.rootViewController = TabBarViewController()
    }
    
    func isValidateEmail() -> Bool {
        if !autorizationInputView.phoneTextField.textField.text!.isEmpty {
            return false
        }
        return true
    }
    
    func isValidate() -> Bool {
        guard !autorizationInputView.phoneTextField.textField.text!.isEmpty else {
            self.showErrorMessage("Введите номер")
            return false
        }
        guard isValidateEmail() else {
            self.showErrorMessage("Не правильно указали e-mail")
            return false
        }
        guard !autorizationInputView.passwordTextField.textField.text!.isEmpty else {
            self.showErrorMessage("Введите пароль")
            return false
            
        }
        guard let passwrd = autorizationInputView.passwordTextField.textField.text, passwrd.count > 5 else {
            self.showErrorMessage("Слишком слабый пароль")
            return false
        }
        return true
    }
    
    
    //    MARK: - Parse functions
    @objc func getSignIn() -> Void {
        authorize()
    }
    
    @objc func goToRegController() -> Void {
        navigationController?.pushViewController(RegistrationViewController(), animated: true)
    }
    
    @objc func privacy() {
        let vc = PoliticalViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func authorize() -> Void {
        
        viewModel.setPhone(autorizationInputView.phoneTextField.phoneTextField.text!)
        viewModel.setPassword(autorizationInputView.passwordTextField.textField.text!)
        let parameters = viewModel.getParameters()
        showLoader()
        
        ParseManager.shared.postRequest(url: AppConstants.API.authUrl, parameters: parameters, success: { (result: User?) in
            self.hideLoader()
            do {
                try? UserManager.createSessionWithUser(UserModel.init(user: result!))
            }
            AppCenter.shared.makeRootController()
        }) { (error) in
            self.hideLoader()
            self.showErrorMessage(error)
        }
    }
}

extension LoginViewController: UITextFieldDelegate {

    //    MARK: - TextFieldDelegate

//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//
//        viewModel.setPhone(autorizationInputView.phoneTextField.textField.text.appending(string))
//
//        return true
//    }
}
