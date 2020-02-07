//
//  NewsCoordinator.swift
//  Atlas
//
//  Created by Nurzhigit Smailov on 1/30/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import Foundation
import UIKit

class NewsCoordinator {
    weak var baseViewController: UIViewController?
    
    func routeDescriptionOrder(product: Product, on baseVC: UIViewController) {
        baseViewController = baseVC
        let vc = ProductViewController(product: product)
        vc.setProduct(product: product)
        baseViewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func routeTotalCategoryProduct(text: String? = "", sections: [Section], row: Int, category_id: Int, on baseVC: UIViewController) {
        baseViewController = baseVC
        let vc = FilterViewController(category_id: category_id, text: text ?? "")
        vc.sectionList = sections
        vc.row = row
        baseViewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func routeToBasket(on baseVC: UIViewController) {
        baseViewController = baseVC
        let vc = BasketViewController()
        baseViewController?.navigationController?.pushViewController(vc, animated: true)
    }
}
