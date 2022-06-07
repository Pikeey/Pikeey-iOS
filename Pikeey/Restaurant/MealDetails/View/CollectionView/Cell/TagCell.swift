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
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        
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
        
        // MARK: View's hierarchy
        self.addSubview(label)
        
        // MARK: Constraints
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: self.topAnchor),
            label.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 5),
            label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 10),
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10)
        ])
    }
    
    func set(title: String) {
        label.text = title
    }
}
