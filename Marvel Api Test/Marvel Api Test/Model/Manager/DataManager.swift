//
//  DataManager.swift
//  Marvel Api Test
//
//  Created by Moaaz Al-Thahabee on 12/19/18.
//  Copyright © 2018 Moaaz Al-Thahabee. All rights reserved.
//

import UIKit

class DataManager: BaseManager {
    static let shared = DataManager()
    
    var characters: [Character] = []
}
