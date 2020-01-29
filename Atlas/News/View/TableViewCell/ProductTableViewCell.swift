//
//  ProductTableViewCell.swift
//  Atlas
//
//  Created by Nurzhigit Smailov on 1/29/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    //MARK: - Properties
    lazy var productView: ProductCollectionView = {
        let view = ProductCollectionView()
        return view
    }()
    
    //MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    //MARK: - SetupViews
    func setupViews() {
        addSubview(productView)
        productView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}
