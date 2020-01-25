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
    func getUserFromRepository(nextPageToken: String? = nil,
                               success: @escaping (Object?) -> Void,
                               failure: @escaping (NetworkError?) -> Void) {
        
        guard let playlistId = UserDefaults.standard.string(forKey: "selectedPlaylistId") else { return }
        
        var url = ""
        
        if let nextPageToken = nextPageToken {
            url = LoginViewService.baseUrl + LoginViewService.getPlaylistWithId + "&playlistId=\(playlistId)" + "&pageToken=\(nextPageToken)" + "&key=\(LoginViewService.apiKey)"
            print(url)
        } else {
            url = LoginViewService.baseUrl + LoginViewService.getPlaylistWithId + "&playlistId=\(playlistId)" + "&key=\(LoginViewService.apiKey)"
            print(url)
        }
        
        repositoryManagerDelegate.getRepository(type: Object.self, url, success: { (response) in
            success(response)
        }) { (error) in
            print(error as Any)
        }
    }
    
    func getVideoDetailFromRepository(videoId: String,
                                      nextPageToken: String? = nil,
                                      success: @escaping (Object?) -> Void,
                                      failure: @escaping (NetworkError?) -> Void) {
        
        let url = LoginViewService.baseUrl + LoginViewService.getVideoId + "&id=\(videoId)" + "&key=\(LoginViewService.apiKey)"
                
        repositoryManagerDelegate.getRepository(type: Object.self, url, success: { (response) in
              success(response)
          }) { (error) in
              print(error as Any)
          }
    }
    
}
