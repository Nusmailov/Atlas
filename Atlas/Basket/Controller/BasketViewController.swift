//
//  BasketViewController.swift
//  Atlas
//
//  Created by Eldor Makkambayev on 1/7/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import UIKit

class BasketViewController: UIViewController {
    
    //MARK: - Properties
    lazy var tableView: UIView = {
        let tableview = UITableView()
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(BasketTableViewCell.self, forCellReuseIdentifier: BasketTableViewCell.cellIdentifier())
        tableview.separatorStyle = .none
        return tableview
    }()
    lazy var totalView = TotalBasketView()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "Корзина"
    }
    
    //MARK: - SetupViews
    private func setupViews() -> Void {
        view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.bottom.equalTo(-(tabBarController?.tabBar.bounds.height)!-48)
            make.left.top.right.equalToSuperview()
        }
        view.addSubview(totalView)
        totalView.snp.makeConstraints { (make) in
            make.bottom.equalTo(-(tabBarController?.tabBar.bounds.height)!)
            make.left.right.equalToSuperview()
        }
    }
}

//MARK: - UITableViewDelegate
extension BasketViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BasketTableViewCell.cellIdentifier(), for: indexPath) as! BasketTableViewCell
        cell.selectionStyle = .none
        return cell
    }
}
