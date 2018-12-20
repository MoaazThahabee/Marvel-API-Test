//
//  BaseEntity.swift
//  Marvel Api Test
//
//  Created by Moaaz Al-Thahabee on 12/19/18.
//  Copyright © 2018 Moaaz Al-Thahabee. All rights reserved.
//

import UIKit
import ObjectMapper
import ObjectMapperAdditions

class BaseEntity: NSObject, Mappable {
    required init?(map: Map) {
        
    }
    
    override init () {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        
    }
}
