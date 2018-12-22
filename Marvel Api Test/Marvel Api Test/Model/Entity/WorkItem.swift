//
//  WorkItem.swift
//  Marvel Api Test
//
//  Created by Moaaz Al-Thahabee on 12/19/18.
//  Copyright © 2018 Moaaz Al-Thahabee. All rights reserved.
//

import UIKit
import ObjectMapperAdditions
import ObjectMapper

class WorkItem: BaseEntity {
    var name: String?
    var title: String?
    var resourceURI: String?
    var thumbnail: Thumbnail?
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        name <- (map["name"], StringTransform())
        title <- (map["title"], StringTransform())
        resourceURI <- (map["resourceURI"], StringTransform())
        thumbnail <- map["thumbnail"]
    }
}
