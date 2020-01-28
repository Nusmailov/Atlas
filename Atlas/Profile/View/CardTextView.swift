//
//  CardTextView.swift
//  Delivery
//
//  Created by Nurzhigit Smailov on 8/26/19.
//  Copyright © 2019 Nurzhigit Smailov. All rights reserved.
//

import UIKit

class CardTextView: UIView {
    // MARK: - Properties
    lazy var cardLabel:  UILabel = {
        let label = UILabel()
        label.font = .getMullerBoldFont(on: 18)
        label.textColor = #colorLiteral(red: 0.3176470588, green: 0.3607843137, blue: 0.4352941176, alpha: 1)
        label.text = "Привязанные карты"
        
        return label
    }()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - SetupViews
    func setupViews() {
        addSubview(cardLabel)
        cardLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(8)
            make.left.equalToSuperview().offset(16)
            make.right.bottom.equalToSuperview().offset(-8)
        }
    }
}
