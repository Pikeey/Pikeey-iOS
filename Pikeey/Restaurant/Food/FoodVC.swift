//
//  FoodVC.swift
//  Pikeey
//
//  Created by Eric Morales on 5/25/22.
//

import UIKit

class FoodVC: UIViewController {
    
    // MARK: - Properties
    
    // MARK: - VC's LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        
        setupNavBar()
    }
    
    // MARK: - Methods
    private func setupNavBar() {
        let loginButton = UIBarButtonItem(title: "Log In", style: .plain, target: self, action: #selector(loginButtonSelected(_:)))
        loginButton.setTitleTextAttributes([NSAttributedString.Key.underlineStyle : NSUnderlineStyle.single], for: .normal)
        self.navigationItem.rightBarButtonItem = loginButton
    }
    
    @objc private func loginButtonSelected(_ button: UIBarButtonItem) {
        print("Log In Button Selected.")
    }
}
