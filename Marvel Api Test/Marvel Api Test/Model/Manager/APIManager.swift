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
    
    enum APIEndpoint {
        case characters
        case comics(characterId: Int)
        case series(characterId: Int)
        case events(characterId: Int)
        case stories(characterId: Int)
        func url() -> String {
            switch self {
            case .characters:
                return APIManager.baseURL + APIManager.apiURL + "characters"
            case .comics(let characterId):
                return APIManager.baseURL + APIManager.apiURL + "characters/\(characterId)/" + "comics"
            case .series(let characterId):
                return APIManager.baseURL + APIManager.apiURL + "characters/\(characterId)/" + "series"
            case .events(let characterId):
                return APIManager.baseURL + APIManager.apiURL + "characters/\(characterId)/" + "events"
            case .stories(let characterId):
                return APIManager.baseURL + APIManager.apiURL + "characters/\(characterId)/" + "stories"
            }
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
    
    func comics(characterId: Int, offset: Int = 0, limit: Int = 20, success: @escaping (ArrayDataContainer<Comic>)-> (), failure: @escaping (String)-> ()) {
        let timestamp = Date().timeIntervalSince1970.description
        
        let parameters: [String : Any] = [
            APIParameterName.apiKey.rawValue: APIManager.publicAPIKey,
            APIParameterName.timestamp.rawValue: timestamp,
            APIParameterName.hash.rawValue: createHash(string: timestamp),
            APIParameterName.offset.rawValue: offset,
            APIParameterName.limit.rawValue: limit
        ]
        
        NetworkManager.shared.get(url: APIEndpoint.comics(characterId: characterId).url(), parameters: parameters, headers: nil, success: { (response) in
            let response = Mapper<ResponseDataArray<Comic>>().map(JSON: response)
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
    
    func events(characterId: Int, offset: Int = 0, limit: Int = 20, success: @escaping (ArrayDataContainer<Event>)-> (), failure: @escaping (String)-> ()) {
        let timestamp = Date().timeIntervalSince1970.description
        
        let parameters: [String : Any] = [
            APIParameterName.apiKey.rawValue: APIManager.publicAPIKey,
            APIParameterName.timestamp.rawValue: timestamp,
            APIParameterName.hash.rawValue: createHash(string: timestamp),
            APIParameterName.offset.rawValue: offset,
            APIParameterName.limit.rawValue: limit
        ]
        
        NetworkManager.shared.get(url: APIEndpoint.events(characterId: characterId).url(), parameters: parameters, headers: nil, success: { (response) in
            let response = Mapper<ResponseDataArray<Event>>().map(JSON: response)
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
    
    func stories(characterId: Int, offset: Int = 0, limit: Int = 20, success: @escaping (ArrayDataContainer<Story>)-> (), failure: @escaping (String)-> ()) {
        let timestamp = Date().timeIntervalSince1970.description
        
        let parameters: [String : Any] = [
            APIParameterName.apiKey.rawValue: APIManager.publicAPIKey,
            APIParameterName.timestamp.rawValue: timestamp,
            APIParameterName.hash.rawValue: createHash(string: timestamp),
            APIParameterName.offset.rawValue: offset,
            APIParameterName.limit.rawValue: limit
        ]
        
        NetworkManager.shared.get(url: APIEndpoint.stories(characterId: characterId).url(), parameters: parameters, headers: nil, success: { (response) in
            let response = Mapper<ResponseDataArray<Story>>().map(JSON: response)
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
    
    func series(characterId: Int, offset: Int = 0, limit: Int = 20, success: @escaping (ArrayDataContainer<Series>)-> (), failure: @escaping (String)-> ()) {
        let timestamp = Date().timeIntervalSince1970.description
        
        let parameters: [String : Any] = [
            APIParameterName.apiKey.rawValue: APIManager.publicAPIKey,
            APIParameterName.timestamp.rawValue: timestamp,
            APIParameterName.hash.rawValue: createHash(string: timestamp),
            APIParameterName.offset.rawValue: offset,
            APIParameterName.limit.rawValue: limit
        ]
        
        NetworkManager.shared.get(url: APIEndpoint.series(characterId: characterId).url(), parameters: parameters, headers: nil, success: { (response) in
            let response = Mapper<ResponseDataArray<Series>>().map(JSON: response)
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
