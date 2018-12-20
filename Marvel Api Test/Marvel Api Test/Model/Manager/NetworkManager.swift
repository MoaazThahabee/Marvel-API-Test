//
//  NetworkManager.swift
//  Marvel Api Test
//
//  Created by Moaaz Al-Thahabee on 12/19/18.
//  Copyright © 2018 Moaaz Al-Thahabee. All rights reserved.
//

import UIKit
import Alamofire

enum NetworkConnectioError : Int {
    case internetError = 1
    case serverError = 2
    case unauthorized = 3
}

class NetworkManager: BaseManager {
    static let shared = NetworkManager()
    
    let reachabilityManager = NetworkReachabilityManager(host: "google.com")!
    let sessionManager = SessionManager.default
    
    func config() {
        self.startNetworkReachabilityObserver()
    }
    
    func startNetworkReachabilityObserver() {
        reachabilityManager.listener = { status in
            switch status {
            case .notReachable:
                AlertManager.shared.showAlertDialog(title: NSLocalizedString("InternetDisconnected", comment: ""), message: NSLocalizedString("InternetDisconnectedMessage", comment: ""), buttonTitle: NSLocalizedString("Ok", comment: ""), completitionHandler: {
                    
                })
                break
            case .unknown :
                AlertManager.shared.showAlertDialog(title: NSLocalizedString("InternetDisconnected", comment: ""), message: NSLocalizedString("InternetDisconnectedMessage", comment: ""), buttonTitle: NSLocalizedString("Ok", comment: ""), completitionHandler: {
                    
                })
                break
            case .reachable(.ethernetOrWiFi):
                NotificationCenter.default.post(name: Notification.Name.InternetReachableNotification, object: self, userInfo: nil)
            case .reachable(.wwan):
                AlertManager.shared.showAlertDialog(title: NSLocalizedString("InternetReachableViaWWAN", comment: ""), message: NSLocalizedString("InternetReachableViaWWANMessage", comment: ""), buttonTitle: NSLocalizedString("Ok", comment: ""), completitionHandler: {
                    NotificationCenter.default.post(name: Notification.Name.InternetReachableNotification, object: self, userInfo: nil)
                })
                break
            }
        }
        
        reachabilityManager.startListening()
    }
    
    
    func post(url: String, parameters: [String : Any]?, headers: [String : String]?, encoding: ParameterEncoding? = nil, success: @escaping ([String : Any])-> (), failure: @escaping (NetworkConnectioError)-> ()) {
        if reachabilityManager.isReachable {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            
            if let _ = encoding {
                Alamofire.request(url, method: .post, parameters: parameters, encoding: encoding!, headers: headers).responseJSON { response in
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    switch response.result {
                    case .success:
                        success(response.result.value! as! [String : Any])
                        break;
                    case .failure:
                        failure(NetworkConnectioError.serverError)
                    }
                }
            }
            else {
                Alamofire.request(url, method: .post, parameters: parameters, headers: headers).responseJSON { response in
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    switch response.result {
                    case .success:
                        success(response.result.value! as! [String : Any])
                        break;
                    case .failure:
                        failure(NetworkConnectioError.serverError)
                    }
                }
            }
        }
        else {
            failure(NetworkConnectioError.internetError)
        }
    }
    
    func get(url: String, parameters: [String : Any]?, headers: [String : String]?, success: @escaping ([String : Any])-> (), failure: @escaping (NetworkConnectioError)-> ()) {
        if reachabilityManager.isReachable {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            Alamofire.request(url, method: .get, parameters: parameters, headers: headers).responseJSON { response in
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                switch response.result {
                case .success:
                    success(response.result.value! as! [String : Any] )
                    break;
                case .failure:
                    failure(NetworkConnectioError.serverError)
                }
            }
        }
        else {
            failure(NetworkConnectioError.internetError)
        }
    }
}

extension Notification.Name {
    static let InternetReachableNotification = NSNotification.Name("InternetReachableNotification")
}
