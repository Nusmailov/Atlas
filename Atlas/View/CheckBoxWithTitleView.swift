//
//  CheckBoxWithTitleView.swift
//  Santo
//
//  Created by Eldor Makkambayev on 9/27/19.
//  Copyright © 2019 Eldor Makkambayev. All rights reserved.
//

import Foundation
import UIKit
import  BEMCheckBox

class CheckBoxWithTitleView: UIView {
    
    //MARK: - Properties
    var titleSize: Int
    var checkboxSize: Int
    var checkboxPosition: Side
    lazy var checkBox: BEMCheckBox = {
        let check = BEMCheckBox(frame: CGRect(x: 15, y: 530, width: 18, height: 18))
        check.on = false
        check.onTintColor = #colorLiteral(red: 0.9490196078, green: 0.9607843137, blue: 0.9764705882, alpha: 1)
        check.onCheckColor = .mainColor
        check.boxType = BEMBoxType.square
        check.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        check.onFillColor = #colorLiteral(red: 0.9490196078, green: 0.9607843137, blue: 0.9764705882, alpha: 1)
        check.offFillColor = #colorLiteral(red: 0.7843137255, green: 0.2039215686, blue: 0.2784313725, alpha: 0.7)
        check.onAnimationType = BEMAnimationType.bounce
        check.offAnimationType = BEMAnimationType.bounce
        
        return check
    }()
    lazy var titleLabel: UILabel = {
        var label = UILabel()
        label.text = "Title"
        label.font = .getMullerRegularFont(on: CGFloat(titleSize))
    
        return label
    }()

    //MARK: - Initialization
    init(title: String, chackboxSize: Int, titleSize: Int, checkboxPosition: Side) {
        self.titleSize = titleSize
        self.checkboxSize = chackboxSize
        self.checkboxPosition = checkboxPosition
        super.init(frame: .zero)
        self.titleLabel.text = title
        setupView()
    }
    
    //MARK: - Setup function
    private func setupView() -> Void {
        addSubview(checkBox)
        checkBox.snp.makeConstraints { (make) in
            make.width.height.equalTo(16)
            if checkboxPosition == .left{
                make.centerY.left.equalToSuperview()
            } else {
                make.centerY.right.equalToSuperview()
            }
        }
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(checkBox)
            if checkboxPosition == .left{
                make.left.equalTo(checkBox.snp.right).offset(6)
                make.right.equalToSuperview()
            } else {
                make.right.equalTo(checkBox.snp.left).offset(-6)
                make.left.equalToSuperview()
            }
            make.top.bottom.equalToSuperview()
        }

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
