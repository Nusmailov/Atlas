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
        let vc = ProductViewController()
        baseViewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
}
