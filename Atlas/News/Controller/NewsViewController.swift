//
//  NewsViewController.swift
//  Delivery
//
//  Created by Nurzhigit Smailov on 8/19/19.
//  Copyright © 2019 Nurzhigit Smailov. All rights reserved.
//

import UIKit

class NewsViewController: LoaderBaseViewController {
    
    // MARK: - Properties
    lazy var discountCollectionView = DiscountCollectionView()
    private let searchController = UISearchController(searchResultsController: nil)
    lazy var searchBarView: SearcherView = {
        let search = SearcherView()
        search.searchTextField.delegate = self
        return search
    }()
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(ProductTableViewCell.self, forCellReuseIdentifier: "cellProduct")
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.separatorStyle = .none
        tableView.keyboardDismissMode = .onDrag
        tableView.isScrollEnabled = false
        return tableView
    }()
    var refreshControl = UIRefreshControl()
    lazy var basketCountButton = BasketCountButton()
    lazy  var sortingCollectionView: ProductCategoryCollectionView = {
        let view = ProductCategoryCollectionView()
        view.collectionView.delegate = self
        view.collectionView.dataSource = self
        view.collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: "cell")
        return view
    }()
    lazy var newsViewModel: NewsViewModel = {
        let viewModel = NewsViewModel()
        viewModel.bannerDelegate = self
        viewModel.categorySectionDelegate = self
        return viewModel
    }()
    
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
        loadData()
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
        view.addSubview(searchBarView)
        searchBarView.busketButton.addTarget(self, action: #selector(goToBusketView), for: .touchUpInside)
        scrollView.refreshControl = self.refreshControl
        contentView.addGestureRecognizer(leftSwipe)
        scrollView.addSubview(discountCollectionView)
        contentView.addSubviews(views: [tableView, sortingCollectionView])
        
        searchBarView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(UIApplication.shared.statusBarFrame.height)
            make.left.right.equalToSuperview()
            make.height.equalTo(56)
        }
        scrollView.snp.remakeConstraints { (make) in
            make.top.equalTo(searchBarView.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
        sortingCollectionView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
        }
        discountCollectionView.snp.makeConstraints { (make) in
            make.top.equalTo(sortingCollectionView.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(240)
        }
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(discountCollectionView.snp.bottom).offset(12)
            make.left.right.bottom.equalToSuperview()
        }
        updateTableView()
    }
    
    // MARK: - Actions
    func updateTableView() {
        tableView.snp.remakeConstraints { (make) in
            make.top.equalTo(discountCollectionView.snp.bottom).offset(12)
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(300 * 4)
        }
    }
    
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
    
    func loadData() {
        newsViewModel.getBannerList()
        newsViewModel.getCategoryList()
    }
}

// MARK: - Delegation Pattern
extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellProduct", for: indexPath) as! ProductTableViewCell
        cell.productView.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 300
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
        return newsViewModel.sectionList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CategoryCell
        cell.setSection(section: newsViewModel.sectionList[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let text = newsViewModel.sectionList[indexPath.row].section_name
        let cellWidth = text.size(withAttributes:[.font: UIFont.getMontserraSemiBoldFont(on: 12)]).width + 24.0
        return CGSize(width: cellWidth, height: 40.0)
    }
}

//MARK: - BannerProcessDelegate
extension NewsViewController: BannerProcessDelegate {
    func updateBannerCollectionView() {
        self.discountCollectionView.setNews(newsList: newsViewModel.newsList)
    }
    
    func updateUI() {
        tableView.reloadData()
    }
}

//MARK: - CategorySectionProcessDelegate
extension NewsViewController: CategorySectionProcessDelegate {
    func updateSectionCollectionView() {
        sortingCollectionView.setSectionList(sectionList: newsViewModel.sectionList)
    }
}
