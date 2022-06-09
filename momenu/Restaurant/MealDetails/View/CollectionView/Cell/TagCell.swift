//
//  TagCell.swift
//  Pikeey
//
//  Created by Eric Morales on 6/7/22.
//

import UIKit

class TagCell: UICollectionViewCell {
    
    // MARK: - Properties
    static var identifier: String = "TagCell"
    lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.textAlignment = .center
        //label.adjustsFontSizeToFitWidth = true
        
        label.layer.cornerRadius = 0.30 * min(frame.width, frame.height)
        label.clipsToBounds = true
        
        label.layer.borderColor = UIColor.systemPurple.cgColor
        label.layer.borderWidth = 1.5
        
        
        return label
    }()
    
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    private func setup() {
        // Cell Configuration
        
        // View's hierarchy
        self.addSubview(label)
        
        // Constraints
        NSLayoutConstraint.activate([
            // containter
            
            label.widthAnchor.constraint(equalTo: self.widthAnchor),
            label.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.6),
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
    }
    
    func set(name: String) {
        label.text = name
    }
}
