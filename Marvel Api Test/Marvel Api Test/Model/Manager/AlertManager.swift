//
//  AlertManager.swift
//  Marvel Api Test
//
//  Created by Moaaz Al-Thahabee on 12/19/18.
//  Copyright © 2018 Moaaz Al-Thahabee. All rights reserved.
//

import UIKit

class AlertManager: BaseManager {
    static let shared = AlertManager()
    
    func showAlertDialog(title: String, message: String, buttonTitle: String, completitionHandler: @escaping ()-> ()) {
        let alertController: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction: UIAlertAction = UIAlertAction(title: buttonTitle, style: .default) { (alert) in
            completitionHandler()
        }
        
        alertController.addAction(okAction)
        
        self.showOnTopViewController(alert: alertController)
    }
    
    private func showOnTopViewController(alert: UIAlertController) {
        if let appDelegate = UIApplication.shared.delegate, let window = appDelegate.window, let rootViewController = window?.rootViewController {
            
            var topViewController = rootViewController
            while topViewController.presentedViewController != nil {
                topViewController = topViewController.presentedViewController!
            }
            
            topViewController.present(alert, animated: true, completion: nil)
        }
    }
}
