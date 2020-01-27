//
//  DetailViewModel.swift
//  iOS-Assignement
//
//  Created by Jérémie Boisjoli on 2020-01-24.
//  Copyright © 2020 Jérémie Boisjoli. All rights reserved.
//

import Foundation

class DetailViewModel {
    
    //MARK: Variables
    let repositoryManagerDelegate: RepositoryManagerDelegate
    
    //MARK: Init
    init(repositoryManagerDelegate: RepositoryManagerDelegate) {
        self.repositoryManagerDelegate = repositoryManagerDelegate
    }
    
    //MARK: - Functions
    func getTracksFromPlaylist(nextPageToken: String? = nil,
                               success: @escaping (ObjectPlaylist?) -> Void,
                               failure: @escaping (NetworkError?) -> Void) {
        
        guard let playlistId = UserDefaults.standard.string(forKey: "selectedPlaylistId") else { return }
        var url = ""
 
        if let nextPageToken = nextPageToken {
            url = NetworkAPI.getPlaylistWithId + "&playlistId=\(playlistId)" + "&pageToken=\(nextPageToken)"
        } else {
            url = NetworkAPI.getPlaylistWithId + "&playlistId=\(playlistId)"
        }
        
        repositoryManagerDelegate.getRepository(type: ObjectPlaylist.self, url, success: { (response) in
            success(response)
            response.items
        }) { (error) in
            failure(error)
        }
    }
    
    func getVideoDetailFromRepository(videoId: String,
                                      success: @escaping (ObjectPlaylist?) -> Void,
                                      failure: @escaping (NetworkError?) -> Void) {
    
        repositoryManagerDelegate.getRepository(type: ObjectPlaylist.self,
                                                NetworkAPI.getVideoId + "&id=\(videoId)",
                                                success: { (response) in
                                                  success(response)
                                                }) { (error) in
                                                    failure(error)}
    }
    
    
}
