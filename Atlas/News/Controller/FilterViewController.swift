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
    lazy var searchFilterView: SearchFilterView = {
        let view = SearchFilterView()
        view.textField.delegate = self
        
        return view
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
        refresh.addTarget(self, action: #selector(updateByCategory), for: .valueChanged)
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
    var indexBool = false
    var selectedIndex = -1
    var text = ""
    
    init(category_id: Int, text: String? = "") {
        super.init(nibName: nil, bundle: nil)
        self.category_id = category_id
        self.text = text ?? ""
        self.searchFilterView.textField.text = text ?? ""
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        view.backgroundColor = .white
        showLoader()
        updateByCategory()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightButton)
        title = "Результат поиска"
        newsViewModel.getBasketCount()
    }
    
    //MARK: - setupViews
    func setupViews() {
        view.addSubviews(views: [collectionView, searchFilterView, sortingCollectionView])
        searchFilterView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview()
        }
        sortingCollectionView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(searchFilterView.snp.bottom)
            make.height.equalTo(60)
        }
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(sortingCollectionView.snp.bottom).offset(16)
            make.left.right.bottom.equalToSuperview()
        }
        collectionView.keyboardDismissMode = .onDrag
        sortingCollectionView.collectionView.keyboardDismissMode = .onDrag
        collectionView.refreshControl = refreshControl
    }
    
    //MARK: - Actions
    @objc func loadData(category_id: Int) {
        viewModel.getProduct(category_id: category_id, page: viewModel.page)
    }
    
    @objc func updateData() {
        viewModel.page = 1
        updateByCategory()
    }
    
    @objc func goToBasketView() {
        coordinator.routeToBasket(on: self)
    }
    
    @objc func updateByCategory() {
        
        if category_id == -2 {
            viewModel.getPopularProducts()
        }
        else if category_id == -3 {
            hideLoader()
            searchFilterView.textField.becomeFirstResponder()
        }
        else if category_id != -1 {
            loadData(category_id: category_id)
        }
            
        else {
            viewModel.getSearch(parameters: ["text" : text])
        }
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
            searchFilterView.textField.text = ""
            loadData(category_id: category_id)
        } else {
            coordinator.routeDescriptionOrder(product: viewModel.productList[indexPath.item], on: self)
        }
    }
}

//MARK: - ProcessViewDelegate
extension FilterViewController: ProcessViewDelegate {
    func updateUI() {
        newsViewModel.getBasketCount()
        self.refreshControl.endRefreshing()
        self.collectionView.reloadData()
    }
}

//MARK: - ProductDelegate
extension FilterViewController: ProductDelegate {
    func openTwoDirectionVC(category_id: Int) { }
    
    func didOpenDescriptionVC(product: Product) {
        coordinator.routeDescriptionOrder(product: product, on: self)
    }
    
    func addToBasket(product_id: Int) {
        UIView.animate(withDuration: 1.0, animations: {
            self.rightButton.animationZoom(scaleX: 1.4, y: 1.4)
        }, completion: { _ in
            self.rightButton.animationZoom(scaleX: 1.0, y: 1.0)
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
}

//MARK: - BasketCountDelegates
extension FilterViewController: BasketCountDelegate {
    func updateCount(count: Int) {
        rightButton.countLabel.text = "\(count)"
    }
}

//MARK: - UITextViewDelegate
extension FilterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let text = searchFilterView.textField.text!
        dismissKeyboard()
        var parameters = ["text" : text, "section_id" : category_id!] as [String : Any]
        if category_id == -1 || category_id == -3 {
            parameters.removeValue(forKey: "section_id")
        }
        
        viewModel.getSearch(parameters: parameters)
        return true
    }
}
