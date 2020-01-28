//
//  EmptyView.swift
//  Delivery
//
//  Created by Nurzhigit Smailov on 9/9/19.
//  Copyright © 2019 Nurzhigit Smailov. All rights reserved.
//

import UIKit

class EmptyView: UIView {
    
    // MARK: - Properties
    lazy var text: UILabel = {
        let label = UILabel()
        label.font = .getMullerRegularFont(on: 18)
        label.textColor = #colorLiteral(red: 0.3176470588, green: 0.3607843137, blue: 0.4352941176, alpha: 1)
        label.textAlignment = .center
        return label
    }()
    lazy var message: UILabel = {
        let label = UILabel()
        label.font = .getMullerRegularFont(on: 15)
        label.textColor = #colorLiteral(red: 0.3176470588, green: 0.3607843137, blue: 0.4352941176, alpha: 1)
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        backgroundColor = #colorLiteral(red: 0.9411764706, green: 0.9490196078, blue: 0.9568627451, alpha: 1)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - SetupViews
    fileprivate func setupViews() {
        addSubview(text)
        text.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
    }
}
