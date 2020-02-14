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
    lazy var tableView: UITableView = {
        let tableview = UITableView()
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(BasketTableViewCell.self, forCellReuseIdentifier: BasketTableViewCell.cellIdentifier())
        tableview.separatorStyle = .none
        return tableview
    }()
    lazy var totalView: TotalBasketView = {
        let view = TotalBasketView()
        view.getButton.addTarget(self, action: #selector(checkoutBasket), for: .touchUpInside)
        return view
    }()
    lazy var viewModel: BasketViewModel = {
        let viewModel = BasketViewModel()
        viewModel.delegate = self
        return viewModel
    }()
    lazy var refreshControl: UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(getBasketList), for: .valueChanged)
        return refresh
    }()
    private var bottomConstraint: NSLayoutConstraint?
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        keyboardHeight()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "Корзина"
        tabBarController?.tabBar.isHidden = false
        showLoader()
        getBasketList()   
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel.updateBasket()
    }
    
    //MARK: - SetupViews
    private func setupViews() -> Void {
        tableView.refreshControl = refreshControl
        view.backgroundColor = .white
        view.addSubview(tableView)
        view.addSubview(totalView)
        tableView.keyboardDismissMode = .onDrag
        
        tableView.snp.makeConstraints { (make) in
            make.bottom.equalTo(-(tabBarController?.tabBar.bounds.height)!-48)
            make.left.top.right.equalToSuperview()
        }
        
        totalView.snp.makeConstraints { (make) in
            make.bottom.equalTo(-(tabBarController?.tabBar.bounds.height)!)
            make.left.right.equalToSuperview()
        }
    }
    
    //MARK: - Actions
    @objc func getBasketList() {
        viewModel.getBasketList()
    }
    
    @objc func checkoutBasket() {
        viewModel.updateBasket()
        let vc = CheckoutViewController()
        vc.setTotalPrice(totalPrice: viewModel.totalPrice())
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func handleKeyboard(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as AnyObject).cgRectValue
            let isKeyboardShowing = notification.name == UIResponder.keyboardWillShowNotification
            bottomConstraint?.constant = isKeyboardShowing ? -keyboardFrame!.height : 0
            UIView.animate(withDuration: 0.3, delay: 0, options: UIView.AnimationOptions.curveEaseOut, animations: {
                self.view.layoutIfNeeded()
            }, completion: { (completed) in })
        }
    }
    
    fileprivate func keyboardHeight() {
        bottomConstraint = NSLayoutConstraint(item: totalView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
        view.addConstraint(bottomConstraint!)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboard), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}

//MARK: - UITableViewDelegate
extension BasketViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.productList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BasketTableViewCell.cellIdentifier(),
                                                 for: indexPath) as! BasketTableViewCell
        cell.setBasketProduct(basketProduct: viewModel.productList[indexPath.row])
        cell.delegate = self
        cell.coundDelegate = self
        cell.index = indexPath.item
        return cell
    }
}

//MARK: - ChangedBasketCountDelegate
extension BasketViewController: ChangedBasketCountDelegate {
    func changedBasketCount(index: Int, count: Int) {
        viewModel.productList[index].product_quantity = count
        totalView.totalCountLabel.text = "\(viewModel.totalPrice())₸"
    }
}

//MARK: - ProductBasketDelegate
extension BasketViewController: ProcessViewDelegate {
    func updateUI() {
        if viewModel.productList.count == 0 {
            totalView.getButton.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
            totalView.getButton.isEnabled = false
        }else {
            totalView.getButton.backgroundColor = .mainColor
            totalView.getButton.isEnabled = true
        }
        totalView.totalCountLabel.text = "\(viewModel.totalPrice())₸"
        refreshControl.endRefreshing()
        tableView.reloadData()
    }
}

//MARK: - ProductBasketDelegate
extension BasketViewController: DeleteBasketDelegate {
    func deleteProductBasket(product_id: Int, index: Int) {
        viewModel.removeBasket(product_id: product_id)
        viewModel.productList.remove(at: index)
        tableView.deleteRows(at: [IndexPath(item: index, section: 0)], with: .automatic)
    }
}
