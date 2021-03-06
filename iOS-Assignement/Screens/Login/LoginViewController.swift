//
//  LoginViewController.swift
//  iOS-Assignement
//
//  Created by Jérémie Boisjoli on 2020-01-23.
//  Copyright © 2020 Jérémie Boisjoli. All rights reserved.
//

import GoogleSignIn
import GoogleAPIClientForREST
import UIKit

class LoginViewController: BaseViewController<LoginView>, GIDSignInDelegate, GIDSignInUIDelegate {

    //MARK: Variables
    private let scopes = [kGTLRAuthScopeYouTubeReadonly]
    private let service = GTLRYouTubeService()
    private var viewModel: LoginViewModel!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = LoginViewModel(userDefault: UserDefaults.standard)
        setupGoogleSDK()
    }
    
    //MARK: - Functions
    func setupGoogleSDK() {
        // Configure Google Sign-in.
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().scopes = scopes
    }
    
    func setAccessTokenLocal(_ value: String, key: String) {
        viewModel.setAccessTokenLocal(value: value, key: key)
    }
    
    //MARK: - GIDSignInDelegate
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
              withError error: Error!) {
        if let error = error {
            showAlert(title: "Authentication Error", message: error.localizedDescription)
            self.service.authorizer = nil
        } else {
            setAccessTokenLocal(user.authentication.accessToken, key: viewModel.accessTokenKey)
            self.navigationController?.pushViewController(ListViewController(), animated: true)
        }
    }
}
