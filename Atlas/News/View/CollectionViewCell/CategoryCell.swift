//
//  CategoryCollectionViewCell.swift
//  Delivery
//
//  Created by Nurzhigit Smailov on 9/10/19.
//  Copyright © 2019 Nurzhigit Smailov. All rights reserved.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    
    // MARK: - Properties
    lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.font = .getMullerRegularFont(on: 16)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0.3176470588, green: 0.3607843137, blue: 0.4352941176, alpha: 1)
        return label
    }()
    lazy var mainView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.backgroundColor = .white
        return view
    }()
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
            mainView.backgroundColor = #colorLiteral(red: 0.1647058824, green: 0.5960784314, blue: 1, alpha: 1)
            categoryLabel.textColor = .white
            } else {
                mainView.backgroundColor = .white
                categoryLabel.textColor = .black
            }
        }
    }
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        backgroundColor = .clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - SetupViews
    func setupViews() {
        addSubview(mainView)
        mainView.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview()
            make.right.bottom.equalToSuperview()
        }
        mainView.addSubview(categoryLabel)
        categoryLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(40)
            make.width.lessThanOrEqualTo(self.frame.width * 1.25)
        }
        categoryLabel.sizeToFit()
    }
}
