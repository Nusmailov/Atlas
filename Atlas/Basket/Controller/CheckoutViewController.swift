//
//  CheckoutViewController.swift
//  Atlas
//
//  Created by Nurzhigit Smailov on 2/5/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import UIKit
import MessageUI
import CoreLocation

class CheckoutViewController: ScrollViewController {
    
    //MARK: - Properties
    lazy var checkoutView: CheckoutView = {
        let view = CheckoutView()
        view.dateSelectView.button.addTarget(self, action: #selector(openCalendarView), for: .touchUpInside)
        view.contactView.emailView.addTarget(self, action: #selector(writeToEmail), for: .touchUpInside)
        view.contactView.phoneView.addTarget(self, action: #selector(call), for: .touchUpInside)
        view.contactView.webView.addTarget(self, action: #selector(openWebsite), for: .touchUpInside)
        return view
    }()
    var parameters = Parameters()
    lazy var contactViewModel: ContactViewModel = {
        let viewModel = ContactViewModel()
        viewModel.delegate = self
        return viewModel
    }()
    var contact: Contact? {
        didSet {
            checkoutView.addressView.addressLabel.text = contact?.address
            var phone = ""
            for i in contact!.call_phone {
                phone += i + "\n"
            }
            var email = ""
            for i in contact!.email {
                email += i + "\n"
            }
            checkoutView.contactView.phoneView.infoTextLabel.text = phone
            checkoutView.contactView.emailView.infoTextLabel.text = email
            checkoutView.contactView.webView.infoTextLabel.text = contact?.site
            guard let lat = contact?.lat, let lng = contact?.lng else { return }
            checkoutView.addressView.mapView.initialLocation = CLLocation(latitude: lat, longitude: lng)
            checkoutView.addressView.mapView.centerMapOnLocation(location: CLLocation(latitude: lat, longitude: lng))
        }
    }
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        contactViewModel.getContactDetail()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    //MARK: - SetupViews
    func setupViews() {
        contentView.addSubviews(views: [checkoutView])
        checkoutView.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalToSuperview()
        }
    }
    
    //MARK: - Actions
    @objc func openCalendarView() {
        let vc = CalendarViewController()
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func call() {
        contactViewModel.call()
    }
    
    @objc func openWebsite() {
        contactViewModel.openWebsite()
    }
    
    @objc func writeToEmail() {
        contactViewModel.writeEmail(on: self)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}

extension CheckoutViewController: ProcessViewDelegate {
    func updateUI() {
        self.contact = contactViewModel.contact
    }
}
