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
        
        
        GIDSignIn.sharedInstance().clientID = "175345383373-vsnr0g0nh9ruk4vrt9utn58qnoeja9b8.apps.googleusercontent.com" //to put in configFile
        
        return true
    }

}

