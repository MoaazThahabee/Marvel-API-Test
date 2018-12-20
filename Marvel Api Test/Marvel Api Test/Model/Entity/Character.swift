//
//  Character.swift
//  Marvel Api Test
//
//  Created by Moaaz Al-Thahabee on 12/19/18.
//  Copyright © 2018 Moaaz Al-Thahabee. All rights reserved.
//

import UIKit
import ObjectMapperAdditions
import ObjectMapper

class Character: BaseEntity {
    var id: Int?
    var name: String?
    var info: String?
    var resourceURI: String?
    
    var thumbnail: Thumbnail?
    
    var comics: [Comic]?
    var events: [Event]?
    var stories: [Story]?
    var series: [Series]?
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        id <- (map["id"], IntTransform())
        name <- (map["name"], StringTransform())
        info <- (map["description"], StringTransform())
        resourceURI <- (map["resourceURI"], StringTransform())
        thumbnail <- map["thumbnail"]
        comics <- map["comics.items"]
        events <- map["events.items"]
        stories <- map["stories.items"]
        series <- map["series.items"]
    }
}
