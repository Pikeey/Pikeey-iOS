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
        self.tabBar.tintColor = UIColor(named: "basicDarkPurpule")
        
        setupViewControllers()
    }
    
    // MARK: - Methods
    private func setupViewControllers() {
        let config = UIImage.SymbolConfiguration(paletteColors: [ .white, .init(named: "basicDarkPurpule")!])
        let attributeString: [NSAttributedString.Key: Any] = [.foregroundColor : UIColor(named: "tabBarText")!]
        
        
        let homeVC = HomeVC()
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house.circle"), selectedImage: UIImage(systemName: "house.circle.fill", withConfiguration: config))
        homeVC.tabBarItem.setTitleTextAttributes(attributeString, for: .selected)
        
        let foodVC = FoodVC()
        foodVC.tabBarItem = UITabBarItem(title: "Food", image: UIImage(systemName: "bag.circle"), selectedImage: UIImage(systemName: "bag.circle.fill", withConfiguration: config))
        foodVC.tabBarItem.setTitleTextAttributes(attributeString, for: .selected)
        
        let drinksVC = DrinksVC()
        drinksVC.tabBarItem = UITabBarItem(title: "Drinks", image: UIImage(systemName: "drop.circle"), selectedImage: UIImage(systemName: "drop.circle.fill", withConfiguration: config))
        drinksVC.tabBarItem.setTitleTextAttributes(attributeString, for: .selected)
        
        let viewControllers = [homeVC, foodVC, drinksVC]
        var navControllers = [UINavigationController]()
        
        for vc in viewControllers {
            let navController = UINavigationController(rootViewController: vc)
            navControllers.append(navController)
        }
        
        
        self.viewControllers = navControllers
    }
}
