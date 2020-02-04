//
//  FavoriteCollectionViewCell.swift
//  Atlas
//
//  Created by Tuigynbekov Yelzhan on 10/24/19.
//  Copyright © 2019 Yelzhan Tuigynbekov. All rights reserved.
//

import UIKit

class ProductCollectionCell: UICollectionViewCell {
    
    //MARK:- Properties
    lazy var tileView: TileView = {
        let tileView = TileView()
        
        return tileView
    }()
    override var isHighlighted: Bool {
        didSet {
            tileView.buyButton.backgroundColor = isHighlighted ? .white : .mainColor
            tileView.backgroundColor = isHighlighted ? #colorLiteral(red: 1, green: 0.576224193, blue: 0.6157098481, alpha: 1) : .whiteGray
            tileView.buyButton.titleLabel?.textColor = isHighlighted ? .mainColor : .white
        }
    }
    
    //MARK:- Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- SetupViews
    func setupViews() -> Void {
        setupLeftView()
        backgroundColor = .white
    }
    
    func setupLeftView() -> Void {
        addSubview(tileView)
        tileView.snp.remakeConstraints { (make) in
            make.top.equalTo(5)
            make.left.equalTo(8)
            make.bottom.equalTo(-5)
            make.right.equalTo(-2)
        }
    }
        
    func setupRightView() -> Void {
        addSubview(tileView)
        tileView.snp.remakeConstraints { (make) in
            make.top.equalTo(5)
            make.left.equalTo(2)
            make.bottom.equalTo(-5)
            make.right.equalTo(-8)
        }
    }
    
    //MARK:- Configure
    func configure(item: Int) -> Void {
        if item % 2 == 0 {
            setupLeftView()
        } else {
            setupRightView()
        }
    }
}
