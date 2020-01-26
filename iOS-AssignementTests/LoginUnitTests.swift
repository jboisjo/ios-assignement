//
//  LoginUnitTests.swift
//  iOS-AssignementTests
//
//  Created by Jérémie Boisjoli on 2020-01-25.
//  Copyright © 2020 Jérémie Boisjoli. All rights reserved.
//

import XCTest
@testable import iOS_Assignement

class LoginUnitTests: XCTestCase {
    
    var loginViewModel: LoginViewModel!
    var loginViewController: LoginViewController!
    var userDefault: UserDefaults!

    override func setUp() {
        loginViewController = LoginViewController()
        loginViewModel = LoginViewModel(userDefault: UserDefaults.init())
        
        loginViewModel.accessTokenKey = "testKey"
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        loginViewModel = nil
        loginViewController = nil
        userDefault = nil
    }
    
    func testIfUserDefaultHasValue() {
        loginViewModel.setValueForKey(value: "123")
        let value = loginViewModel.getValueFromKey(key: "testKey")
        XCTAssertEqual(value, "123")
    }
    
    func testIfKeyIsNotFound() {
        let value = loginViewModel.getValueFromKey(key: "testKey1")
        XCTAssertEqual(value, "")
    }

}
