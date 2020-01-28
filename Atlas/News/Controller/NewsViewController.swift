//
//  NewsViewController.swift
//  Delivery
//
//  Created by Nurzhigit Smailov on 8/19/19.
//  Copyright © 2019 Nurzhigit Smailov. All rights reserved.
//

import UIKit

//var fullUser: User?

class NewsViewController: LoaderBaseViewController {
    
    // MARK: - Properties
    private let edge = 16
    lazy var discountCollectionView = DiscountCollectionView()
    private let searchController = UISearchController(searchResultsController: nil)
    lazy var searchBarView: SearcherView = {
        let search = SearcherView()
        search.searchTextField.delegate = self
        return search
    }()
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.separatorStyle = .none
        tableView.keyboardDismissMode = .onDrag
        tableView.isScrollEnabled = false
        return tableView
    }()
    lazy var typeProductCollectionView: CategoryCollectionView = {
        let view = CategoryCollectionView()
        view.isUserInteractionEnabled = true
        view.delegate = self
        return view
    }()
    var products = [Product]()
    var categoryList = [Cats]()
    var refreshControl = UIRefreshControl()
    var catsList = [Cats]()
    lazy var basketCountButton = BasketCountButton()
    
    // MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        navigationItem.title = "Главная"
        tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    // MARK: - SetupViews
    func setupViews() {
        contentView.backgroundColor = .white
        scrollView.backgroundColor = .white
        let leftSwipe = UISwipeGestureRecognizer(target: self, action:#selector(handleSwipes) )
        leftSwipe.direction = .left
        contentView.addGestureRecognizer(leftSwipe)
        
        view.addSubview(searchBarView)
        searchBarView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(UIApplication.shared.statusBarFrame.height)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(56)
        }
        
        scrollView.snp.remakeConstraints { (make) in
            make.top.equalTo(searchBarView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
        searchBarView.busketButton.addTarget(self, action: #selector(goToBusketView), for: .touchUpInside)
        scrollView.refreshControl = self.refreshControl
//        refreshControl.addTarget(self, action: #selector(updateData), for: .valueChanged)
        
        scrollView.addSubview(discountCollectionView)
        contentView.addSubview(typeProductCollectionView)
        typeProductCollectionView.delegate = self
        
        contentView.addSubview(tableView)

        discountCollectionView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()//(newsLabel.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(200)
        }
        typeProductCollectionView.snp.makeConstraints { (make) in
            make.top.equalTo(discountCollectionView.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview()
        }
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(typeProductCollectionView.snp.bottom)
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(0)
        }
    }
    
    // MARK: - Actions
    @objc override func handleSwipes(sender:UISwipeGestureRecognizer) {
        if (sender.direction == .left) {
            goToBusketView()
        }
    }
    
    @objc func settingsButtonAction() {
        let vc = SettingsViewController()
        DispatchQueue.main.async {
            self.navigationController?.view.layer.add(CATransition().segueFromLeft(), forKey: nil)
            self.navigationController?.pushViewController(vc, animated: false)
        }
    }
    
    @objc func goToBusketView() {
        let vc = BasketViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - Delegation Pattern
extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3 //categoryList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = ProductCollectionView()
        view.setProducts(products: categoryList[section].products ?? [])
        view.label.text = categoryList[section].name
        view.setPaginationInfo(category_id: categoryList[section].id)
        view.delegate = self
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 300
    }
}

// MARK: - SpecialOrderDelegate
extension NewsViewController: SpecialOrderDelegate {
    func didOpenSpecialOrderVC() {
//        let vc = SpecialOrderViewController(networkManager:  Router(parser: DefaultParserImpl()))
//        self.navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - ProductOpenDelegate
extension NewsViewController: ProductDelegate {
    func openTwoDirectionVC(products: [Product], category_id: Int) {
        
    }
    
    func addToBusket(product_id: Int) {
        
    }
    
    func addToFavorite(product_id: Int) {
        
    }
    
    func didOpenDescriptionVC(product: Product) {

    }
}

// MARK: - CategoryDelegate
extension NewsViewController: CategoryDelegate {
    func openCategoryProducts(products: [Product], category_id: Int) {
    }
    
    func getSub(id: Int) { }    
}

// MARK: - SearchTextFieldDelegate
extension NewsViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
}

// MARK: - UICollectionViewDelegate
extension NewsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CategoryCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: view.frame.width / 2 - 5, height: 275)
    }
}
