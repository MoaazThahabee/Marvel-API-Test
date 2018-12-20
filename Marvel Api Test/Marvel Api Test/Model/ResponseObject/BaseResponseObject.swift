//
//  BaseResponseObject.swift
//  Marvel Api Test
//
//  Created by Moaaz Al-Thahabee on 12/20/18.
//  Copyright © 2018 Moaaz Al-Thahabee. All rights reserved.
//

import UIKit
import ObjectMapper
import ObjectMapperAdditions

class BaseResponseObject: NSObject, Mappable {
    var statusCode: Int?
    var message: String?
    
    required init?(map: Map) {
        
    }
    
    override init () {
        
    }

    func mapping(map: Map) {
        statusCode <- (map["code"], IntTransform())
        message <- (map["message"], StringTransform())
    }
}
