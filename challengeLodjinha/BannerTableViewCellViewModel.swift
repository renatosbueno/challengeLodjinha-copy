//
//  BannerTableViewCellViewModel.swift
//  challengeLodjinha
//
//  Created by Renato Souza Bueno on 2/17/17.
//  Copyright © 2017 Renato S. Bueno. All rights reserved.
//

import Foundation
import UIKit

protocol BannerTableViewCellRepresentation: class {
    var bannerArrayItems: [LodjinhaImageModel] { get }
    
    func shouldDisplayCollectionViewCell(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath)
}

class BannerTableViewCellViewModel {
    
    var bannerArrayItems = [LodjinhaImageModel]()
    
    func shouldDisplayCollectionViewCell(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let bannerCell = cell as? BannerCollectionViewCell
        let object = self.bannerArrayItems[indexPath.row] as LodjinhaImageModel
        bannerCell?.banner = object
        bannerCell?.setImageView()
    }
}
