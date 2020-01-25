//
//  LoginViewModel.swift
//  iOS-Assignement
//
//  Created by Jérémie Boisjoli on 2020-01-23.
//  Copyright © 2020 Jérémie Boisjoli. All rights reserved.
//

//https://jsonplaceholder.typicode.com/todos/1

import Foundation

class LoginViewModel {
    
    //MARK: Variable
    let repositoryManagerDelegate: RepositoryManagerDelegate
    
    //MARK: Init
    init(repositoryManagerDelegate: RepositoryManagerDelegate) {
        self.repositoryManagerDelegate = repositoryManagerDelegate
    }
    
    //MARK: - Function
    func getUserFromRepository() {
        repositoryManagerDelegate.getRepository(type: Object.self, LoginViewService.baseUrl + LoginViewService.getPlaylistUrl, success: { (response) in
        }) { (error) in
            //print(error as Any)
        }
    }
    
}
