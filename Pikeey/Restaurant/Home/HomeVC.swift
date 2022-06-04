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
        
        return stack
    }()
    lazy var restaurantInfoHorizontalStack: RestaurantInfoStack = {
        let image: UIImage? = UIImage(systemName: "photo.circle.fill")
        let stack = RestaurantInfoStack(image: image, name: "", description: "")
        
        return stack
    }()
    lazy var restaurantImageVerticalStack: RestaurantImageStack = {
        let description = restaurant?.description ?? ""
        let stack = RestaurantImageStack(image: nil, description: description)
        
        return stack
    }()
    lazy var restaurant: Restaurant? = nil {
        didSet {
            //let data = try? Data(contentsOf: URL(string: "https://i.ibb.co/9421HYF/Lovecchio-Logo-big.jpg")!)
            //self.restaurantInfoHorizontalStack.restaurantLogoImage.image = UIImage(data: data!)
            self.restaurantInfoHorizontalStack.restaurantNameLabel.text = restaurant?.name
            self.restaurantInfoHorizontalStack.restaurantDescriptionLabel.text = String(restaurant?.description.split(separator: ".").first ?? "Short description not found.")
            
            // Download image data in the background and update the imageView on the main thread.
            DispatchQueue.global().async { [unowned self] in
                if let data = try? Data(contentsOf: restaurant!.image) {
                    DispatchQueue.main.async {
                        self.restaurantImageVerticalStack.imageView.image = UIImage(data: data)
                    }
                }
            }
            self.restaurantImageVerticalStack.imageDescriptionLabel.text = restaurant?.description ?? "Description not found."
        }
    }
    
    // MARK: - VC's LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        
        setupNavBar()
        setupBrandStack()
        setupRestaurantInfoStack()
        setupRestaurantImageStack()
        makeRequest()
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
    
    private func setupRestaurantImageStack() {
        // Add to view's hierarchy
        view.addSubview(restaurantImageVerticalStack)
        
        // Add constraints
        NSLayoutConstraint.activate([
            // restaurantImageVerticalStack
            restaurantImageVerticalStack.topAnchor.constraint(equalTo: restaurantInfoHorizontalStack.bottomAnchor,
                                                              constant: 30),
            restaurantImageVerticalStack.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            restaurantImageVerticalStack.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func makeRequest() {
        MomenuServicer(requestType: .restaurantInfo).request(responseType: Restaurant.self) { result in
            switch result {
            case .success(let restaurant):
                self.restaurant = restaurant
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @objc private func loginButtonSelected(_ button: UIBarButtonItem) {
        print("Log In Button Selected.")
    }
}
