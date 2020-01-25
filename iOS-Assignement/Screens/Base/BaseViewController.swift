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
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
          return .lightContent
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    // MARK: - Setup
    open func setupView() {
        /// Abstract method. Subclasses should override this method to setup their view.
    }
    
    open func setupAccessibility() {
        /// Abstract method. Subclasses should override this method to add accessibility.
    }
}

extension BaseViewController{
    func showErrorAlert(alertMessage: String) {
        
        let alert = UIAlertController(title: "Check-In App", message: alertMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
     }
}

