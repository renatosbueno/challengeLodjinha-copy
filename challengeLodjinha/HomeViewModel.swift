//
//  HomeViewModel.swift
//  challengeLodjinha
//
//  Created by iOS Developer on 2/17/17.
//  Copyright © 2017 Renato S. Bueno. All rights reserved.
//

import UIKit

protocol HomeViewModelDelegate {
    func feedbackRequestProducts(errorMessage: String?)
}

enum SectionType: Int {
    case Banner = 0
    case Category = 1
    case List = 2
    case None = 3
    
    func sectionTypeHeader(sectionType: SectionType) -> String {
        switch sectionType {
        case .Category:
            return "Categorias"
        case .List:
            return "Mais vendidos"
        default:
            return ""
        }
    }
}


class HomeViewModel: NSObject {
    
    var delegate: HomeViewModelDelegate?
    
    var bannerProducts = [LodjinhaImageModel]()
    
    var categoryProducts = [ProductCategoryModel]()
    
    var listProducts = [ProductDetailModel]()
    
    var isLoading = false
    
    init(delegate: HomeViewModelDelegate?) {
        self.delegate = delegate
    }
    
    func willDisplayCell(cell: UITableViewCell, indexPath: IndexPath, sectionType: SectionType) {
        switch sectionType {
        case .Banner:
            if self.isLoading == false {
                self.getBannerItems(success: { (success, error) in
                    if success == true {
                        let bannerCell = cell as? BannerTableViewCell
                        let bannerViewModel = BannerTableViewCellViewModel()
                        bannerViewModel.bannerArrayItems = self.bannerProducts
                        bannerCell?.setRepresentation(representation: bannerViewModel)
                    }
                })
            }
            
        case .Category:
            self.getCategoryItems(sucess: { (success) in
                if success == true {
                    let categoryCell = cell as? CategoryTableViewCell
                    let categoryViewModel = CategoryTableViewCellViewModel()
                    categoryViewModel.categoryArrayItems = self.categoryProducts
                    categoryCell?.setRepresentation(representation: categoryViewModel)
                }
            })
            
        case .List:
            if self.listProducts.count > 0 {
                let productCell = cell as? ProductTableViewCell
                let product = self.listProducts[indexPath.row]
                let productCellModel = ProductTableViewModelCell(with: product)
                productCell?.setupCellWith(viewModel: productCellModel)
            }
        case .None:
            print("none")
        }
        
    }
    
    func numbersOfSections() -> Int {
        return 3
    }
    
    func returnImageURL() -> [String] {
        var imageUrlArray = [String]()
         self.bannerProducts.forEach({imageUrlArray.append($0.pictureURL)})
        return imageUrlArray
    }
    
    func numbersOfRows(in section: SectionType) -> Int {
        switch section {
        case .Banner:
            return 1
        case .Category:
            return 1
        case .List:
            return listProducts.count
        case .None:
            return 0
        }
    }
    
    func shouldReturnHeightForRowAt(indexPath: IndexPath) -> CGFloat {
        guard let section: SectionType = SectionType(rawValue: indexPath.section) else {
            return 0
        }
        switch section {
        case .Banner:
            return 100.0
        case .Category:
            return 60.0
        case .List:
            return 70.0
        default:
            return 0
        }
    }
    
    func getProducts() {
        self.getProductItems { (success, error) in
            if success == true {
                self.delegate?.feedbackRequestProducts(errorMessage: nil)
            } else {
                self.delegate?.feedbackRequestProducts(errorMessage: error)
            }
        }
    }
    
    //MARK: - RequestProducts
    func getProductItems(success: @escaping (Bool, String?) -> ()) {
        WebRequest.requestAPI(productId: nil, callType: .ListProduct) { (response, message) in
            if response is [ProductDetailModel] {
                guard let products = response as? [ProductDetailModel] else { return }
                self.listProducts = products
                success(true, nil)
            } else {
                if message != nil {
                    success(false, message)
                }
            }
        }
    }
    
    //MARK: - RequestBanners
    func getBannerItems(success: @escaping (Bool, String?) -> ()) {
        WebRequest.requestAPI(productId: nil, callType: .BannerProducts) { (response, message) in
            self.isLoading = true
            if response is [LodjinhaImageModel] {
                guard let imageModel = response as? [LodjinhaImageModel] else { return }
                self.bannerProducts = imageModel
                success(true, nil)
            } else {
                success(false, message)
            }
        }
    }

    //MARK: - RequestCategoryItems
    func getCategoryItems(sucess: @escaping (Bool)->()) {
        WebRequest.requestAPI(productId: nil, callType: .CategoryProducts) { (content, message) in
            if content is [ProductCategoryModel] {
                guard let productCategory = content as? [ProductCategoryModel] else { return}
                self.categoryProducts = productCategory
                sucess(true)
            } else {
                if message != nil {
                    sucess(false)
                }
            }
        }
    }
}
