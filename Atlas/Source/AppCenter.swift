//
//  AppCenter.swift
//  Atlas
//
//  Created by Tuigynbekov Yelzhan on 10/18/19.
//  Copyright © 2019 Yelzhan Tuigynbekov. All rights reserved.
//

import UIKit
class AppCenter {
    
    var window: UIWindow = UIWindow()
    private var userDefaults = UserDefaults.standard
    static let shared = AppCenter()
    private init() {}
    
    func createWindow(window: UIWindow) -> Void {
        self.window = window
    }
    
    func start() -> Void {
        makeKeyAndVisible()
        makeRootController()
    }
    
    func makeKeyAndVisible() -> Void {
        window.makeKeyAndVisible()
        window.backgroundColor = .white
    }
    
    func makeRootController() -> Void {
        if UserManager.shared.getCurrentUser() != nil {
            let vc = TabBarViewController()
            setRootController(controller: vc)
        } else {
            let vc = LoginViewController().inNavigation()
            setRootController(controller: vc)
        }
    }
    
    func setRootController(controller: UIViewController) -> Void {
        window.rootViewController = controller
    }
    
    private func setupViewController() -> UIViewController {
        let vc =  UINavigationController(rootViewController: LoginViewController())
        
        return vc
    }
    
}
