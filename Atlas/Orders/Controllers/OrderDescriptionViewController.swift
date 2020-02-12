//
//  OrderDescriptionViewController.swift
//  Delivery
//
//  Created by Nurzhigit Smailov on 8/22/19.
//  Copyright © 2019 Nurzhigit Smailov. All rights reserved.
//

import UIKit

class OrderDescriptionViewController: UIViewController {
    
    // MARK: - Properties
    lazy  var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(OrderProductTableViewCell.self, forCellReuseIdentifier: cellID)
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        tableView.separatorStyle = .none
        tableView.keyboardDismissMode = .onDrag
        return tableView
    }()
    fileprivate let cellID = "cellID"
    lazy var refreshControl: UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(updateData), for: .valueChanged)
        return refresh
    }()
    lazy var orderDescriptionView = OrderDescriptionView()
    var order_id: Int!
    fileprivate var order: Order! {
        didSet {
            let orderStatus = OrderStatus.init(rawValue: order.order_status)
            orderDescriptionView.dateOrderLabel.textColor = orderStatus?.textColor
            orderDescriptionView.dateOrderLabel.text = order.order_status_name
            orderDescriptionView.typeOrderLabel.text = order.order_type_name
            orderDescriptionView.overAllPriceOrderLabel.text = "\(order.cost_sum)₸"
        }
    }
    lazy var viewModel: OrderViewModel = {
        let viewModel = OrderViewModel()
        viewModel.delegate = self
        return viewModel
    }()
    
    // MARK: - Lifecycle
    init(order_id: Int) {
        self.order_id = order_id
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        viewModel.getById(order_id: order_id)
    }
    
    func setOrder(order: Order) {
        self.order = order
    }
    
    // MARK: - SetupViews
    func setupViews() {
        view.addSubview(tableView)
        view.backgroundColor = #colorLiteral(red: 0.9411764706, green: 0.9490196078, blue: 0.9568627451, alpha: 1)
        tableView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-50)
        }
        tableView.refreshControl = refreshControl
    }
    
    @objc func updateData() {
        viewModel.getById(order_id: order_id)
    }
}

// MARK: - TableViewDelegate
extension OrderDescriptionViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return orderDescriptionView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.basketList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! OrderProductTableViewCell
        cell.setBasketOrder(basketProduct: viewModel.basketList[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

// MARK: - ProcessViewDelegate
extension OrderDescriptionViewController: ProcessViewDelegate {
    func updateUI() {
        tableView.reloadData()
        refreshControl.endRefreshing()
    }
}
