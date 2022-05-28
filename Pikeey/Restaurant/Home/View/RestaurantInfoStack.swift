//
//  RestaurantInfoStack.swift
//  Pikeey
//
//  Created by Eric Morales on 5/25/22.
//

import UIKit

class RestaurantInfoStack: UIStackView {

    // MARK: - Properties
    lazy var restaurantLogoImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.tintColor = .label
        image.contentMode = .scaleAspectFit
        
        return image
    }()
    lazy var restaurantDescriptionStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .fill
        stack.spacing = 5
        
        return stack
    }()
    lazy var restaurantNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.numberOfLines = 1
        
        return label
    }()
    lazy var restaurantDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        label.numberOfLines = 3
        
        return label
    }()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    convenience init(image: UIImage?, name: String, description: String) {
        self.init()
        
        self.restaurantLogoImage.image = image
        self.restaurantNameLabel.text = name
        self.restaurantDescriptionLabel.text = description
        
        self.setup()
    }
    
    // MARK: - Methods
    private func setup() {
        // Setting up stack
        translatesAutoresizingMaskIntoConstraints = false
        axis = .horizontal
        distribution = .fill
        alignment = .fill
        spacing = 5
        //layer.borderWidth = 0.5
        //layer.borderColor = UIColor.systemGray.cgColor
        layer.cornerRadius = 10
        backgroundColor = .secondarySystemBackground
        
        // Add to view's hierarchy
        addArrangedSubview(restaurantLogoImage)
        addArrangedSubview(restaurantDescriptionStack)
        restaurantDescriptionStack.addArrangedSubview(restaurantNameLabel)
        restaurantDescriptionStack.addArrangedSubview(restaurantDescriptionLabel)
        
        // Add Constraints
        NSLayoutConstraint.activate([
            // restaurantDescription
            restaurantDescriptionStack.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            restaurantDescriptionStack.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7),
            
            // restaurantLogo
            restaurantLogoImage.heightAnchor.constraint(equalTo: heightAnchor),
        ])
    }
}
