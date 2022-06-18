//
//  PriceChefChoiceStack.swift
//  momenu
//
//  Created by Eric Morales on 6/9/22.
//

import UIKit

class PriceChefChoiceStack: UIStackView {
    
    // MARK: - Properties
    lazy var isChefChoice: Bool = false {
        didSet {
            chefChoiceSetup()
        }
    }
    lazy var chefChoiceStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.alignment = .center
        stack.spacing = 8
        
        return stack
    }()
    lazy var chefChoiceImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(systemName: "rosette")
        image.tintColor = UIColor(named: "basicDarkPurpule")
        
        return image
    }()
    lazy var chefChoiceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.text = "Chef's Choice"
        
        return label
    }()
    lazy var priceContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "basicDarkPurpule")
        view.layer.cornerRadius = 10
        view.layer.shadowOffset = CGSize(width: 0, height: 3)
        view.layer.shadowOpacity = 0.3
        
        return view
    }()
    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.textAlignment = .center
        label.textColor = UIColor(named: "textColor")
        
        return label
    }()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Methods
    private func setup() {
        // Setting up stack
        translatesAutoresizingMaskIntoConstraints = false
        axis = .horizontal
        distribution = .equalSpacing
        alignment = .center
        
        // Add to view's hierarchy
        addArrangedSubview(priceContainer)
        priceContainer.addSubview(priceLabel)
        addArrangedSubview(chefChoiceStack)
        chefChoiceStack.addArrangedSubview(chefChoiceLabel)
        chefChoiceStack.addArrangedSubview(chefChoiceImage)
        
        // Add Constraints
        let buffer: CGFloat = 10
        NSLayoutConstraint.activate([
            // priceContainer
            priceContainer.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.30),
            priceContainer.heightAnchor.constraint(equalTo: priceContainer.widthAnchor, multiplier: 0.30),
            
            // priceLabel
            priceLabel.topAnchor.constraint(equalTo: priceContainer.topAnchor, constant: buffer),
            priceLabel.bottomAnchor.constraint(equalTo: priceContainer.bottomAnchor, constant: -buffer),
            priceLabel.leadingAnchor.constraint(equalTo: priceContainer.leadingAnchor, constant: buffer),
            priceLabel.trailingAnchor.constraint(equalTo: priceContainer.trailingAnchor, constant: -buffer),
            
            // chefChoiceImage
            chefChoiceImage.heightAnchor.constraint(equalTo: priceContainer.heightAnchor, multiplier: 0.9),
            chefChoiceImage.widthAnchor.constraint(equalTo: chefChoiceImage.heightAnchor)
        ])
    }
    
    private func chefChoiceSetup() {
        chefChoiceStack.isHidden = !isChefChoice
        
        if !isChefChoice {
            // If this meal is not chef choice add a space to the stack to push the price to the left.
            let spacerView = UIView()
            addArrangedSubview(spacerView)
        }
    }
}
