//
//  RestaurantImageStack.swift
//  Pikeey
//
//  Created by Eric Morales on 5/26/22.
//

import UIKit

class RestaurantImageStack: UIStackView {
    
    // MARK: - Properties
    lazy var aspecRatio: CGFloat = 9/16
    lazy var imageView: UIImageView = {
        let image =  UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .secondarySystemBackground
        
        return image
    }()
    lazy var imageDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        label.textAlignment = .left
        
        return label
    }()
    
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    convenience init(image: UIImage?, description: String) {
        self.init()
        imageView.image = image
        imageDescriptionLabel.text = description
        setup()
    }
    
    // MARK: - Methods
    private func setup() {
        // Setting up stack
        translatesAutoresizingMaskIntoConstraints = false
        axis = .vertical
        distribution = .fill
        alignment = .fill
        spacing = 10
        
        // Add to view's hierarchy
        addArrangedSubview(imageView)
        addArrangedSubview(imageDescriptionLabel)
        
        // Add Constraints
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: aspecRatio)
        ])
    }
}
