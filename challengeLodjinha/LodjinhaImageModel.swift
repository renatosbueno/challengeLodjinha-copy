//
//  LodjinhaImageModel.swift
//  challengeLodjinha
//
//  Created by Renato Souza Bueno on 14/02/17.
//  Copyright © 2017 Renato S. Bueno. All rights reserved.
//

import UIKit
import Kingfisher
import JSONHelper

class LodjinhaImageModel: Deserializable {
    
    dynamic var pictureId   = ""
    dynamic var pictureURL  = ""
    dynamic var pictureLink = ""

    convenience required init(dictionary: [String : AnyObject]) {
        self.init()
        pictureId       <-- dictionary["id"]
        pictureLink     <-- dictionary["linkUrl"]
        pictureURL      <-- dictionary["urlImagem"]
    }
    
}


