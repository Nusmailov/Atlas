//
//  FilterViewController.swift
//  Atlas
//
//  Created by Nurzhigit Smailov on 2/3/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import UIKit

class FilterViewController: ViewController {
    
    //MARK: - Properties
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(ProductCollectionCell.self, forCellWithReuseIdentifier: ProductCollectionCell.cellIdentifier())
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        collection.showsVerticalScrollIndicator = false
        collection.showsHorizontalScrollIndicator = false
        collection.alwaysBounceVertical = true
        return collection
    }()
    lazy var rightButton: BasketCountButton = {
        let button = BasketCountButton()
        button.addTarget(self, action: #selector(goToBasketView), for: .touchUpInside)
        return button
    }()
    lazy var sortingCollectionView: ProductCategoryCollectionView = {
        let view = ProductCategoryCollectionView()
        view.collectionView.delegate = self
        view.collectionView.dataSource = self
        view.collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: "cell")
        return view
    }()
    lazy var refreshControl: UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(updateData), for: .valueChanged)
        return refresh
    }()
    lazy var viewModel: FilterViewModel = {
        let viewModel = FilterViewModel()
        viewModel.delegate = self
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
    lazy var newsViewModel: NewsViewModel = {
        let viewModel = NewsViewModel()
        viewModel.basketCountDelegate = self
        return viewModel
    }()
    var sectionList = [Section]()
    var category_id: Int!
    var row: Int!
    var coordinator = NewsCoordinator()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        loadData(category_id: category_id)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightButton)
        title = "Результат поиска"
        newsViewModel.getBasketCount()
    }
    
    //MARK: - setupViews
    func setupViews() {
        view.addSubviews(views: [collectionView, sortingCollectionView])
        sortingCollectionView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.height.equalTo(60)
        }
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(sortingCollectionView.snp.bottom).offset(16)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    @objc func loadData(category_id: Int) {
        viewModel.getProduct(category_id: category_id, page: viewModel.page)
    }
    
    @objc func updateData() {
        viewModel.page = 1
        loadData(category_id: category_id)
    }
    
    @objc func goToBasketView() {
        coordinator.routeToBasket(on: self)
    }
    
}

//MARK: - UICollectionViewDelegate
extension FilterViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.sortingCollectionView.collectionView {
            return sectionList.count
        }
        return viewModel.productList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.sortingCollectionView.collectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CategoryCell
            cell.setSection(section: sectionList[indexPath.item])
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionCell.cellIdentifier(),
                                                      for: indexPath) as! ProductCollectionCell
        cell.tileView.setProduct(product: viewModel.productList[indexPath.item])
        cell.tileView.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.sortingCollectionView.collectionView {
            let text = sectionList[indexPath.row].section_name
            let cellWidth = text.size(withAttributes:[.font: UIFont.getMontserraSemiBoldFont(on: 12)]).width + 24.0
            return CGSize(width: cellWidth, height: 40.0)
        }
        return CGSize.init(width: view.frame.width / 2 - 5, height: 275)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if collectionView == self.collectionView {
            if indexPath.item == viewModel.productList.count - 1 && viewModel.max_page - 1 > viewModel.page {
                viewModel.page += 1
                loadData(category_id: category_id)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.sortingCollectionView.collectionView {
            category_id = sectionList[indexPath.item].id
            loadData(category_id: category_id)
        } else {
            coordinator.routeDescriptionOrder(product: viewModel.productList[indexPath.item], on: self)
        }
    }
}

//MARK: - ProcessViewDelegate
extension FilterViewController: ProcessViewDelegate {
    func updateUI() {
        self.refreshControl.endRefreshing()
        self.collectionView.reloadData()
    }
}

//MARK: - ProductDelegate
extension FilterViewController: ProductDelegate {
    func didOpenDescriptionVC(product: Product) {
        coordinator.routeDescriptionOrder(product: product, on: self)
    }
    
    func openTwoDirectionVC(category_id: Int, row: Int) { }
    
    func addToBasket(product_id: Int) {
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
}

//MARK: - BasketCountDelegates
extension FilterViewController: BasketCountDelegate {
    func updateCount(count: Int) {
        rightButton.countLabel.text = "\(count)"
    }
}
