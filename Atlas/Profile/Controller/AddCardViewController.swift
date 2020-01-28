//
//  AddCardViewController.swift
//  Delivery
//
//  Created by Nurzhigit Smailov on 8/27/19.
//  Copyright © 2019 Nurzhigit Smailov. All rights reserved.
//

import UIKit
import PassKit

class AddCardViewController: ScrollViewController {
    
    //MARK: - Properties
    lazy var addCardView: AddCardView = {
        let view = AddCardView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.addCardButton.addTarget(self, action: #selector(addCardToCloud), for: .touchUpInside)
        return view
    }()
        
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
        navigationController?.setNavigationBarHidden(false, animated: animated)
        getPublicId()
    }
    
    //MARK: - SetupViews
    func setupViews() {
        scrollView.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9568627451, blue: 0.968627451, alpha: 1)
        contentView.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9568627451, blue: 0.968627451, alpha: 1)
        contentView.addSubview(addCardView)
        addCardView.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().offset(16)
            make.bottom.right.equalToSuperview().offset(-16)
        }
        
        let dismissKeyBoardTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        scrollView.addGestureRecognizer(dismissKeyBoardTap)
    }
    
    //MARK: - Actions
//    override func keyboardWillShow(notification: NSNotification) {
//        if ((notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue) != nil {
//            if self.view.frame.origin.y == 0 {
//                self.view.frame.origin.y -= 10
//            }
//        }
//    }
    
    func isValidToRequest() -> Bool {
        guard addCardView.fullNameTextField.text!.count > 0 else {
            self.showErrorMessage("Введите полное имя на карте")
            return false
        }
        guard addCardView.cardNumberTextField.text!.count > 0 else {
            self.showErrorMessage("Введите номер карта")
            return false
        }
        guard addCardView.monthCardTextField.text!.count == 2 else {
            self.showErrorMessage("Введите месяц")
            return false
        }
        guard addCardView.yearCardTextField.text!.count == 2 else {
            self.showErrorMessage("Введите год")
            return false
        }
        guard addCardView.cvcCardTextField.text!.count == 3 else {
            self.showErrorMessage("Введите номер cvc")
            return false
        }
//        guard ((publicId?.PublicId) != nil) else{
//            return false
//        }
        return true
    }
    
    @objc override func dismissKeyboard() {
        view.endEditing(true)
    }
        
    @objc func addCardToCloud() {
        guard isValidToRequest() else { return }
//        let month = addCardView.monthCardTextField.text!
//        let year = addCardView.yearCardTextField.text!
//        let mmyy = "\(month)/\(year)"
//        let cvc = addCardView.cvcCardTextField.text!
//        let fullname = addCardView.fullNameTextField.text!
//        let number = addCardView.cardNumberTextField.text!
    }
    
    func getPublicId() {
        
    }
}
