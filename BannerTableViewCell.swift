//
//  BannerTableViewCell.swift
//  challengeLodjinha
//
//  Created by iOS Developer on 2/17/17.
//  Copyright © 2017 Renato S. Bueno. All rights reserved.
//

import UIKit

class BannerTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var bannerCollectionView: UICollectionView!
    @IBOutlet weak var bannerPageControl: UIPageControl!
    
    var bannerRepresentation = BannerTableViewCellViewModel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        bannerCollectionView.delegate = self
        bannerCollectionView.dataSource = self
    }
    
    func setRepresentation(representation: BannerTableViewCellViewModel?) {
        if let rep = representation {
            self.bannerRepresentation = rep
            self.bannerCollectionView.reloadData()
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.bannerRepresentation.bannerArrayItems.count 
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerCollectionViewCell", for: indexPath) as? BannerCollectionViewCell {
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.bannerRepresentation.shouldDisplayCollectionViewCell(collectionView, willDisplay: cell, forItemAt: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.window?.rootViewController?.view.frame.size.width)!, height: self.bannerCollectionView.frame.size.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageWidth = bannerCollectionView.frame.size.width
        bannerPageControl.currentPage = Int(bannerCollectionView.contentOffset.x / pageWidth)
    }
}
