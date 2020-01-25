//
//  DetailViewModel.swift
//  iOS-Assignement
//
//  Created by Jérémie Boisjoli on 2020-01-24.
//  Copyright © 2020 Jérémie Boisjoli. All rights reserved.
//

import Foundation

class DetailViewModel {
    
    //MARK: Variable
    let repositoryManagerDelegate: RepositoryManagerDelegate
    
    //MARK: Init
    init(repositoryManagerDelegate: RepositoryManagerDelegate) {
        self.repositoryManagerDelegate = repositoryManagerDelegate
    }
    
    //MARK: - Function
    func getUserFromRepository(success: @escaping (Object?) -> Void,
                               failure: @escaping (NetworkError?) -> Void) {
        
        guard let playlistId = UserDefaults.standard.string(forKey: "selectedPlaylistId") else { return }
        
        let url = LoginViewService.baseUrl + LoginViewService.getPlaylistWithId +
            "&playlistId=\(playlistId)" + "&key=\(LoginViewService.apiKey)"
        
        repositoryManagerDelegate.getRepository(type: Object.self, url, success: { (response) in
      
            success(response)
        }) { (error) in
            print(error as Any)
        }
    }
    
}
