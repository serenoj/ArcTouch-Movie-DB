//
//  UIViewControllerExtension.swift
//  ArcTouch Movie DB
//
//  Created by Juan Carlos Correa Arango on 1/28/19.
//  Copyright © 2019 ArcTouch. All rights reserved.
//

import Foundation
import UIKit
import PKHUD

extension UIViewController {
    
    /// Creates an instance of the view controller from the storyboard.
    ///
    /// - Parameters:
    ///   - name: The name of the storyboard where the view controller is defined.
    ///   - bundle: The bundle where the storyboard belongs. Default vaule is `nil` for which
    ///             the main bundle is used.
    ///   - id: The storyboard identifier for the view controller. If `nil` uses the view controller's type as the identifier. Default value is `nil`.
    /// - Returns: An instance of the view controller or `nil` if the view controller with the identifier does not exists in the storyboard.
    class func fromStoryboard(_ name: String, in bundle: Bundle? = nil, withIdentifier id: String? = nil) -> Self? {
        return fromStoryboard(UIStoryboard(name: name, bundle: bundle), withIdentifier: id)
    }
    
    
    /// Creates an instance of the view controller from the storyboard.
    ///
    /// - Parameters:
    ///   - storyboard: The storyboard where the view controller is defined.
    ///   - id: The storyboard identifier for the view controller. If `nil` uses the view controller's type as the identifier. Default value is `nil`.
    /// - Returns: An instance of the view controller or `nil` if the view controller with the identifier does not exists in the storyboard.
    class func fromStoryboard(_ storyboard: UIStoryboard, withIdentifier id: String? = nil) -> Self? {
        return fromStoryboard(storyboard, withIdentifier: id, as: self)
    }
    
    // MARK: Private
    
    private class func fromStoryboard<T>(_ storyboard: UIStoryboard, withIdentifier id: String? = nil, as type: T.Type) -> T? {
        return  storyboard.instantiateViewController(withIdentifier: id ?? "\(type)") as? T
    }
    
    //MARK: Activity Indicator
    
    public func showActivityIndicator(on view: UIView? = nil) {
        HUD.show(.progress, onView: view)
    }
    
    public func dissmissActivityIndicator() {
        HUD.hide()
    }
    
    
    //MARK: Alert methods
    
    func showAlert(message: String) {
        showAlert(title: "Alert !", message: message, completion: nil)
    }
    
    func showAlert(title: String, message: String, completion:(()-> Void)?) {
        let alertController = UIAlertController(title: title, message:message, preferredStyle: .alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .default) { action in
            completion?()
        }
        
        alertController.addAction(defaultAction)
        present(alertController, animated: false, completion: nil)
    }
    
    func showAlert(title: String, message: String, cancelButton: String = "Cancel", acceptButton: String = "OK", acceptCompletion:(()-> Void)?, cancelCompletion:(()-> Void)?) {
        let alertController = UIAlertController(title: title, message:message, preferredStyle: .alert)
        
        let defaultAction = UIAlertAction(title: acceptButton, style: .default) { action in
            acceptCompletion?()
        }
        
        let cancelAction = UIAlertAction(title: cancelButton, style: .default) { action in
            cancelCompletion?()
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
    }
    
    public func showErrorAlertForServer(error: Error?) {
        var message: String?
        
        if  let errorObject = error {
            message = errorObject.localizedDescription
        } else {
            message = "Unknown error happend. Please try again"
        }
        
        showAlert(title: "Error !", message: message!, completion: nil)
    }
}

