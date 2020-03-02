//
//  ProductViewController.swift
//  Atlas
//
//  Created by Nurzhigit Smailov on 1/27/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import UIKit
import SDWebImage

class ProductViewController: ScrollViewController {
    
    //MARK: - Properties
    var basketAddedBlock:  (() ->  ())?
    lazy var imageCollectionView: ProductDescriptionView = {
        let view = ProductDescriptionView()
        view.imageDelegate = self
        view.heartButton.addTarget(self, action: #selector(addToFavourite), for: .touchUpInside)
        view.buyButton.addTarget(self, action: #selector(addToBasketByCount), for: .touchUpInside)
        view.checkButton.addTarget(self, action: #selector(checkPrimary), for: .touchUpInside)
        return view
    }()
    lazy var rightButton: BasketCountButton = {
        let button = BasketCountButton()
        button.addTarget(self, action: #selector(goToBasketView), for: .touchUpInside)
        return button
    }()
    lazy var productListView: ProductCollectionView = {
        let view = ProductCollectionView()
        view.delegate = self
        view.label.text = "C этим покупают"
        return view
    }()
    lazy var favouriteViewModel: FavouriteViewModel = {
        let viewModel = FavouriteViewModel()
        viewModel.delegate = self
        viewModel.updateDelegate = self
        return viewModel
    }()
    lazy var newsViewModel: NewsViewModel = {
        let viewModel = NewsViewModel()
        viewModel.basketCountDelegate = self
        return viewModel
    }()
    lazy var basketViewModel: BasketViewModel = {
        let viewModel = BasketViewModel()
        viewModel.delegate = self
        return viewModel
    }()
    lazy var productViewModel: ProductViewModel = {
        let viewModel = ProductViewModel()
        viewModel.delegate = self
        return viewModel
    }()
    lazy var refreshControl: UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(updateData), for: .valueChanged)
        return refresh
    }()
    var product: Product! {
        didSet {
            imageCollectionView.descriptionLabel.text = product.product_description
            imageCollectionView.nameLabel.text = product.product_name
            imageCollectionView.priceLabel.text = "\(product.product_price) ₸ м2"
            imageCollectionView.sizeLabel.text = "\(product.product_length)x\(product.product_width) м2"
            let heart = FavoriteModel.shared.favoriteList[product.id] == true ? UIImage(named: "Path 8890.1") : UIImage(named: "emptyHeart")
            imageCollectionView.heartButton.setImage(heart, for: .normal)
            imageCollectionView.collectionView.reloadData()
            title = product.product_name
        }
    }
    var coordinator = NewsCoordinator()
    var imageCoordinator = ImageCoordinator()
    
    //MARK: - Lifecycle
    init(product: Product) {
        super.init(nibName: nil, bundle: nil)
        self.product = product
        imageCollectionView.setProduct(product: product)
        productListView.category_id = self.product.id
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        updateData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightButton)
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    //MARK: - SetupViews
    func setProduct(product: Product) {
        self.product = product
    }
    
    func setupViews() {
        contentView.addSubviews(views: [imageCollectionView, productListView])
        
        imageCollectionView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
        }
        
        productListView.snp.makeConstraints { (make) in
            make.top.equalTo(imageCollectionView.snp.bottom).offset(16)
            make.bottom.left.right.equalToSuperview()
        }
    }
    
    //MARK: - Actions
    @objc func goToBasketView() {
        let vc = BasketViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func basketAnimate() {
        UIView.animate(withDuration: 1.0, animations: {
            self.rightButton.animationZoom(scaleX: 1.4, y: 1.4)
        }, completion: { _ in
            self.rightButton.animationZoom(scaleX: 1.0, y: 1.0)
        })
    }
    
    @objc func updateData() {
        productViewModel.getByList(product_id: product.id)
        newsViewModel.getBasketCount()
    }
    
    @objc func addToFavourite() {
        if self.product.in_favorite == true {
            favouriteViewModel.removeFavourite(product_id: product.id)
        } else {
            favouriteViewModel.addToFavorite(product_id: product.id)
        }
    }
    
    @objc func addToBasketByCount() {
        guard imageCollectionView.quantityView.valueTextField.text != "" else {
            showErrorMessage("Укажите количество")
            return
        }
        basketAnimate()
        let count = Int(imageCollectionView.quantityView.valueTextField.text!)
        basketViewModel.addToBasket(product_id: product.id, count: count!)
    }
    
    override var previewActionItems: [UIPreviewActionItem] {
        let action = UIPreviewAction(title: "Добавить в корзину", style: .default) {[unowned self] (action, viewController) in
            self.basketViewModel.addToBasket(product_id: self.product.id)
        }
        let action2 = UIPreviewAction(title: "Добавить в избранные", style: .default) {[unowned self] (action, viewController) in
            self.favouriteViewModel.addToFavorite(product_id: self.product.id)
        }
        return [action, action2]
    }
    
    @objc func checkPrimary() {
        
    }
}

//MARK: - ProcessViewDelegate
extension ProductViewController: ProcessViewDelegate {
    func updateUI() {
        self.basketAddedBlock?()
        newsViewModel.getBasketCount()
        productListView.setProducts(products: productViewModel.productList)
        imageCollectionView.collectionView.reloadData()
        productListView.collectionView.reloadData()
    }
}

//MARK: - ProductDelegate
extension ProductViewController: ProductDelegate {
    func didOpenDescriptionVC(product: Product) {
        coordinator.routeDescriptionOrder(product: product, on: self)
    }
    
    func openTwoDirectionVC(category_id: Int) {
        coordinator.routeTotalCategoryProduct(sections: [], row: -1, category_id: product.id, on: self)
    }
    
    func addToBasket(product_id: Int) {
        basketAnimate()
        newsViewModel.getBasketCount()
        basketViewModel.addToBasket(product_id: product_id)
    }
    
    func removeBasket(product_id: Int) {
        basketAnimate()
        newsViewModel.getBasketCount()
        basketViewModel.removeBasket(product_id: product_id)
    }
    
    func addToFavorite(product_id: Int) {
        favouriteViewModel.addToFavorite(product_id: product_id)
    }
    
    func removeFavorite(product_id: Int) {
        favouriteViewModel.removeFavourite(product_id: product_id)
    }
}

//MARK: - BasketCountDelegate
extension ProductViewController: BasketCountDelegate {
    func updateCount(count: Int) {
        rightButton.countLabel.text = "\(count)"
    }
}

//MARK: - OpenImageDelegate
extension ProductViewController: OpenImageDelegate {
    func openImage(image_url: String) {
        imageCoordinator.routeImageViewContoller(image_path: image_url, on: self)
    }
}

//MARK: - UpdateProductDelegate
extension ProductViewController: UpdateProductDelegate {
    func addedFavorite() {
        let product = self.product
        product?.in_favorite = true
        self.product = product
    }
    
    func removedFavorite() {
        let product = self.product
        product?.in_favorite = false
        self.product = product
    }
}
