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
        tableView.register(OrderTableViewCell.self, forCellReuseIdentifier: cellID)
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
    fileprivate let cellID = "cellID"
    lazy var historyView = HistoryView()
//    private var networkManager: NetworkManager
    private var orderList = [Order]()
    var refreshControl = UIRefreshControl()
    lazy var mainView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        return view
    }()
    var page = 1
    lazy var emptyView: EmptyView = {
        let view = EmptyView()
        view.text.text = "noOrder"
        return view
    }()
    
    // MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        navigationItem.title = "История заказов"
        tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    //MARK: - SetupViews
    func setupTableView() {
        view.addSubview(mainView)
        mainView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(8)
            make.bottom.equalToSuperview().offset(-8)
            make.left.right.equalToSuperview()
        }
        mainView.addSubview(tableView)
        mainView.addSubview(emptyView)
//        self.refreshControl.addTarget(self, action: #selector(getOrders), for: .valueChanged)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        emptyView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.center.equalToSuperview()
        }
        emptyView.isHidden = true
//        tableView.refreshControl = self.refreshControl
    }
    
    
    //MARK: - Request
//    @objc func getOrders() {
//        let token = UserManager.getCurrentToken()!
//        let endpoints = Endpoints.getOrders(token: token, page: page)
//        networkManager.request(endpoints) { [weak self] (result: Result<GeneralResult<OrderData?>>) in
//            self?.hideLoader()
//            switch result {
//            case .success(let order):
//                DispatchQueue.main.async {
//                    
//                    self?.orderList = order.result?.data ?? []
//                    self?.refreshControl.endRefreshing()
//                    self?.tableView.reloadData()
//                }
//            case .failure(let error):
//                DispatchQueue.main.async {
//                    self?.showErrorMessage(error)
//                }
//            }
//        }
//    }
}

//MARK: - TableViewDelegate
extension OrderViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section != 0 {
            emptyView.isHidden = 10 == 0 ? false : true
        }
        return section == 0 ? 0 : 10
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        return historyView
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! OrderTableViewCell
//        cell.setOrder(order: orderList[indexPath.item])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = OrderDescriptionViewController()
//        vc.setOrder(order: orderList[indexPath.item])
        self.navigationController?.pushViewController(vc, animated: true)
        
//        if orderList[indexPath.item].status == -1 {
//
//        }
//        else if orderList[indexPath.item].status == 1 {
//            let vc = OrderDescriptionViewController()
//            vc.isHeaderFooter = true
//            vc.specialAgreeView.cancelButton.isEnabled = false
//            vc.specialAgreeView.cancelButton.backgroundColor = .lightGray
//            vc.setOrder(order: orderList[indexPath.item])
//            vc.specialAgreeView.agreeButton.setTitle("pay", for:  .normal)
//            self.navigationController?.pushViewController(vc, animated: true)
//        }
//        else if orderList[indexPath.item].status == 0 {
//            let vc = OrderDescriptionViewController()
//            vc.isHeaderFooter = true
//            vc.setOrder(order: orderList[indexPath.item])
//            self.navigationController?.pushViewController(vc, animated: true)
//        }
//        else {
//            let vc = OrderDescriptionViewController()
//            vc.setOrder(order: orderList[indexPath.item])
//            self.navigationController?.pushViewController(vc, animated: true)
//        }
    }
}
