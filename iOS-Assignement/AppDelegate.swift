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
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = self.window ?? UIWindow()
        self.window!.rootViewController = UINavigationController(rootViewController: BaseViewController<UIView>())
        
        let rootViewController = self.window!.rootViewController as! UINavigationController
        rootViewController.setNavigationBarHidden(true, animated: false)
        rootViewController.pushViewController(ViewController(), animated: true)
        
        self.window!.makeKeyAndVisible()
        
        
        GIDSignIn.sharedInstance().clientID = "893464616073-128t1drsrctj70uhvm2cmavhcsaaa9ms.apps.googleusercontent.com" //configFile
        GIDSignIn.sharedInstance().delegate = self
        
        return true
    }
    
    @available(iOS 9.0, *)
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
      return GIDSignIn.sharedInstance().handle(url)
    }
    
    //GoogleSDK Login
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
          if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
            print("The user has not signed in before or they have since signed out.")
          } else {
            print("\(error.localizedDescription)")
          }
          return
        }
        
        // Perform any operations on signed in user here.
        let _ = user.userID                  // For client-side use only!
        let _ = user.authentication.idToken // Safe to send to the server
        let _ = user.profile.name
        let _ = user.profile.givenName
        let _ = user.profile.familyName
        let _ = user.profile.email
        // ...
    }

    //GoogleSDK Logout
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!,
              withError error: Error!) {
      // Perform any operations when the user disconnects from app here.
      // ...
    }

}

