//
//  ProfileViewController.swift
//  Delivery
//
//  Created by Nurzhigit Smailov on 8/19/19.
//  Copyright © 2019 Nurzhigit Smailov. All rights reserved.
//

import UIKit
//import SDWebImage

class ProfileViewController: ScrollViewController {
    
    // MARK: - Properties
    var isAddCard = false
    private var addressTableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.keyboardDismissMode = .onDrag
        tableView.backgroundColor = .white
        tableView.register(AddressTableViewCell.self, forCellReuseIdentifier: AddressTableViewCell.cellIdentifier())
        tableView.separatorStyle = .none
        tableView.layer.cornerRadius = 10
        return tableView
    }()
    private var cardTableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.keyboardDismissMode = .onDrag
        tableView.backgroundColor = .white
        tableView.register(CardTableViewCell.self, forCellReuseIdentifier: CardTableViewCell.cellIdentifier())
        tableView.separatorStyle = .none
        tableView.layer.cornerRadius = 10
        return tableView
    }()
    lazy var profileView: ProfileView = {
        let view = ProfileView()
        return view
    }()
    lazy var addAddressButton: AddButtonView = {
        let button = AddButtonView()
        button.buttonView.setTitle("Добавить новый адрес", for: .normal)
        return button
    }()
    lazy var addCardButton: AddButtonView = {
        let button = AddButtonView()
        button.buttonView.setTitle("Добавить новую карту", for: .normal)
        
        return button
    }()
    lazy var addressTextView = AddressTextView()
    lazy var cardTextView = CardTextView()
    lazy var mainView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        return view
    }()
    lazy var addNewAddressView: AddNewAddressView = {
        let view = AddNewAddressView()
        view.layer.cornerRadius = 10
        view.backgroundColor = .white
        return view
    }()
    lazy var profileTabBarView: ProfileTabBarView = {
        let view = ProfileTabBarView()
//        view.leftButton.addTarget(self, action: #selector(settingsButtonAction), for: .touchUpInside)
//        view.busketCountButton.addTarget(self, action: #selector(goToBusketView), for: .touchUpInside)
        return view
    }()
    
    var addresses = [Address]()
    var cards = [CloudCard]()
    var refreshControl = UIRefreshControl()
    let addressHeightContraint: CGFloat = CGFloat(54)
    let cardHeightContraint: CGFloat = CGFloat(54)
    var cities = [City]()
    var lat: Double = 0
    var lng: Double = 0
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
//    var busketCount = 0 {
//        didSet {
//            if busketCount != 0 {
//                profileTabBarView.busketCountButton.redView.isHidden = false
//                profileTabBarView.busketCountButton.countLabel.text = "\(busketCount)"
//            } else {
//                profileTabBarView.busketCountButton.redView.isHidden = true
//            }
//        }
//    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.backgroundColor = .white
        setupTableView()
        actionSwipeGestures()
        setupViews()
        setupAction()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
        navigationController?.setNavigationBarHidden(false, animated: animated)
        navigationItem.title = "Профиль"
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightButton)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftButton)
        getFullUser()
        getBasketCount()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateContraints()
    }
    
    // MARK: - SetupViews
    private func setupViews() {
        view.addSubview(profileTabBarView)
        profileTabBarView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(UIApplication.shared.statusBarFrame.height)
            make.left.right.equalToSuperview()
        }
        scrollView.snp.remakeConstraints { (make) in
            make.top.equalTo(profileTabBarView.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
        contentView.addSubview(mainView)
        
        mainView.snp.makeConstraints { (make) in
            make.bottom.right.top.left.equalToSuperview()
        }
        
        mainView.addSubviews(views: [profileView, addressTableView, cardTableView, addAddressButton,
                                addCardButton, addNewAddressView])
        profileView.snp.makeConstraints { (make) in
            make.top.right.left.equalToSuperview()
        }
        
        addNewAddressView.alpha = 0
        
        addNewAddressView.snp.makeConstraints { (make) in
            make.top.equalTo(addressTableView.snp.bottom)
            make.right.left.equalToSuperview()
            make.height.equalTo(0)
        }

        addAddressButton.snp.makeConstraints { (make) in
            make.top.equalTo(addNewAddressView.snp.bottom).offset(4)
            make.right.left.equalToSuperview()
        }
        
        addCardButton.snp.makeConstraints { (make) in
            make.top.equalTo(cardTableView.snp.bottom).offset(4)
            make.right.left.equalToSuperview()
            make.bottom.equalTo(contentView.snp.bottom).offset(-16)
        }
    }
    
    private func setupAction() -> Void {
        addAddressButton.buttonView.addTarget(self, action: #selector(addAddressShowHide), for: .touchUpInside)
        addNewAddressView.mapButton.addTarget(self, action: #selector(openMapVC), for: .touchUpInside)
        addCardButton.buttonView.addTarget(self, action: #selector(addCard), for: .touchUpInside)
    }
    
    fileprivate func setupTableView() {
        addressTableView.delegate = self
        addressTableView.dataSource = self
        cardTableView.delegate = self
        cardTableView.dataSource = self
    }
    
    func updateContraints() {
        addressTableView.snp.remakeConstraints { (make) in
            make.top.equalTo(profileView.snp.bottom).offset(16)
            make.right.left.equalToSuperview()
            make.height.equalTo(CGFloat(addresses.count) * self.addressHeightContraint + addressTableView.contentSize.height)
        }
        
        cardTableView.snp.remakeConstraints { (make) in
            make.top.equalTo(addAddressButton.snp.bottom).offset(16)
            make.right.left.equalToSuperview()
            make.height.equalTo(cardTableView.contentSize.height + (CGFloat(cards.count) * cardHeightContraint))
        }
    }

    func actionSwipeGestures() {
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes))
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes))
        
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
    @objc override func handleSwipes(sender:UISwipeGestureRecognizer) {
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
    
    @objc func openMapVC() {
        let vc = MapAddressViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
//    MARK: - Simple functions
    private func initialConstrains() -> Void {
        self.addAddressButton.buttonView.imageView?.transform = CGAffineTransform(scaleX: -1, y: 1)
        self.addNewAddressView.snp.remakeConstraints { (make) in
            make.top.equalTo(self.addressTableView.snp.bottom)
            make.right.left.equalToSuperview()
            make.height.equalTo(0)
        }
    }
    
    private func lastConstrains() -> Void {
        self.addAddressButton.buttonView.imageView?.transform = CGAffineTransform(scaleX: 1, y: -1)
        addNewAddressView.alpha = 1
        self.addNewAddressView.snp.remakeConstraints { (make) in
            make.top.equalTo(self.addressTableView.snp.bottom)
            make.right.left.equalToSuperview()
            make.height.equalTo(246)
        }
    }

    private func closeEntityView() -> Void {
        addNewAddressView.alpha = 0
        UIView.animate(withDuration: 0.5) {
            self.initialConstrains()
            self.view.layoutIfNeeded()
        }
    }
    
    private func openEntityView() -> Void {
        UIView.animate(withDuration: 0.5) {
            self.lastConstrains()
            self.view.layoutIfNeeded()
        }
    }

    @objc func getFullUser() {
        refreshControl.endRefreshing()
    }
    
    //MARK: - Functions
    @objc func addCard() {
        let vc = AddCardViewController()
        DispatchQueue.main.async { 
            self.navigationController?.view.layer.add(CATransition().segueFromTop(), forKey: nil)
            self.navigationController?.pushViewController(vc, animated: false)
        }
    }
    
    @objc func goToBusketView() {
        let vc = BasketViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func getBasketCount() { }
    
    @objc func addAddressShowHide() {
        self.isAddCard ? closeEntityView() : openEntityView()
        self.isAddCard.toggle()
    }
}

//MARK: - TableViewDelegate
extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableView == addressTableView ? 3 : 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == addressTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: AddressTableViewCell.cellIdentifier(), for: indexPath) as! AddressTableViewCell
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: CardTableViewCell.cellIdentifier(), for: indexPath) as! CardTableViewCell
            //            cell.setCard(card: cards[indexPath.item])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if tableView == addressTableView {
            return addressTextView
        }
        else {
            return cardTextView
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
