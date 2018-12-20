//
//  ArrayDataContainer.swift
//  Marvel Api Test
//
//  Created by Moaaz Al-Thahabee on 12/20/18.
//  Copyright © 2018 Moaaz Al-Thahabee. All rights reserved.
//

import UIKit
import ObjectMapper
import ObjectMapperAdditions

class ArrayDataContainer<T: BaseEntity>: BaseDataContainer {
    var offset: Int?
    var limit: Int?
    var total: Int?
    var count: Int?
    var data: [T]?
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        offset <- (map["offset"], IntTransform())
        limit <- (map["limit"], IntTransform())
        total <- (map["total"], IntTransform())
        count <- (map["count"], IntTransform())
        data <- map["results"]
    }
}
