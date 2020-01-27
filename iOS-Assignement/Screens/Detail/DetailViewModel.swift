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
        
        repositoryManagerDelegate.getRepository(type: ObjectPlaylist.self, url, success: { [weak self] (response) in
            success(response)
            self?.saveDataInDatabase(playlist: response)
        }) { (error) in
            failure(error)
        }
    }
    
    func getVideoDetailFromRepository(videoId: String,
                                      success: @escaping (ObjectPlaylist?) -> Void,
                                      failure: @escaping (NetworkError?) -> Void) {
    
        repositoryManagerDelegate.getRepository(type: ObjectPlaylist.self,
                                                NetworkAPI.getVideoId + "&id=\(videoId)",
                                                success: { [weak self] (response) in
                                                    self?.updateDataInDatabase(playlist: response, videoId: videoId)
                                                  success(response)
                                                }) { (error) in
                                                    failure(error)}
    }
    
    func saveDataInDatabase(playlist: ObjectPlaylist?) {
        let itemsVideoEntity = ItemsVideoEntity()
          
        playlist?.items?.forEach({ (items) in
            let videoEntity = VideoEntity()
            videoEntity.id = items.id
            videoEntity.channelTitle = items.snippet?.channelTitle
            videoEntity.title = items.snippet?.title
            videoEntity.url = items.snippet?.thumbnails?.standard?.url
            videoEntity.duration = items.contentDetails?.duration
            videoEntity.videoId = items.contentDetails?.videoId
            itemsVideoEntity.playlists.append(videoEntity)
          })
    
        if let playlistId = UserDefaults.standard.string(forKey: "selectedPlaylistId") {
            itemsVideoEntity.playlistId = playlistId
        }
        
        itemsVideoEntity.nextPageToken = playlist?.nextPageToken
          
        Database().update(itemsVideoEntity)
    }
    
    func updateDataInDatabase(playlist: ObjectPlaylist?, videoId: String) {
        let value = Database().realm?.objects(VideoEntity.self).filter("videoId = %@", videoId).first
        if let result = playlist?.items?.first(where: { $0.id == value?.videoId }), let videoEntity = value {
            
            do {
                try Database().realm?.write {
                    videoEntity.duration = result.contentDetails?.duration
                }
            } catch {
                print("Unable to update values in the database")
            }
            
        }
    }
}
