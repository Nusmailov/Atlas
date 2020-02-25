//
//  ImageCoordinator.swift
//  Atlas
//
//  Created by Nurzhigit Smailov on 2/7/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import Foundation
import UIKit


class ImageCoordinator {
    weak var baseViewController: UIViewController?
    
    func routeImageViewContoller(image_path: String, on baseVC: UIViewController){
        baseViewController = baseVC
//        let vc = ImageViewController()
//        vc.path = image_path
//        self.baseViewController?.navigationController?.pushViewController(vc, animated: true)
        let vc = ImageScrollViewController()
        vc.image_path = image_path
        self.baseViewController?.navigationController?.pushViewController(vc, animated: true)
    }
}
