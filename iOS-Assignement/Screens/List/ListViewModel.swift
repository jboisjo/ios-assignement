//
//  ListViewModel.swift
//  iOS-Assignement
//
//  Created by Jérémie Boisjoli on 2020-01-24.
//  Copyright © 2020 Jérémie Boisjoli. All rights reserved.
//

import Foundation
import RealmSwift


final class ListViewModel {
    
    //MARK: Variables
    let repositoryManagerDelegate: RepositoryManagerDelegate
    
    //MARK: - Init
    init(repositoryManagerDelegate: RepositoryManagerDelegate) {
        self.repositoryManagerDelegate = repositoryManagerDelegate
    }
    
    //MARK: - Function
    func getPlaylistsFromRepository(success: @escaping (ObjectPlaylist?) -> Void,
                                    failure: @escaping (NetworkError?) -> Void) {
        
        repositoryManagerDelegate.getRepository(type: ObjectPlaylist.self,
                                                NetworkAPI.getPlaylistUrl,
                                                success: { (response) in
                                                    success(response)
                                                }) { (error) in
                                                    failure(error)}
    }
    
    func getNextPlaylistsFromRepository(nextPageToken: String,
                                        success: @escaping (ObjectPlaylist?) -> Void,
                                        failure: @escaping (NetworkError?) -> Void) {
        
        repositoryManagerDelegate.getRepository(type: ObjectPlaylist.self,
                                                NetworkAPI.getPlaylistUrl + "&pageToken=\(nextPageToken)",
                                                success: { (response) in
                                                    success(response)
                                                }) { (error) in
                                                    failure(error)}
    }
    
    func saveDataInDatabase(playlist: ObjectPlaylist?) {
        let itemsPlaylistEntity = ItemsPlaylistEntity()
        
        playlist?.items?.forEach({ (items) in
            let playlistEntity = PlaylistsEntity()
            playlistEntity.id = items.id
            playlistEntity.channelTitle = items.snippet?.channelTitle
            playlistEntity.title = items.snippet?.title
            playlistEntity.url = items.snippet?.thumbnails?.standard?.url
            playlistEntity.itemCount = items.contentDetails?.itemCount ?? 0
            itemsPlaylistEntity.playlists.append(playlistEntity)
        })
  
        itemsPlaylistEntity.etag = playlist?.etag
        itemsPlaylistEntity.nextPageToken = playlist?.nextPageToken
        
        Database().save(itemsPlaylistEntity)
    }
}
