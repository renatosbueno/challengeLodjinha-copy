//
//  BannerCollectionViewCell.swift
//  challengeLodjinha
//
//  Created by Renato Souza Bueno on 2/17/17.
//  Copyright © 2017 Renato S. Bueno. All rights reserved.
//

import UIKit
import Kingfisher
import Nuke

class BannerCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var bannerImageView: UIImageView!
    var banner: LodjinhaImageModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setImageView() {
        guard let pictureURL = self.banner?.pictureURL else {
            return
        }
        if let urlImage = URL(string: pictureURL) {
            DispatchQueue.main.async {
                Nuke.loadImage(with: urlImage, into: self.bannerImageView)
            }
        }
    }
}
