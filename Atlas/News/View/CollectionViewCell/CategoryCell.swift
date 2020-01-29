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
        label.font = .getMontserraSemiBoldFont(on: 12)
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = UIColor(red: 0.267, green: 0.267, blue: 0.267, alpha: 1)
        return label
    }()
    lazy var mainView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.backgroundColor = .whiteBlue
        return view
    }()
    
    override var isHighlighted: Bool {
        didSet {
            mainView.backgroundColor = isHighlighted ? .mainColor : .whiteBlue
            categoryLabel.textColor = isHighlighted ? .white : UIColor(red: 0.267, green: 0.267, blue: 0.267, alpha: 1)
        }
    }
    var section: Section! {
        didSet {
            categoryLabel.text = section.section_name
        }
    }
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setSection(section: Section) {
        self.section = section
    }
    
    // MARK: - SetupViews
    func setupViews() {
        addSubview(mainView)
        mainView.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview()
            make.right.bottom.equalToSuperview()
            make.width.lessThanOrEqualTo(self.frame.width * 1.25)
        }
        mainView.addSubview(categoryLabel)
        categoryLabel.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().offset(8)
            make.bottom.right.equalToSuperview().offset(-8)
        }
    }
}
