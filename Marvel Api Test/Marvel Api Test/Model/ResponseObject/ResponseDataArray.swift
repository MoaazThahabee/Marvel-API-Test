//
//  ResponseDataArray.swift
//  Kasb
//
//  Created by Moaaz Al-Thahabee on 3/5/18.
//  Copyright © 2018 TeachArabia. All rights reserved.
//

import UIKit
import ObjectMapper
import ObjectMapperAdditions

class ResponseDataArray<T: BaseEntity>: BaseResponseObject {
    var data: ArrayDataContainer<T>?
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)

        data <- map["data"]
    }
}
