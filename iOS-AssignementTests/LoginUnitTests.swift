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
    }

    override func tearDown() {
        loginViewModel = nil
        loginViewController = nil
        userDefault = nil
    }
    
    func testLoginVM_IfUserDefaultHasValue() {
        loginViewController.viewDidLoad()
        loginViewController.setAccessTokenLocal("123", key: "testKey")
        let value = loginViewModel.getValueFromKey(key: "testKey")
        XCTAssertEqual(value, "123")
    }
    
    func testLoginVM_IfKeyIsNotFound() {
        let value = loginViewModel.getValueFromKey(key: "testKey1")
        XCTAssertEqual(value, "")
    }
    
    func testBaseVC_AlertViewNotNil() {
        XCTAssertNotNil(loginViewController.showAlert(title: "Title", message: "Alert"))
    }
}
