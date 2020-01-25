//
//  LoginViewModel.swift
//  iOS-Assignement
//
//  Created by Jérémie Boisjoli on 2020-01-23.
//  Copyright © 2020 Jérémie Boisjoli. All rights reserved.
//

import Foundation

class LoginViewModel {
    
    //MARK: Variable
    private let userDefault: UserDefaults
    private let accessTokenKey = "accessTokenKey"
    
    //MARK: Init
    init(userDefault: UserDefaults) {
        self.userDefault = userDefault
    }
    
    //MARK: - Function
    func getAccessTokenKey(key: String) -> String {
        let value = userDefault.string(forKey: key)
        guard let returnValue = value else { return "" }
        
        return returnValue
    }
    
    func setAccessTokenKey(value: String) {
        UserDefaults.standard.set(value, forKey: accessTokenKey)
    }
}
