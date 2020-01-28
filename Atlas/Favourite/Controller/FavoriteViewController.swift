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
        
        collection.register(FavoriteCollectionViewCell.self, forCellWithReuseIdentifier: FavoriteCollectionViewCell.cellIdentifier())
        collection.delegate = self
        collection.dataSource = self
        
        collection.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        collection.showsVerticalScrollIndicator = false
        collection.showsHorizontalScrollIndicator = false
        
        return collection
    }()
    
    //MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupBackground()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        guard UIApplication.shared.applicationState == .inactive else {
            return
        }

//        setColors()
    }

    //MARK:- SetupViews
    func setupViews() -> Void {
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
    }
    
    func setupBackground() -> Void {
        view.backgroundColor = .white
        title = "Избранное"
    }
    
}
//MARK:- CollectionView Delegate/Datasource
extension FavoriteViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoriteCollectionViewCell.cellIdentifier(), for: indexPath) as! FavoriteCollectionViewCell
        cell.configure(item: indexPath.row)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = ProductViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //Heith/Width
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize.init(width: view.frame.width / 2 - 5, height: 275)
    }
    
}
