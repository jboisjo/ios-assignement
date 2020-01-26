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
    
    //MARK: - Functions
    func getTracksFromPlaylist(nextPageToken: String? = nil,
                               success: @escaping (Object?) -> Void,
                               failure: @escaping (NetworkError?) -> Void) {
        
        guard let playlistId = UserDefaults.standard.string(forKey: "selectedPlaylistId") else { return }
        var url = ""
 
        if let nextPageToken = nextPageToken {
            url = NetworkAPI.getPlaylistWithId + "&playlistId=\(playlistId)" + "&pageToken=\(nextPageToken)" + "&key=\(NetworkAPI.apiKey)"
        } else {
            url = NetworkAPI.getPlaylistWithId + "&playlistId=\(playlistId)" + "&key=\(NetworkAPI.apiKey)"
        }
        
        repositoryManagerDelegate.getRepository(type: Object.self, url, success: { (response) in
            success(response)
        }) { (error) in
            failure(error)
        }
    }
    
    func getVideoDetailFromRepository(videoId: String,
                                      success: @escaping (Object?) -> Void,
                                      failure: @escaping (NetworkError?) -> Void) {
    
        let url = NetworkAPI.getVideoId + "&id=\(videoId)" + "&key=\(NetworkAPI.apiKey)"
   
        repositoryManagerDelegate.getRepository(type: Object.self, url, success: { (response) in
              success(response)
          }) { (error) in
              failure(error)
          }
    }
}
