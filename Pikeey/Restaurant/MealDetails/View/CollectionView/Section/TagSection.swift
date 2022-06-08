//
//  TagSection.swift
//  Pikeey
//
//  Created by Eric Morales on 6/7/22.
//

import UIKit

struct TagSection: Section {
    
    // MARK: - Properties
    var numberOfItems: Int
    let tags: [String]
    
    // MARK: - Methods
    init(tags: [String]) {
        self.numberOfItems = tags.count
        self.tags = tags
    }
    
    func layoutSection() -> NSCollectionLayoutSection? {
        // item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.24), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        // group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(45))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = NSCollectionLayoutSpacing.flexible(3)
        
        // section
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }
    
    func configureCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: TagCell.self), for: indexPath) as! TagCell
        cell.set(name: tags[indexPath.item])
        
        return cell
    }
}
