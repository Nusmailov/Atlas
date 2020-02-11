//
//  ContactViewController.swift
//  Atlas
//
//  Created by Nurzhigit Smailov on 2/11/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import UIKit
import CoreLocation
import MessageUI

class ContactViewController: ScrollViewController {
    
    //MARK: - Properties
    lazy var addressView: AddressView = {
        let view = AddressView()
        return view
    }()
    lazy var contactView: ContactView = {
        let view = ContactView()
        view.emailView.addTarget(self, action: #selector(writeToEmail), for: .touchUpInside)
        view.webView.addTarget(self, action: #selector(openWebsite), for: .touchUpInside)
        view.phoneView.addTarget(self, action: #selector(call), for: .touchUpInside)
        return view
    }()
    lazy var estimateView: EstimateView = {
        let view = EstimateView()
        return view
    }()
    lazy var viewModel: ContactViewModel = {
        let viewModel = ContactViewModel()
        viewModel.delegate = self
        return viewModel
    }()
    var contact: Contact? {
        didSet {
            addressView.addressLabel.text = contact?.address
            contactView.phoneView.infoTextLabel.text = contact?.call_phone
            contactView.emailView.infoTextLabel.text = contact?.email
            contactView.webView.infoTextLabel.text = contact?.site
            guard let lat = contact?.lat, let lng = contact?.lng else { return }
            addressView.mapView.initialLocation = CLLocation(latitude: lat, longitude: lng)
            addressView.mapView.centerMapOnLocation(location: CLLocation(latitude: lat, longitude: lng))
        }
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        viewModel.getContactDetail()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = "Контакты"
    }
    
    //MARK: - SetupViews
    func setupViews() {
        contentView.addSubviews(views: [contactView, addressView, estimateView])
        
        addressView.snp.remakeConstraints { (make) in
            make.top.left.equalToSuperview().offset(16)
            make.right.equalTo(-16)
        }
        
        contactView.snp.makeConstraints { (make) in
            make.top.equalTo(addressView.snp.bottom).offset(16)
            make.left.equalTo(16)
            make.right.equalTo(-16)
        }
        
        estimateView.snp.makeConstraints { (make) in
            make.top.equalTo(contactView.snp.bottom).offset(16)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    @objc func call() {
        viewModel.call()
    }
    
    @objc func openWebsite() {
        viewModel.openWebsite()
    }
    
    @objc func writeToEmail() {
        viewModel.writeEmail(on: self)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}

extension ContactViewController: ProcessViewDelegate {
    func updateUI() {
        self.contact = viewModel.contact!
    }
}
