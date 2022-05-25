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
    
    // MARK: - VC's LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        
        setupNavBar()
        setupBrandStack()
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
    
    @objc private func loginButtonSelected(_ button: UIBarButtonItem) {
        print("Log In Button Selected.")
    }
}
