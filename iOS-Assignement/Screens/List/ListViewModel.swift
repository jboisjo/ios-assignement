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
    let database: Database
    
    //MARK: - Init
    init(repositoryManagerDelegate: RepositoryManagerDelegate, database: Database) {
        self.repositoryManagerDelegate = repositoryManagerDelegate
        self.database = database
    }
    
    //MARK: - Function
    func getPlaylistsFromRepository(success: @escaping (ObjectPlaylist?) -> Void,
                                    failure: @escaping (NetworkError?) -> Void) {
        
        repositoryManagerDelegate.getRepository(type: ObjectPlaylist.self, NetworkAPI.getPlaylistUrl, success: { [weak self] (response) in
            self?.saveDataInDatabase(playlist: response)
            success(response)
            }) { (error) in failure(error)}
    }
    
    func getNextPlaylistsFromRepository(nextPageToken: String,
                                        success: @escaping (ObjectPlaylist?) -> Void,
                                        failure: @escaping (NetworkError?) -> Void) {
        
        repositoryManagerDelegate.getRepository(type: ObjectPlaylist.self, NetworkAPI.getPlaylistUrl + "&pageToken=\(nextPageToken)",
            success: { [weak self] (response) in
                        self?.saveDataInDatabase(playlist: response)
                        success(response)
            }) { (error) in failure(error)}
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
        
        self.database.update(itemsPlaylistEntity)
    }
}
