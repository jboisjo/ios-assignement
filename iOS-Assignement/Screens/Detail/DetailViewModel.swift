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
            url = NetworkAPI.baseUrl + NetworkAPI.getPlaylistWithId + "&playlistId=\(playlistId)" + "&pageToken=\(nextPageToken)" + "&key=\(NetworkAPI.apiKey)"
            print(url)
        } else {
            url = NetworkAPI.baseUrl + NetworkAPI.getPlaylistWithId + "&playlistId=\(playlistId)" + "&key=\(NetworkAPI.apiKey)"
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
        
        let url = NetworkAPI.baseUrl + NetworkAPI.getVideoId + "&id=\(videoId)" + "&key=\(NetworkAPI.apiKey)"
                
        repositoryManagerDelegate.getRepository(type: Object.self, url, success: { (response) in
              success(response)
          }) { (error) in
              print(error as Any)
          }
    }
    
}
