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
    let tableView = UITableView(frame: .zero, style: .grouped)
    fileprivate let cellID = "cellID"
    lazy var orderDescriptionView = OrderDescriptionView()
    lazy var specialAgreeView: SpecialAgreeView = {
        let view = SpecialAgreeView()
        view.delegate = self
        return view
    }()
    fileprivate var orderProducts = [ProductOrder]()
    fileprivate var order: Order! {
        didSet {
//            guard let hour = order.delivery_hour else { return }
//            orderDescriptionView.overAllPriceOrderLabel.text = "\(String(describing: order.total_price!)) \(localized(text: "tenge"))"
//            orderDescriptionView.dateOrderLabel.text = "\(String(describing: order.delivery_date!.prefix(10))) \(hour)"
//            orderDescriptionView.paymentTypeOrderLabel.text = "\(String(describing: order.pay_type_info ?? ""))"
//            guard let street = order.address?.street else { return }
//            guard let home = order.address?.home else { return }
//            
//            var address = "\(street) \(home)"
//            orderDescriptionView.addressOrderLabel.text = address
//            
//            guard let apartment = order.address?.apartment else { return }
//            address = "\(street) \(home) \(localized(text: "apartment")) \(apartment)"
//            orderDescriptionView.addressOrderLabel.text = address
        }
    }
    var isHeaderFooter = false
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupViews()
    }
    
    func setOrder(order: Order) {
        self.order = order
        self.orderProducts = order.products!
        guard var date = order.delivery_date else { return }
        date = String(date.prefix(10))
        navigationItem.title = "№\(order.id) \(date)"
    }
    
    // MARK: - SetupViews
    func setupViews() {
        view.addSubview(tableView)
        view.backgroundColor = #colorLiteral(red: 0.9411764706, green: 0.9490196078, blue: 0.9568627451, alpha: 1)
        tableView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-50)
        }
    }
    
    func setupTableView() {
        tableView.register(OrderProductTableViewCell.self, forCellReuseIdentifier: cellID)
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        tableView.separatorStyle = .none
        tableView.keyboardDismissMode = .onDrag
    }
}

// MARK: - TableViewDelegate
extension OrderDescriptionViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return isHeaderFooter == false ? orderDescriptionView : UIView()
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return isHeaderFooter == true ? specialAgreeView : UIView()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! OrderProductTableViewCell
//        cell.setProductOrder(productOrder: orderProducts[indexPath.item])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

//  MARK: - SpecialAgreeDelegate
extension OrderDescriptionViewController: SpecialAgreeDelegate {
    
    func agreeSpecial() {
//        specialRequest(state: 1)
    }
    
    func cancelSpecial() {
//        specialRequest(state: 0)
    }
    
//    func specialRequest(state: Int) {
//        let token = UserManager.getCurrentToken()!
//        let order_id = order.id
//        let accept_bool = state
//
//        let endpoints = Endpoints.acceptSpecialOrder(token: token, parameters: ["order_id": order_id,
//                                                                                "accept_bool": accept_bool])
//        networkManager.request(endpoints) {[weak self] (result: Result<GeneralResult<String?>>) in
//            DispatchQueue.main.async {
//                switch result {
//                case .failure(let error):
//                    self?.showErrorMessage(error)
//                case .success(_):
//                    if state == 0 {
//                        self?.specialAgreeView.agreeButton.backgroundColor = .lightGray
//                        self?.specialAgreeView.agreeButton.isEnabled = false
//                    }
//                    self!.specialAgreeView.cancelButton.backgroundColor = .lightGray
//                    self!.specialAgreeView.cancelButton.isEnabled = false
//                    if state == 1 {
//                        let vc = BuyBasketViewController()
//                        vc.allPrice = self!.order.total_price!
//                        vc.order_type = "special"
//                        vc.special_order_id = order_id
//                        self!.navigationController?.pushViewController(vc, animated: true)
//                    }
//                    else {
//                        self?.showSuccess(self!.localized(text: "cancelSpecial"))
//                    }
//                }
//            }
//        }
//    }
}
