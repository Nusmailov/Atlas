//
//  OrderTableViewCell.swift
//  Delivery
//
//  Created by Nurzhigit Smailov on 8/22/19.
//  Copyright © 2019 Nurzhigit Smailov. All rights reserved.
//

import UIKit

class OrderTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    lazy var orderTextLabel: UILabel = {
        let label = UILabel()
        label.font = .getMontserraMediumFont(on: 13)
        label.textColor = #colorLiteral(red: 0.2745098039, green: 0.2823529412, blue: 0.3333333333, alpha: 1)
        label.text = "Заказ №18965146 от 24.05.19"
        return label
    }()
    lazy var mainView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1
        view.layer.borderColor = #colorLiteral(red: 0.9568627451, green: 0.9607843137, blue: 0.9803921569, alpha: 1)
        view.backgroundColor = UIColor.whiteBlue
        return view
    }()
    lazy var statusOrderLabel: UILabel = {
        let label = UILabel()
        label.font = .getMontserraSemiBoldFont(on: 13)
        label.textColor = #colorLiteral(red: 1, green: 0.7529411765, blue: 0, alpha: 1)
        label.text = "Ожидает расмотрения"
        return label
    }()
    lazy var circleView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.backgroundColor = UIColor.whiteBlue
        return view
    }()
    fileprivate var order: Order! {
        didSet {
            statusOrderLabel.textColor = #colorLiteral(red: 1, green: 0.7529411765, blue: 0, alpha: 1)
            if order.status == 3 {
                statusOrderLabel.textColor = #colorLiteral(red: 0.137254902, green: 0.8549019608, blue: 0.5960784314, alpha: 1)
            } else if order.status == 4 {
                statusOrderLabel.textColor = .red
            }
            if order.type == "special" {
                circleView.backgroundColor = #colorLiteral(red: 0.1647058824, green: 0.5960784314, blue: 1, alpha: 1)
                orderTextLabel.text = "special" + " №\(order.id)"
            }
            statusOrderLabel.text = order.status_info
            let date = order.delivery_date?.prefix(10)
            guard let hour = order.delivery_hour else { return }
            orderTextLabel.text = "orderN №\(order.id) from \(date ?? "") \(hour)"
            circleView.backgroundColor = .white
        }
    }
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        backgroundColor = .white
        selectionStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setOrder(order: Order) {
        self.order = order
    }
    
    // MARK: - Setupviews
    func setupViews() {
        addSubview(mainView)
        mainView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(4)
            make.bottom.equalToSuperview().offset(-4)
            make.left.equalToSuperview().offset(8)
            make.right.equalToSuperview().offset(-8)
        }
        mainView.addSubviews(views: [orderTextLabel, statusOrderLabel, circleView])
        
        orderTextLabel.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        
        statusOrderLabel.snp.makeConstraints { (make) in
            make.top.equalTo(orderTextLabel.snp.bottom).offset(2)
            make.bottom.right.equalToSuperview().offset(-16)
            make.left.equalToSuperview().offset(16)
        }
        
        circleView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-16)
            make.height.width.equalTo(16)
        }
    }
    
}
