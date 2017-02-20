//
//  CategoryTableViewCellViewModel.swift
//  challengeLodjinha
//
//  Created by Renato Souza Bueno on 18/02/17.
//  Copyright © 2017 Renato S. Bueno. All rights reserved.
//

import UIKit

protocol CategoryTableViewCellRepresentation: class {
    var categoryArrayItems: [ProductCategoryModel] { get }
    
    func shouldDisplayCollectionViewCell(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath)
}

class CategoryTableViewCellViewModel {
    
    var categoryArrayItems = [ProductCategoryModel]()
    
    func shouldDisplayCollectionViewCell(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let categoryCell = cell as? CategoryCollectionViewCell
        let object = self.categoryArrayItems[indexPath.row] as ProductCategoryModel
        categoryCell?.categoryProducts = object
        categoryCell?.setupCategoryProducts()
    }
    
   
    
    
}
