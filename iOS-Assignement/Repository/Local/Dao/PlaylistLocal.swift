//
//  PlaylistLocal.swift
//  iOS-Assignement
//
//  Created by Jérémie Boisjoli on 2020-01-26.
//  Copyright © 2020 Jérémie Boisjoli. All rights reserved.
//

import Foundation

class PlaylistLocal {
    
    let appDatabase: AppDatabase!
    
    init(appDatabase: AppDatabase) {
        self.appDatabase = appDatabase
    }
    
    //@Query("CREATE PLAYLIST * FROM playlist")
    func createPlaylistTable(tableName: String) {
        self.appDatabase.createTableForPlaylist(tableName: tableName)
    }
    
    //@Query("SELECT * FROM playlist")
    func listPlaylist(tableName: String) -> CurrentPlaylist? {
        if let current = self.appDatabase.listPlaylist(tableName: tableName) {
            return current
        }
        return nil
    }
    
    //@Query("INSERT INTO table_name VALUES (currentPlaylist)")
    func insertPlaylist(tableName: String, currentPlaylist: CurrentPlaylist) {
        self.appDatabase.insertPlaylist(tableName: tableName, currentPlaylist: currentPlaylist)
    }
    
    //@Query("UPDATE table_name SET column = value WHERE id = id")
    func updatePlaylist(tableName: String, currentPlaylist: CurrentPlaylist) {
        self.appDatabase.updatePlaylist(tableName: tableName, currentPlaylist: currentPlaylist)
    }
}
