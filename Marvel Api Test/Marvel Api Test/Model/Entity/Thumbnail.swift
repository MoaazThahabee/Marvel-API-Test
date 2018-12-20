//
//  Thumbnail.swift
//  Marvel Api Test
//
//  Created by Moaaz Al-Thahabee on 12/19/18.
//  Copyright © 2018 Moaaz Al-Thahabee. All rights reserved.
//

import UIKit
import ObjectMapperAdditions
import ObjectMapper

class Thumbnail: BaseEntity {
    var path: String?
    var extention: String?
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        path <- (map["path"], StringTransform())
        extention <- (map["extension"], StringTransform())
    }
}
