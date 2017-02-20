//
//  CategoryTableViewCell.swift
//  challengeLodjinha
//
//  Created by Renato Souza Bueno on 18/02/17.
//  Copyright © 2017 Renato S. Bueno. All rights reserved.
//

import UIKit

class CategoryTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    var categoryRepresentation = CategoryTableViewCellViewModel()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.categoryCollectionView.delegate = self
        self.categoryCollectionView.dataSource = self
        // Initialization code
    }
    
    func setRepresentation(representation: CategoryTableViewCellViewModel?) {
        if let rep = representation {
            self.categoryRepresentation = rep
            self.categoryCollectionView.reloadData()
        }
    }

    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.categoryRepresentation.categoryArrayItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: indexPath) as? CategoryCollectionViewCell {
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.categoryRepresentation.shouldDisplayCollectionViewCell(collectionView, willDisplay: cell, forItemAt: indexPath)
    }
    
}
