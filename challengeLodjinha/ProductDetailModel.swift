//
//  ProductDetailModel.swift
//  challengeLodjinha
//
//  Created by Renato S. Bueno on 2/16/17.
//  Copyright © 2017 Renato S. Bueno. All rights reserved.
//

import JSONHelper

class ProductDetailModel: Deserializable {
    
    dynamic var categoryItems = CategoryItems()
    dynamic var description = ""
    dynamic var id = ""
    dynamic var productName = ""
    dynamic var originalPrice = 0
    dynamic var finalPrice = 0
    dynamic var imageUrl = ""
    dynamic var offSet = 0
    dynamic var total = 0
    
    convenience required init(dictionary: [String : AnyObject]) {
        self.init()
        
        categoryItems   <-- dictionary["categoria"]
        description     <-- dictionary["descricao"]
        id              <-- dictionary["id"]
        productName     <-- dictionary["nome"]
        originalPrice   <-- dictionary["precoDe"]
        finalPrice      <-- dictionary["precoPor"]
        imageUrl        <-- dictionary["urlImagem"]
        offSet          <-- dictionary["offset"]
        total           <-- dictionary["total"]
        
        categoryItems.categoryId = (dictionary["categoria"]?["id"] as? Int) ?? 0
        categoryItems.categoryDescription = (dictionary["categoria"]?["descricao"] as? String) ?? ""
        categoryItems.categoryImageUrl = (dictionary["categoria"]?["urlImagem"] as? String) ?? ""
        
    }
    
}

class CategoryItems: NSObject {
    public var categoryId: Int? = 0
    public var categoryDescription: String? = ""
    public var categoryImageUrl: String? = ""
    
}
