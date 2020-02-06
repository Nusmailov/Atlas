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
    lazy var imageCollectionView: BannerCollectionView = {
        let view = BannerCollectionView()
        return view
    }()
    lazy var rightButton: BasketCountButton = {
        let button = BasketCountButton()
        button.addTarget(self, action: #selector(goToBasketView), for: .touchUpInside)
        return button
    }()
    lazy var productView: ProductCollectionView = {
        let view = ProductCollectionView()
        view.delegate = self
        return view
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
    var product: Product! {
        didSet {
            
        }
    }
    
    //MARK: - Lifecycle
    init(product: Product) {
        super.init(nibName: nil, bundle: nil)
        self.product = product
        imageCollectionView.setProduct(product: product)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightButton)
    }

    //MARK: - SetupViews
    func setupViews() {
        contentView.addSubviews(views: [imageCollectionView, productView])

        imageCollectionView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
        }
        productView.snp.makeConstraints { (make) in
            make.top.equalTo(imageCollectionView.snp.bottom).offset(8)
            make.bottom.left.right.equalToSuperview()
        }
    }
    
    @objc func goToBasketView() {
        let vc = BasketViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - ProcessViewDelegate
extension ProductViewController: ProcessViewDelegate {
    func updateUI() {
        imageCollectionView.collectionView.reloadData()
    }
}

//MARK: - ProductDelegate
extension ProductViewController: ProductDelegate {
    func didOpenDescriptionVC(product: Product) {
        
    }
    
    func openTwoDirectionVC(category_id: Int) {
        
    }
    
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
