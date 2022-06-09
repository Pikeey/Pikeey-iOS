//
//  BrandStack.swift
//  Pikeey
//
//  Created by Eric Morales on 5/25/22.
//

import UIKit

class BrandStack: UIStackView {

    // MARK: - Properties
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.text = "momenu."
        label.textAlignment = .center
        
        // This aditional work is to add a specific weight to the font.
        let systemDynamicFontDescriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: .largeTitle)
        let size = systemDynamicFontDescriptor.pointSize
        let font = UIFont.systemFont(ofSize: size*1.5, weight: .semibold)
        label.font = font
        
        return label
    }()
    lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.text = "presents"
        label.font = UIFont.preferredFont(forTextStyle: .footnote)
        label.textAlignment = .center
        
        return label
    }()
    
    // MARK: - Initializer
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
        axis = .vertical
        distribution = .fill
        alignment = .center
        spacing = 10
        
        // Add to view's hierarchy
        addArrangedSubview(titleLabel)
        addArrangedSubview(subTitleLabel)
    }
}
