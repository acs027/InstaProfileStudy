//
//  InstaTabBarController.swift
//  InstaProfilePage
//
//  Created by ali cihan on 15.09.2024.
//

import UIKit

class InstaTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let homeVC = UIViewController()
        homeVC.view.backgroundColor = .white
        homeVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "house")?.resized(size: 30), tag: 0)
        
        let searchVC = UIViewController()
        searchVC.view.backgroundColor = .white
        searchVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "magnifyingglass")?.resized(size: 30), tag: 1)
        
        
        let addVC = UIViewController()
        addVC.view.backgroundColor = .white
        addVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "plus.square")?.resized(size: 30), tag: 2)
        
        
        let reelsVC = UIViewController()
        reelsVC.view.backgroundColor = .white
        reelsVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "play.square")?.resized(size: 30), tag: 3)
        
        
        let profileVC = ViewController()
        profileVC.view.backgroundColor = .white
        profileVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "person"), tag: 4)
        
        
        viewControllers = [homeVC, searchVC, addVC, reelsVC, profileVC]
        
        tabBar.tintColor = .darkGray
        tabBar.unselectedItemTintColor = .lightGray
        tabBar.backgroundColor = .white
        tabBar.itemPositioning = .centered
        tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
    }
}
