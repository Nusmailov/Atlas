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
    lazy var discountCollectionView: DiscountCollectionView = {
        let view = DiscountCollectionView()
        view.delegate = self
        return view
    }()
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
    lazy var sortingCollectionView: ProductCategoryCollectionView = {
        let view = ProductCategoryCollectionView()
        view.collectionView.delegate = self
        view.collectionView.dataSource = self
        view.collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: "cell")
        return view
    }()
    lazy var newsViewModel: NewsViewModel = {
        let viewModel = NewsViewModel()
        viewModel.delegate = self
        viewModel.bannerDelegate = self
        viewModel.basketCountDelegate = self
        viewModel.categorySectionDelegate = self
        return viewModel
    }()
    lazy var favouriteViewModel: FavouriteViewModel = {
        let viewModel = FavouriteViewModel()
        viewModel.delegate = self
        return viewModel
    }()
    lazy var basketViewModel: BasketViewModel = {
        let viewModel = BasketViewModel()
        viewModel.delegate = self
        return viewModel
    }()
    
    let coordinator = NewsCoordinator()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        showLoader()
        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        navigationItem.title = "Главная"
        tabBarController?.tabBar.isHidden = false
        newsViewModel.getBasketCount()
        tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        self.navigationController?.hidesBarsOnSwipe = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    // MARK: - SetupViews
    func setupViews() {
        contentView.backgroundColor = .white
        scrollView.backgroundColor = .white
        let leftSwipe = UISwipeGestureRecognizer(target: self, action:#selector(handleSwipes) )
        leftSwipe.direction = .left
        view.addSubview(searchBarView)
        searchBarView.busketButton.addTarget(self, action: #selector(goToBusketView), for: .touchUpInside)
        refreshControl.addTarget(self, action: #selector(loadData), for: .valueChanged)
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
    }
    
    // MARK: - Actions
    func updateTableView() {
        tableView.snp.remakeConstraints { (make) in
            make.top.equalTo(discountCollectionView.snp.bottom).offset(12)
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(320 * newsViewModel.productKeys.count)
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
    
    @objc func loadData() {
        newsViewModel.getBannerList()
        newsViewModel.getCategoryList()
        newsViewModel.getProductList()
        newsViewModel.getBasketCount()
    }
}

// MARK: - UITableViewDelegate
extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsViewModel.productKeys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellProduct", for: indexPath) as! ProductTableViewCell
        let key = newsViewModel.productKeys[indexPath.row]
        cell.productView.setProducts(products: newsViewModel.productList[newsViewModel.productKeys[indexPath.row]]!)
        cell.productView.label.text = key
        cell.productView.delegate = self
        cell.productView.category_id = newsViewModel.sectionIdList[indexPath.item]
        return cell
    }
}

// MARK: - ProductOpenDelegate
extension NewsViewController: ProductDelegate {
    func openTwoDirectionVC(category_id: Int) {
        coordinator.routeTotalCategoryProduct(sections: newsViewModel.sectionList,
                                              row: -1, category_id: category_id, on: self)
    }
    
    func addToBasket(product_id: Int) {
        UIView.animate(withDuration: 1.0, animations: {
            self.searchBarView.busketButton.animationZoom(scaleX: 1.4, y: 1.4)
        }, completion: { _ in
            self.searchBarView.busketButton.animationZoom(scaleX: 1.0, y: 1.0)
        })
        basketViewModel.addToBasket(product_id: product_id)
    }
    
    func removeBasket(product_id: Int) {
        basketViewModel.removeBasket(product_id: product_id)
    }
    
    func addToFavorite(product_id: Int) {
        favouriteViewModel.addToFavorite(product_id: product_id)
    }
    
    func removeFavorite(product_id: Int) {
        favouriteViewModel.removeFavourite(product_id: product_id)
    }
    
    func didOpenDescriptionVC(product: Product) {
        coordinator.routeDescriptionOrder(product: product, on: self)
    }
}

// MARK: - SearchTextFieldDelegate
extension NewsViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        coordinator.routeTotalCategoryProduct(sections: newsViewModel.sectionList, row: 0, category_id: -3, on: self)
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
        searchBarView.searchTextField.text = ""
        coordinator.routeTotalCategoryProduct(sections: newsViewModel.sectionList, row: indexPath.item,
                                              category_id: newsViewModel.categoryIdList[indexPath.item], on: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
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
}

//MARK: - CategorySectionProcessDelegate
extension NewsViewController: CategorySectionProcessDelegate {
    func updateSectionCollectionView() {
        sortingCollectionView.setSectionList(sectionList: newsViewModel.sectionList)
        refreshControl.endRefreshing()
    }
}

//MARK: - ProductFavouriteDelegate
extension NewsViewController: ProcessViewDelegate {
    func updateUI() {
        newsViewModel.getBasketCount()
        updateTableView()
        tableView.reloadData()
    }
}

//MARK: - BasketCountDelegate
extension NewsViewController: BasketCountDelegate {
    func updateCount(count: Int) {
        searchBarView.busketButton.countLabel.text = "\(count)"
    }
}

extension UIView {
    func animationZoom(scaleX: CGFloat, y: CGFloat) {
        self.transform = CGAffineTransform(scaleX: scaleX, y: y)
    }
}
//MARK: - OpenWebDelegate
extension NewsViewController: OpenWebDelegate {
    func openWeb(url: URL) {
        UIApplication.shared.open(url)
    }
}
