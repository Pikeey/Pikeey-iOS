//
//  Section.swift
//  Pikeey
//
//  Created by Eric Morales on 6/7/22.
//

import UIKit

protocol Section {
    var numberOfItems: Int { get }
    func layoutSection() -> NSCollectionLayoutSection?
    func configureCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell
}
