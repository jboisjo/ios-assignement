//
//  AppDatabase.swift
//  iOS-Assignement
//
//  Created by Jérémie Boisjoli on 2020-01-26.
//  Copyright © 2020 Jérémie Boisjoli. All rights reserved.
//

import Foundation
import SQLite

class AppDatabase {
    
    var database: Connection!
    
    init() {
        createDatabase()
    }
    
    func createDatabase() {
        do {
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileUrl = documentDirectory.appendingPathComponent("playlist").appendingPathExtension("sqlite3")
            let database = try Connection(fileUrl.path)
            self.database = database
        } catch {
            print("Unable to create local database")
        }
    }
    

    //MARK: - Playlist
    func createTableForPlaylist(tableName: String) { //this should be generic
        let playlistTable = Table(tableName)
        let id = Expression<Int>("id") //to validate
        let playlistId = Expression<String?>("playlistId")
        let playlistTitle = Expression<String?>("playlistTitle")
        let playlistTracksCount = Expression<Int?>("playlistTracksCount")
        let playlistImageUrl = Expression<String?>("playlistImageUrl")
        
        let createTable = playlistTable.create { (table) in
            table.column(id, primaryKey: true)
            table.column(playlistId)
            table.column(playlistTitle)
            table.column(playlistTracksCount)
            table.column(playlistImageUrl)
            
            print("Created table for Playlist \(tableName)")
        }
        
        do {
            try self.database.run(createTable)
        } catch {
            print(error)
        }
    }
    
    func insertPlaylist(tableName: String, currentPlaylist: CurrentPlaylist) { //this should be generic
        let playlistTable = Table(tableName)
        
        guard let playlistId = currentPlaylist.playlistId,
            let playlistTitle = currentPlaylist.playlistTitle ,
            let playlistTracksCount = currentPlaylist.playlistTracksCount,
            let playlistImageUrl = currentPlaylist.playlistImageUrl else { return }
        
        let playlistIdValue = Expression<String>("playlistId")
        let playlistTitleValue = Expression<String>("playlistTitle")
        let playlistTracksCountValue = Expression<Int?>("playlistTracksCount")
        let playlistImageUrlValue = Expression<String?>("playlistImageUrl")
        
        let insertPlaylist = playlistTable.insert(playlistIdValue <- playlistId,
                                                  playlistTitleValue <- playlistTitle,
                                                  playlistTracksCountValue <- playlistTracksCount,
                                                  playlistImageUrlValue <- playlistImageUrl)
        
        do {
            try self.database.run(insertPlaylist)
            print("Playlist has been inserted locally")
        } catch {
            print(error)
        }
    }
    
    func listPlaylist(tableName: String) -> CurrentPlaylist? { //this should be generic
        let playlistTable = Table(tableName)
        let id = Expression<Int>("id")
        let playlistId = Expression<String?>("playlistId")
        let playlistTitle = Expression<String?>("playlistTitle")
        let playlistTracksCount = Expression<Int?>("playlistTracksCount")
        let playlistImageUrl = Expression<String?>("playlistImageUrl")
        
        do {
            let table = try self.database.prepare(playlistTable)
            for playlist in table {
                
                let value = playlist[id]
                let playlistId = playlist[playlistId]
                let playlistTitle = playlist[playlistTitle]
                let playlistTracksCount = playlist[playlistTracksCount]
                let playlistImageUrl = playlist[playlistImageUrl]
                
                print("id :\(value), playlistId: \(playlistId), playlistTitle: \(playlistTitle), playlistTracksCount \(playlistTracksCount), playlistImageUrl \(playlistImageUrl)")
                
                return CurrentPlaylist(id: value,
                                       playlistId: playlistId,
                                       playlistTitle: playlistTitle,
                                       playlistTracksCount: playlistTracksCount,
                                       playlistImageUrl: playlistImageUrl)
            }
        } catch {
            print(error)
        }
        return nil
    }

    
    func updatePlaylist(tableName: String, currentPlaylist: CurrentPlaylist) {
        let playlistTable = Table(tableName)
        let id = Expression<Int>("id")
        let playlistId = Expression<String?>("playlistId")
        let playlistTitle = Expression<String?>("playlistTitle")
        let playlistTracksCount = Expression<Int?>("playlistTracksCount")
        let playlistImageUrl = Expression<String?>("playlistImageUrl")

        
        guard let currentId = currentPlaylist.id else {
            print("currentPlaylist id is nil")
            return
        }
        
        let user = playlistTable.filter(id == currentId)
        let updatePlaylist = user.update(playlistId <- currentPlaylist.playlistId,
                                         playlistTitle <- currentPlaylist.playlistTitle,
                                         playlistTracksCount <- currentPlaylist.playlistTracksCount,
                                         playlistImageUrl <- currentPlaylist.playlistImageUrl)

        do {
            try self.database.run(updatePlaylist)
        } catch {
            print(error)
        }
    }
}
