//
//  BannerCollectionView.swift
//  Atlas
//
//  Created by Nurzhigit Smailov on 1/27/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import UIKit

class BannerCollectionView: UIView {
    
    // MARK: - Properties
    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 200)
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.delegate = self
        cv.dataSource = self
        cv.register(BannerCollectionViewCell.self, forCellWithReuseIdentifier: "cellId")
        cv.isScrollEnabled = true
        cv.isPagingEnabled = true
        cv.backgroundColor = .white
        cv.showsHorizontalScrollIndicator = false
        return cv
    }()
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.17, green: 0.18, blue: 0.2, alpha: 1)
//        label.font = UIFont(name: Font.mullerBold, size: 20)
        label.numberOfLines = 0
        return label
    }()
    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.17, green: 0.18, blue: 0.2, alpha: 1)
//        label.font = UIFont(name: Font.mullerBold, size: 15)
        label.textAlignment = .right
        label.adjustsFontSizeToFitWidth = false
        return label
    }()
    lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.73, green: 0.73, blue: 0.73, alpha: 1)
//        label.font = UIFont(name: Font.mullerRegular, size: 10)
        return label
    }()
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.73, green: 0.73, blue: 0.73, alpha: 1)
//        label.font = UIFont(name: Font.mullerRegular, size: 10)
        return label
    }()
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.17, green: 0.18, blue: 0.2, alpha: 0.8)
//        label.font = UIFont(name: Font.mullerRegular, size: 10)
        label.numberOfLines = 0
        return label
    }()
    lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
//        pageControl.backgroundColor = .red
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.currentPageIndicatorTintColor = .mainColor
//        pageControl.numberOfPages = sliders.count
        pageControl.isUserInteractionEnabled = false
        pageControl.hidesForSinglePage = true
        return pageControl
    }()
    lazy var heartButton: UIButton = {
        let button = UIButton()
//        button.setImage(UIImage(named: Media.heartLogo), for: .normal)
        button.backgroundColor = .white
        button.imageEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        button.layer.cornerRadius = 13
        //        button.addTarget(self, action: #selector(addToFavorite), for: .touchUpInside)
        return button
    }()
    let minLineSpace = 4
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    func setAdvertiseList(advertisementList: [Advertisement]) {
//        self.advertisementList = advertisementList
//        collectionView.reloadData()
//    }
    
    // MARK: - SetupViews
    func setupViews() {
        addSubviews(views: [collectionView, nameLabel, priceLabel, categoryLabel,
                     dateLabel, descriptionLabel, pageControl, heartButton])
        collectionView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(200)
        }
        
        heartButton.snp.makeConstraints { (make) in
            make.top.equalTo(collectionView.snp.top).offset(10)
            make.right.equalTo(collectionView.snp.right).offset(-10)
            make.height.width.equalTo(26)
        }
        
        pageControl.snp.makeConstraints { (make) in
           make.top.equalTo(collectionView.snp.bottom)
           make.centerX.width.equalToSuperview()
        }
        
        priceLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(nameLabel)
            make.right.equalTo(-16)
        }
        
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(pageControl.snp.bottom)
            make.left.equalTo(16)
            make.right.equalTo(priceLabel.snp.left).offset(-8)
        }
        
        dateLabel.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp.bottom).offset(2)
            make.right.equalTo(-16)
        }
        
        categoryLabel.snp.makeConstraints { (make) in
            make.top.equalTo(dateLabel)
            make.left.equalTo(16)
            make.right.equalTo(dateLabel.snp.left).offset(8)
        }
        
        descriptionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(categoryLabel.snp.bottom).offset(12)
            make.left.equalTo(16)
            make.bottom.right.equalTo(-16)
        }
    }
    
}

//MARK: - UICollectionViewDelegate
extension BannerCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as!  BannerCollectionViewCell
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width - CGFloat(minLineSpace), height: 220)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(minLineSpace)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: (CGFloat(minLineSpace / 2)),
                            bottom: 0, right: (CGFloat(minLineSpace / 2)))
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        guard let indexPath = collectionView.indexPathsForVisibleItems.first else {return}
        pageControl.currentPage = indexPath.item
    }
}
