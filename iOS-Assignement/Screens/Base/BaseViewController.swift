//
//  BaseViewController.swift
//  iOS-Assignement
//
//  Created by Jérémie Boisjoli on 2020-01-23.
//  Copyright © 2020 Jérémie Boisjoli. All rights reserved.
//

import UIKit

class BaseViewController<T: UIView>: UIViewController {
    
    // The view managed by the view controller typed by the `BaseViewController` generic.
    open var viewLayout: T {
        if let myView = view as? T {
            return myView
        }
        
        let newView = T()
        view = newView
        
        return newView
    }
    
    // MARK: - View Lifecycle
    open override func loadView() {
        view = T()
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupAccessibility()
    }
    
    // MARK: - Setup
    open func setupView() {
        /// Abstract method. Subclasses should override this method to setup their view.
    }
    
    open func setupAccessibility() {
        /// Abstract method. Subclasses should override this method to add accessibility.
    }
}

extension BaseViewController {
    func showAlert(title : String, message: String) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: UIAlertController.Style.alert
        )
        let ok = UIAlertAction(
            title: "OK",
            style: UIAlertAction.Style.default,
            handler: nil
        )
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
    
    
}

