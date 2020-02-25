//
//  ContactInfoViewController.swift
//  Delivery
//
//  Created by Nurzhigit Smailov on 8/23/19.
//  Copyright © 2019 Nurzhigit Smailov. All rights reserved.
//

import UIKit

class ContactInfoViewController: ScrollViewController {
    
    // MARK: - Properties
    lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.font = .getMontserraRegularFont(on: 14)
        label.textColor = UIColor(red: 0.318, green: 0.361, blue: 0.435, alpha: 1)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        return label
    }()
    var state: ContactInfoText!
    lazy var viewModel: PrivacyPolicyViewModel = {
        let viewModel = PrivacyPolicyViewModel()
        viewModel.delegate = self
        return viewModel
    }()
    var text: String! = "" {
        didSet {
            infoLabel.text = text
        }
    }
    
    // MARK: - Lifecycle
    init(state: ContactInfoText) {
        self.state = state
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        viewModel.getInfo(column: state.text)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = state.title
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.isHidden = false
    }
    
    // MARK: - SetupViews
    func setupViews() {
        contentView.addSubview(infoLabel)
        infoLabel.snp.makeConstraints { (make) in
            make.top.left.equalTo(16)
            make.right.bottom.equalTo(-16)
        }
    }
}

// MARK: - ProcessViewDelegate
extension ContactInfoViewController: ProcessViewDelegate {
    func updateUI() {
        self.text = viewModel.text
    }
}
