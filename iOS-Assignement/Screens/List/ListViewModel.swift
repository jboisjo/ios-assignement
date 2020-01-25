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
    func getUserFromRepository(nextPageToken: String? = nil,
                               success: @escaping (Object?) -> Void,
                               failure: @escaping (NetworkError?) -> Void) {
        
        var url = ""
        
        if let token = nextPageToken {
            url = LoginViewService.baseUrl + LoginViewService.getPlaylistUrl + "&pageToken=\(token)" + "&key=\(LoginViewService.apiKey)"
        } else {
            url = LoginViewService.baseUrl + LoginViewService.getPlaylistUrl + "&key=\(LoginViewService.apiKey)"
        }
        
        repositoryManagerDelegate.getRepository(type: Object.self, url, success: { (response) in
            success(response)
        }) { (error) in
            //print(error as Any)
        }
    }
    
}
