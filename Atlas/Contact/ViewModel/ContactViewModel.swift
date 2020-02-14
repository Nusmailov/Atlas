//
//  ContactViewModel.swift
//  Atlas
//
//  Created by Nurzhigit Smailov on 2/11/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import Foundation
import UIKit
import MessageUI

class ContactViewModel {
    weak var delegate: ProcessViewDelegate?
    var contact: Contact?
    weak var baseViewController: UIViewController?
    
    func getContactDetail() {
        delegate?.showLoader()
        ParseManager.shared.getRequest(url: ContactApi.info, success: { (result: Contact) in
            self.contact = result
            self.delegate?.hideLoader()
            self.delegate?.updateUI()
        }) { (error) in
            self.delegate?.showErrorMessage(error)
        }
    }
    
    func openWebsite() {
        guard let site = contact?.site else { return }
        if let url = URL(string: site) {
            UIApplication.shared.open(url)
        }
    }
    
    func writeEmail(on baseVC: UIViewController) {
        baseViewController = baseVC
        guard let email = contact?.email else { return }
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self as? MFMailComposeViewControllerDelegate
            mail.setToRecipients(email)
            mail.setMessageBody("", isHTML: true)
            baseViewController?.present(mail, animated: true)
        }
    }
    
    func call() {
        guard let phone = contact?.call_phone[0] else { return }
        let url: NSURL = URL(string: "TEL://" + phone)! as NSURL
        UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
    }
}
