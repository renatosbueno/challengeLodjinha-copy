//
//  CategoryCollectionViewCell.swift
//  challengeLodjinha
//
//  Created by Renato Souza Bueno on 18/02/17.
//  Copyright © 2017 Renato S. Bueno. All rights reserved.
//

import UIKit
import Nuke

class CategoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var categoryImageView: UIImageView!
    
    @IBOutlet weak var categoryDescriptionLabel: UILabel!
    
    var categoryProducts: ProductCategoryModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupCategoryProducts() {
        guard let categoryItems = categoryProducts, let pictureURL = self.categoryProducts?.productImageUrl else { return}
        if let urlImage = URL(string: pictureURL) {
            DispatchQueue.main.async {
                Nuke.loadImage(with: urlImage, into: self.categoryImageView)
                self.categoryDescriptionLabel.text = categoryItems.productDescription
            }
        }
    }
    
    
    
}
