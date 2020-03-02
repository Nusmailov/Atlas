//
//  OrderViewController.swift
//  Delivery
//
//  Created by Nurzhigit Smailov on 8/22/19.
//  Copyright © 2019 Nurzhigit Smailov. All rights reserved.
//

import UIKit

class OrderViewController: ViewController {
    
    // MARK: - Properties
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.register(OrderTableViewCell.self, forCellReuseIdentifier: "cellID")
        tableView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.separatorStyle = .none
        tableView.keyboardDismissMode = .onDrag
        tableView.backgroundColor = .white
        tableView.layer.cornerRadius = 10
        return tableView
    }()
    lazy var historyView = HistoryView()
    var refreshControl = UIRefreshControl()
    lazy var mainView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        return view
    }()
    lazy var emptyView: EmptyView = {
        let view = EmptyView()
        view.text.text = "Ваши заказы будут отображаться тут"
        return view
    }()
    lazy var viewModel: OrderViewModel = {
        let viewModel = OrderViewModel()
        viewModel.delegate = self
        return viewModel
    }()
    
    // MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.setNavigationBarHidden(false, animated: animated)
        navigationItem.title = "История заказов"
        tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        showLoader()
        viewModel.getOrderList()
    }
    
    //MARK: - SetupViews
    func setupViews() {
        registerForPreviewing(with: self, sourceView: tableView)

        view.addSubview(mainView)
        mainView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(8)
            make.bottom.equalToSuperview().offset(-8)
            make.left.right.equalToSuperview()
        }
        mainView.addSubview(tableView)
        mainView.addSubview(emptyView)
        self.refreshControl.addTarget(self, action: #selector(getOrders), for: .valueChanged)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        emptyView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.center.equalToSuperview()
        }
        emptyView.isHidden = true
        tableView.refreshControl = self.refreshControl
    }
    
    //MARK: - Request
    @objc func getOrders() {
        viewModel.getOrderList()
    }
}

//MARK: - TableViewDelegate
extension OrderViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section != 0 {
            emptyView.isHidden = viewModel.orderList.count == 0 ? false : true
        }
        return section == 0 ? 0 : viewModel.orderList.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath) as! OrderTableViewCell
        cell.setOrder(order: viewModel.orderList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = OrderDescriptionViewController(order_id: viewModel.orderList[indexPath.row].id)
        vc.setOrder(order: viewModel.orderList[indexPath.row])
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - ProcessViewDelegate
extension OrderViewController: ProcessViewDelegate {
    func updateUI() {
        tableView.reloadData()
        refreshControl.endRefreshing()
    }
}

//MARK: - UIViewControllerPreviewingDelegate
extension OrderViewController: UIViewControllerPreviewingDelegate  {
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        if let indexPath = tableView.indexPathForRow(at: location) {
            previewingContext.sourceRect = tableView.rectForRow(at: indexPath)
            let vc = OrderDescriptionViewController(order_id: viewModel.orderList[indexPath.row].id)
            vc.setOrder(order: viewModel.orderList[indexPath.row])
            return vc
        }
        return nil
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        navigationController?.pushViewController(viewControllerToCommit, animated: true)
    }
}
