//
//  TabBarViewController.swift
//  Atlas
//
//  Created by Tuigynbekov Yelzhan on 10/24/19.
//  Copyright © 2019 Yelzhan Tuigynbekov. All rights reserved.
//

import UIKit
class TabBarViewController: UITabBarController {
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBarItems()
        self.tabBar.tintColor = #colorLiteral(red: 0.7843137255, green: 0.2039215686, blue: 0.2784313725, alpha: 1)
    }
    
    //MARK:- SetupTabbarItems
    func setupTabBarItems() -> Void {
        let favorite = FavoriteViewController().inNavigation()
        favorite.tabBarItem.title = "Избранное"
        favorite.tabBarItem.image = #imageLiteral(resourceName: "Half-heart")
        favorite.tabBarItem.imageInsets = UIEdgeInsets(top: 35, left: 35, bottom: 35, right: 35)
        
        let profile = ProfileViewController().inNavigation()
        profile.tabBarItem.title = "Профиль"
        profile.tabBarItem.image = #imageLiteral(resourceName: "Group 8824")
        profile.tabBarItem.imageInsets = UIEdgeInsets(top: 35, left: 35, bottom: 35, right: 35)
        
        let orders = OrderViewController().inNavigation()
        orders.tabBarItem.title = "Заказы"
        orders.tabBarItem.image = #imageLiteral(resourceName: "Clipboard")
        orders.tabBarItem.imageInsets = UIEdgeInsets(top: 35, left: 35, bottom: 35, right: 35)
        
        let contacts = ContactViewController()
        let contactsNavController = UINavigationController(rootViewController: contacts)
        contactsNavController.tabBarItem.title = "Контакты"
        contactsNavController.tabBarItem.image = #imageLiteral(resourceName: "Mail opened")
        contactsNavController.tabBarItem.imageInsets = UIEdgeInsets(top: 35, left: 35, bottom: 35, right: 35)
        
        let main = NewsViewController()
        let mainNavController = UINavigationController(rootViewController: main)
        mainNavController.tabBarItem.title = "Главная"
        mainNavController.tabBarItem.image = #imageLiteral(resourceName: "Home")
        mainNavController.tabBarItem.imageInsets = UIEdgeInsets(top: 35, left: 35, bottom: 35, right: 35)
        
        viewControllers = [favorite, profile, orders, contactsNavController, mainNavController]
    }
}
