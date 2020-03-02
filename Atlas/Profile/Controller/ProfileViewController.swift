//
//  ProfileViewController.swift
//  Delivery
//
//  Created by Nurzhigit Smailov on 8/19/19.
//  Copyright © 2019 Nurzhigit Smailov. All rights reserved.
//

import UIKit
import SDWebImage

class ProfileViewController: ScrollViewController {
    
    // MARK: - Properties
    lazy var profileView: ProfileView = {
        let view = ProfileView()
        view.userImageView.isUserInteractionEnabled = true
        return view
    }()
    lazy var mainView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        return view
    }()
    var addresses = [Address]()
    var cards = [CloudCard]()
    var refreshControl = UIRefreshControl()
    lazy var rightButton: BasketCountButton = {
        let button = BasketCountButton()
        button.addTarget(self, action: #selector(goToBusketView), for: .touchUpInside)
        return button
    }()
    lazy var leftButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 32, height: 32))
        button.setImage(UIImage(named: "settings"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 36)
        button.addTarget(self, action: #selector(settingsButtonAction), for: .touchUpInside)
        return button
    }()
    lazy var viewModel: ProfileViewModel = {
        let viewModel = ProfileViewModel()
        viewModel.delegate = self
        return viewModel
    }()
    lazy var newsViewModel: NewsViewModel = {
        let viewModel = NewsViewModel()
        viewModel.basketCountDelegate = self
        return viewModel
    }()
    var imagePicker: ImagePicker!
    let imageAction = UITapGestureRecognizer()
    var user: User? {
        didSet {
            profileView.userNameLabel.text = user?.name
            if let contact = user?.contact {
                let first = String(contact).prefix(1)
                let main = String(contact).prefix(4).suffix(3)
                let last = String(contact).suffix(7)
                profileView.userPhoneLabel.text = "\(first) (\(main)) \(last)"
            }
            if let contract_number = user?.contract_number {
                profileView.contractView.textLabel.text = "\(contract_number)"
            }
            if let contract_type = user?.contract_type {
                profileView.typeContractView.textLabel.text = contract_type
            }
            if let requisites = user?.requisites {
                profileView.propsView.textLabel.text = requisites
            }
            if let image_path = user?.image_path {
                profileView.userImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
                profileView.userImageView.sd_setImage(with: Product.getImageUrl(url: image_path))
            }
        }
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        actionSwipeGestures()
        setupNavBar()
        setupViews()
        viewModel.auth()
    }
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
        navigationController?.setNavigationBarHidden(false, animated: animated)
        navigationItem.title = "Профиль"
        getBasketCount()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    // MARK: - SetupViews
    private func setupViews() {
        scrollView.backgroundColor = .white
        contentView.addSubview(mainView)
        
        mainView.snp.makeConstraints { (make) in
            make.bottom.right.top.left.equalToSuperview()
        }
        
        mainView.addSubviews(views: [profileView])
        profileView.snp.makeConstraints { (make) in
            make.top.right.left.bottom.equalToSuperview()
        }
    }
    
    fileprivate func setupNavBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightButton)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftButton)
    }

    func actionSwipeGestures() {
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes))
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes))
        
        imageAction.addTarget(self, action: #selector(imagePick))
        profileView.userImageView.addGestureRecognizer(imageAction)
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        leftSwipe.direction = .left
        rightSwipe.direction = .right
        
        contentView.addGestureRecognizer(leftSwipe)
        contentView.addGestureRecognizer(rightSwipe)
        
        scrollView.refreshControl = self.refreshControl
        self.refreshControl.addTarget(self, action: #selector(getFullUser), for: .valueChanged)
        
        let dismissKeyBoardTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        contentView.addGestureRecognizer(dismissKeyBoardTap)
    }
    
    // MARK: - Actions
    @objc override func handleSwipes(sender: UISwipeGestureRecognizer) {
        if (sender.direction == .left) {
            goToBusketView()
        } else if (sender.direction == .right) {
            settingsButtonAction()
        }
    }
    
    @objc func settingsButtonAction() {
        let vc = SettingsViewController()
        DispatchQueue.main.async {
            self.navigationController?.view.layer.add(CATransition().segueFromLeft(), forKey: nil)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func getFullUser() {
        viewModel.auth()
    }
    
    @objc func goToBusketView() {
        let vc = BasketViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func getBasketCount() {
        newsViewModel.getBasketCount()
    }
    
    @objc func imagePick(_ sender: UIButton) {
        self.imagePicker.present(from: sender)
    }
}

// MARK: - ProcessViewDelegate
extension ProfileViewController: ProcessViewDelegate {
    func updateUI() {
        self.user = viewModel.user
        refreshControl.endRefreshing()
    }
}

// MARK: - BasketCountDelegate
extension ProfileViewController: BasketCountDelegate {
    func updateCount(count: Int) {
        self.rightButton.countLabel.text = "\(count)"
    }
}

// MARK: - ImagePickerDelegate
extension ProfileViewController: ImagePickerDelegate {
    func didSelect(image: UIImage?) {
        guard let image = image else { return }
        guard let dataImage = image.jpegData(compressionQuality: 0.8) else { return }
        viewModel.userPhoto(parameters: ["image": dataImage])
    }
}
