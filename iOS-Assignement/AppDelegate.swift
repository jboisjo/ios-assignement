//
//  AppDelegate.swift
//  iOS-Assignement
//
//  Created by Jérémie Boisjoli on 2020-01-23.
//  Copyright © 2020 Jérémie Boisjoli. All rights reserved.
//

import UIKit
import GoogleSignIn

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = self.window ?? UIWindow()
        self.window!.rootViewController = UINavigationController(rootViewController: BaseViewController<UIView>())
        
        let rootViewController = self.window!.rootViewController as! UINavigationController
        rootViewController.setNavigationBarHidden(true, animated: false)
        rootViewController.pushViewController(LoginViewController(), animated: true)
        
        self.window!.makeKeyAndVisible()
        
        
        GIDSignIn.sharedInstance().clientID = "893464616073-128t1drsrctj70uhvm2cmavhcsaaa9ms.apps.googleusercontent.com" //to put in configFile
        
        return true
    }
    
    func application(_ application: UIApplication,
                     open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return GIDSignIn.sharedInstance().handle(url,
                                                 sourceApplication: sourceApplication,
                                                 annotation: annotation)
    }
    
    @available(iOS 9.0, *)
    func application(_ app: UIApplication, open url: URL,
                     options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
        let sourceApplication = options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String
        let annotation = options[UIApplication.OpenURLOptionsKey.annotation]
        return GIDSignIn.sharedInstance().handle(url,
                                                 sourceApplication: sourceApplication,
                                                 annotation: annotation)
    }

}

