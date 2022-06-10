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
        label.numberOfLines = 3
        
        let fontDescriptior = UIFontDescriptor.preferredFontDescriptor(withTextStyle: .title1)
        let fontSize = fontDescriptior.pointSize
        label.font = UIFont.systemFont(ofSize: fontSize, weight: .bold)
        
        return label
    }()
    lazy var mealShortDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .footnote)
        
        return label
    }()
    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.textAlignment = .right
        
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
        distribution = .fill
        alignment = .center
        spacing = 5
        
        // Add to view's hierarchy
        addArrangedSubview(mealBasifInfoVerticalStack)
        mealBasifInfoVerticalStack.addArrangedSubview(mealNameLabel)
        mealBasifInfoVerticalStack.addArrangedSubview(mealShortDescriptionLabel)
        
        // Add Constraints
        NSLayoutConstraint.activate([
            // mealBasifInfoVerticalStack
            mealBasifInfoVerticalStack.widthAnchor.constraint(equalTo: self.widthAnchor)
        ])
    }
}
