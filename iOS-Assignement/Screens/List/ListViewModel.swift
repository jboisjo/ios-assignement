//
//  ListViewModel.swift
//  iOS-Assignement
//
//  Created by Jérémie Boisjoli on 2020-01-24.
//  Copyright © 2020 Jérémie Boisjoli. All rights reserved.
//

import Foundation


final class ListViewModel {
    
    //MARK: Variable
    let repositoryManagerDelegate: RepositoryManagerDelegate
    
    //MARK: Init
    init(repositoryManagerDelegate: RepositoryManagerDelegate) {
        self.repositoryManagerDelegate = repositoryManagerDelegate
    }
    
    //MARK: - Function
    func getUserFromRepository(success: @escaping (Object?) -> Void,
                               failure: @escaping (NetworkError?) -> Void) {
        repositoryManagerDelegate.getRepository(type: Object.self, LoginViewService.baseUrl + LoginViewService.getPlaylistUrl, success: { (response) in
            success(response)
            print(response.items?[0].id)
        }) { (error) in
            print(error as Any)
        }
    }
    
}
