//
//  APIManager.swift
//  Marvel Api Test
//
//  Created by Moaaz Al-Thahabee on 12/19/18.
//  Copyright © 2018 Moaaz Al-Thahabee. All rights reserved.
//

import UIKit
import ObjectMapper
import Alamofire
import AlamofireObjectMapper
import CryptoSwift

class APIManager: BaseManager {
    static let shared = APIManager()
    
    static private let baseURL = "https://gateway.marvel.com:443/"
    static private let apiURL = "v1/public/"
    static private let publicAPIKey = "09efb4bc48a97b9c2a73360d502e33ef"
    static private let privateAPIKey = "e5ec69a06545d698abbd0dde88146145714afeca"
    
    enum APIEndpoint: String {
        case characters = "characters"
        func url() -> String {
            return APIManager.baseURL + APIManager.apiURL + self.rawValue
        }
    }
    enum APIParameterName: String {
        case apiKey = "apikey"
        case hash = "hash"
        case timestamp = "ts"
        case offset = "offset"
        case limit = "limit"
    }
    
    func characters(offset: Int = 0, limit: Int = 20, success: @escaping (ArrayDataContainer<Character>)-> (), failure: @escaping (String)-> ()) {
        let timestamp = Date().timeIntervalSince1970.description
        
        let parameters: [String : Any] = [
            APIParameterName.apiKey.rawValue: APIManager.publicAPIKey,
            APIParameterName.timestamp.rawValue: timestamp,
            APIParameterName.hash.rawValue: createHash(string: timestamp),
            APIParameterName.offset.rawValue: offset,
            APIParameterName.limit.rawValue: limit
        ]
        
        NetworkManager.shared.get(url: APIEndpoint.characters.url(), parameters: parameters, headers: nil, success: { (response) in
            let response = Mapper<ResponseDataArray<Character>>().map(JSON: response)
            if let response = response, response.statusCode == 200 {
                success(response.data!)
            }
            else {
                failure(response?.message ?? NSLocalizedString("ConnectionProblem", comment: ""))
            }
        }) { (error) in
            failure(self.getServerErrorMessage(error: error))
        }
    }
    
    fileprivate func getServerErrorMessage(error: NetworkConnectioError) -> String {
        return NSLocalizedString("ConnectionProblem", comment: "")
    }
    
    fileprivate func createHash(string: String) -> String {
        return "\(string)\(APIManager.privateAPIKey)\(APIManager.publicAPIKey)".md5()
    }
}
