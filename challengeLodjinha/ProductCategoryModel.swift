//
//  ProductCategoryModel.swift
//  challengeLodjinha
//
//  Created by iOS Developer on 2/16/17.
//  Copyright © 2017 Renato S. Bueno. All rights reserved.
//

import JSONHelper

class ProductCategoryModel: Deserializable {
    
    dynamic var productDescription = ""
    dynamic var productId = ""
    dynamic var productImageUrl = ""
    
    convenience required init(dictionary: [String : AnyObject]) {
        self.init()
        productDescription   <-- dictionary["descricao"]
        productId            <-- dictionary["id"]
        productImageUrl      <-- dictionary["urlImagem"]
        
    }
    
}

