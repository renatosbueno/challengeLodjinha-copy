//
//  ProductTableViewCell.swift
//  challengeLodjinha
//
//  Created by Renato Souza Bueno on 19/02/17.
//  Copyright © 2017 Renato S. Bueno. All rights reserved.
//

import UIKit
import Nuke

class ProductTableViewCell: UITableViewCell {

    @IBOutlet weak var productDiscountValue: UILabel!
    @IBOutlet weak var productValue: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupCellWith(viewModel: ProductTableViewModelCell) {
        self.productValue.text = viewModel.shouldReturnValue()
        self.productDiscountValue.text = viewModel.shouldReturnDiscountValue()
        self.productDescription.text = viewModel.shouldReturnProductDescription()
        if let url = viewModel.shouldReturnURLAtImageView() {
            Nuke.loadImage(with: url, into: self.productImage)
        }
    }
}

