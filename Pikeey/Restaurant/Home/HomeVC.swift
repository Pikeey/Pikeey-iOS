//
//  HomeVC.swift
//  Pikeey
//
//  Created by Eric Morales on 5/24/22.
//

import UIKit

class HomeVC: UIViewController {
    
    // MARK: - Properties
    lazy var brandStack: UIStackView = {
        let stack = BrandStack()
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    lazy var restaurantInfoHorizontalStack: RestaurantInfoStack = {
        let image = UIImage(systemName: "photo.circle")
        let name = "GoodFood Restaurant"
        let description = "Local kitchen with a delicious twist and farmers support."
        
        let stack = RestaurantInfoStack(image: image, name: name, description: description)
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    // MARK: - VC's LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        
        setupNavBar()
        setupBrandStack()
        setupRestaurantInfoStack()
    }
    
    // MARK: - Methods
    private func setupNavBar() {
        let loginButton = UIBarButtonItem(image: UIImage(systemName: "person"),
                                          style: .plain,
                                          target: self,
                                          action: #selector(loginButtonSelected(_:)))
        loginButton.tintColor = .label
        self.navigationItem.rightBarButtonItem = loginButton
    }
    
    private func setupBrandStack() {
        // Add to view's hierarchy
        view.addSubview(brandStack)
        
        // Add constraints
        NSLayoutConstraint.activate([
            brandStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            brandStack.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.65),
            brandStack.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func setupRestaurantInfoStack() {
        // Add view's hierarchy
        view.addSubview(restaurantInfoHorizontalStack)
        
        // Add constraints
        NSLayoutConstraint.activate([
            // restaurantInfoHorizontalStack
            restaurantInfoHorizontalStack.topAnchor.constraint(equalTo: brandStack.bottomAnchor, constant: 30),
            restaurantInfoHorizontalStack.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            restaurantInfoHorizontalStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            restaurantInfoHorizontalStack.heightAnchor.constraint(equalTo: restaurantInfoHorizontalStack.restaurantDescriptionStack.heightAnchor, constant: 30),
        ])
    }
    
    @objc private func loginButtonSelected(_ button: UIBarButtonItem) {
        print("Log In Button Selected.")
    }
}
