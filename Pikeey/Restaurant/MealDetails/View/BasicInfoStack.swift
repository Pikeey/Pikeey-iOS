//
//  BasicInfoStack.swift
//  Pikeey
//
//  Created by Eric Morales on 5/27/22.
//

import UIKit

class BasicInfoStack: UIStackView {
    
    // MARK: - Properties
    lazy var mealBasifInfoVerticalStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .fill
        stack.spacing = 5
        
        return stack
    }()
    lazy var mealNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        
        return label
    }()
    lazy var mealShortDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        
        return label
    }()
    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.font = UIFont.preferredFont(forTextStyle: .body)
        
        return label
    }()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    convenience init(name: String, description: String, price: Double) {
        self.init()
        
        mealNameLabel.text = name
        mealShortDescriptionLabel.text = description
        priceLabel.text = "$\(String(format: "%.2f", price))"
        setup()
    }
    
    // MARK: - Methods
    private func setup() {
        // Setting up stack
        translatesAutoresizingMaskIntoConstraints = false
        axis = .horizontal
        distribution = .fill
        alignment = .center
        spacing = 5
        layer.cornerRadius = 5
        
        // Add to view's hierarchy
        addArrangedSubview(mealBasifInfoVerticalStack)
        addArrangedSubview(priceLabel)
        mealBasifInfoVerticalStack.addArrangedSubview(mealNameLabel)
        mealBasifInfoVerticalStack.addArrangedSubview(mealShortDescriptionLabel)
        
        // Add Constraints
        NSLayoutConstraint.activate([
            // mealBasifInfoVerticalStack
            mealBasifInfoVerticalStack.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.75),
        ])
    }
}
