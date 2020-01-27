//
//  LoginViewModel.swift
//  iOS-Assignement
//
//  Created by Jérémie Boisjoli on 2020-01-23.
//  Copyright © 2020 Jérémie Boisjoli. All rights reserved.
//

import Foundation

class LoginViewModel {
    
    //MARK: Variables
    private let userDefault: UserDefaults
    var accessTokenKey = "accessTokenKey"
    
    //MARK: Init
    init(userDefault: UserDefaults) {
        self.userDefault = userDefault
    }
    
    //MARK: - Function
    func getValueFromKey(key: String) -> String {
        let value = userDefault.string(forKey: key)
        guard let returnValue = value else { return "" }
        
        return returnValue
    }
    
    func setAccessTokenLocal(value: String, key: String) {
        UserDefaults.standard.set(value, forKey: key)
    }
}
