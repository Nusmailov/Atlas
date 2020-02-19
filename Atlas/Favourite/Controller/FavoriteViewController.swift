//
//  FavoriteViewController.swift
//  Atlas
//
//  Created by Tuigynbekov Yelzhan on 10/24/19.
//  Copyright © 2019 Yelzhan Tuigynbekov. All rights reserved.
//

import UIKit

class FavoriteViewController: ViewController {
    
    //MARK:- Properties
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
        
        return collection
    }()
    lazy var viewModel: FavouriteViewModel = {
        let viewModel = FavouriteViewModel()
        viewModel.delegate = self
        return viewModel
    }()
    lazy var basketViewModel: BasketViewModel = {
        let viewModel = BasketViewModel()
        viewModel.delegate = self
        return viewModel
    }()
    lazy var refreshControl: UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(updateList), for: .valueChanged)
        return refresh
    }()
    let coordinator = NewsCoordinator()
    
    //MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        showLoader()
        basketViewModel.getBasketList()
        setupViews()
        setupBackground()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        viewModel.page = 1
        getList(page: viewModel.page)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        guard UIApplication.shared.applicationState == .inactive else {
            return
        }
    }

    //MARK: - SetupViews
    func setupViews() -> Void {
        registerForPreviewing(with: self, sourceView: collectionView)
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        collectionView.refreshControl = refreshControl
    }
    
    func setupBackground() -> Void {
        view.backgroundColor = .white
        title = "Избранное"
    }
    
    @objc func getList(page: Int) {
        viewModel.getFavouriteList(page: page)
    }
    
    @objc func updateList() {
        basketViewModel.getBasketList()
        viewModel.page = 1
        viewModel.getFavouriteList(page: viewModel.page)
    }
}

//MARK:- CollectionView Delegate/Datasource
extension FavoriteViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.favouriteList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionCell.cellIdentifier(), for: indexPath) as! ProductCollectionCell
        cell.configure(item: indexPath.row)
        cell.tileView.setProduct(product: viewModel.favouriteList[indexPath.item])
        cell.tileView.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if viewModel.favouriteList.count > indexPath.item {
            coordinator.routeDescriptionOrder(product: viewModel.favouriteList[indexPath.item], on: self)
        } else {
            collectionView.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: view.frame.width / 2 - 5, height: 275)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.item == viewModel.favouriteList.count - 1 && viewModel.max_page - 1 > viewModel.page {
            viewModel.page += 1
            getList(page: viewModel.page)
        }
    }
}

//MARK: - ProductFavouriteDelegate
extension FavoriteViewController: ProcessViewDelegate {
    func updateUI() {
        self.refreshControl.endRefreshing()
        UIView.performWithoutAnimation {
            self.collectionView.reloadData()
        }
    }
}

//MARK: - ProductDelegate
extension FavoriteViewController: ProductDelegate {
    func openTwoDirectionVC(category_id: Int) { }
    
    func didOpenDescriptionVC(product: Product) { }
    
    func addToBasket(product_id: Int) {
        
        basketViewModel.addToBasket(product_id: product_id)
    }
    
    func removeBasket(product_id: Int) {
        basketViewModel.removeBasket(product_id: product_id)
    }
    
    func addToFavorite(product_id: Int) {
        viewModel.addToFavorite(product_id: product_id)
    }
    
    func removeFavorite(product_id: Int) {
        viewModel.removeFavourite(product_id: product_id)
    }
}

//MARK: - UIViewControllerPreviewingDelegate
extension FavoriteViewController: UIViewControllerPreviewingDelegate  {
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        if let indexPath = collectionView.indexPathForItem(at: location) {
            if viewModel.favouriteList.count > indexPath.item {
                let vc = ProductViewController(product: viewModel.favouriteList[indexPath.item])
                vc.setProduct(product: viewModel.favouriteList[indexPath.item])
                return vc
            } else {
                collectionView.reloadData()
            }
        }
        return nil
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        navigationController?.pushViewController(viewControllerToCommit, animated: true)
    }
}
