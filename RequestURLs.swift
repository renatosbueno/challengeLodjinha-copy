//
//  File.swift
//  challengeLodjinha
//
//  Created by Renato Souza Bueno on 15/02/17.
//  Copyright © 2017 Renato S. Bueno. All rights reserved.
//

import Alamofire

public typealias ResponseBody = [String: AnyObject]

enum CallType {
    case BannerProducts
    case CategoryProducts
    case ListProduct
    case ShowSingleProduct
    case MostSelledListProducts
    case ReserveProduct
}

struct RequestURLs {
    static let DefaultURL = "https://alodjinha.herokuapp.com"
    static let BannerURL = "/banner"
    static let CategoryURL = "/categoria"
    static let ProductURL = "/produto/"
    static let ListURL = "/produto"
    static let MostSelledProducts = "/produto/maisvendidos"
    static let ReserveProduct = "/produto/" // post
    
}

struct WebRequest {

    static func requestAPI(productId: String?, callType: CallType, succesCompletion: @escaping ([AnyObject] , String?)->() ) {
        Alamofire.request(getServerURL(callType: callType, productId: (productId ?? "")), method: serviceIsAGet(callType: callType)).validate().responseJSON { (response) in
            if response.result.isSuccess {
                switch callType {
                case .BannerProducts:
                    if let results = response.result.value as? ResponseBody, let data = results["data"] as? [AnyObject] {
                        var imageData = [LodjinhaImageModel]()
                        
                        data.forEach({if $0 is ResponseBody { imageData.append(LodjinhaImageModel(dictionary: $0 as! ResponseBody)) }})
                        succesCompletion(imageData, nil)
                    }
                    break
                case .CategoryProducts:
                    if let results = response.result.value as? ResponseBody, let data = results["data"] as? [AnyObject] {
                        var productCategoryModel = [ProductCategoryModel]()
                        data.forEach({if $0 is ResponseBody {
                            productCategoryModel.append(ProductCategoryModel(dictionary: $0 as! [String: AnyObject])) }})
                            succesCompletion(productCategoryModel, nil)
                        }
                        break
                case .ListProduct, .MostSelledListProducts:
                    if let results = response.result.value as? ResponseBody, let data = results["data"] as? [AnyObject]  {
                        
                        var productDetailModel = [ProductDetailModel]()
                        let productDetail = ProductDetailModel()
                        
                        if let offset = results["offset"] as? Int, let total = results["total"] as? Int {
                            productDetail.offSet = offset
                            productDetail.total = total
                        }
                        data.forEach({if $0 is ResponseBody {
                            productDetailModel.append(ProductDetailModel(dictionary: $0 as! ResponseBody)) }})
                        succesCompletion(productDetailModel, nil)
                    }
                    break
                case .ShowSingleProduct:
                    if let results = response.result.value {
                        var showDetail = [ProductDetailModel]()
                        showDetail.append(ProductDetailModel(dictionary: results as! ResponseBody))
                        succesCompletion(showDetail, nil)   
                    }
                    break
                    
                case .ReserveProduct:
                    if let results = response.result.value as? [AnyObject]{
                        succesCompletion(results, nil)
                    }
                    break
                }
            }
        }
    }
    
    
    static func serviceIsAGet(callType: CallType) -> HTTPMethod {
        return callType == .ReserveProduct ? .post : .get
    }
    
    
    static func getServerURL(callType: CallType, productId: String?) -> String {
        switch callType {
        case .BannerProducts:
            return (RequestURLs.DefaultURL) + (RequestURLs.BannerURL)
        case .CategoryProducts:
            return (RequestURLs.DefaultURL) + (RequestURLs.CategoryURL)
        case .ListProduct:
            return (RequestURLs.DefaultURL) + (RequestURLs.ListURL)
        case .MostSelledListProducts:
            return (RequestURLs.DefaultURL) + (RequestURLs.MostSelledProducts)
        case .ShowSingleProduct:
            return (RequestURLs.DefaultURL) + (RequestURLs.ProductURL) + (productId ?? "")
        case .ReserveProduct:
            return (RequestURLs.DefaultURL) + (RequestURLs.ReserveProduct) + (productId ?? "")
        }
    }

    
    
}
