//
//  TabBarController.swift
//  Pikeey
//
//  Created by Eric Morales on 5/25/22.
//

import UIKit

class TabBarController: UITabBarController {

    // MARK: - VC's LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tabBar.tintColor = .systemIndigo
        setupViewControllers()
    }

    // MARK: - Methods
    private func setupViewControllers() {
        let homeVC = HomeVC()
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house.circle"), selectedImage: UIImage(systemName: "house.circle.fill"))
        
        let foodVC = FoodVC()
        foodVC.tabBarItem = UITabBarItem(title: "Food", image: UIImage(systemName: "bag.circle"), selectedImage: UIImage(systemName: "bag.circle.fill"))
        
        let drinksVC = DrinksVC()
        drinksVC.tabBarItem = UITabBarItem(title: "Drinks", image: UIImage(systemName: "drop.circle"), selectedImage: UIImage(systemName: "drop.circle.fill"))
        
        let viewControllers = [homeVC, foodVC, drinksVC]
        var navControllers = [UINavigationController]()
        
        for vc in viewControllers {
            let navController = UINavigationController(rootViewController: vc)
            navControllers.append(navController)
        }
        
        
        self.viewControllers = navControllers
    }
}
