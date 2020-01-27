//
//  ItemsVideoEntity.swift
//  iOS-Assignement
//
//  Created by Jérémie Boisjoli on 2020-01-26.
//  Copyright © 2020 Jérémie Boisjoli. All rights reserved.
//

import Foundation
import RealmSwift

class ItemsVideoEntity: Object {
    @objc dynamic var playlistId: String?
    @objc dynamic var nextPageToken: String?
    var playlists = List<VideoEntity>()
    
    override static func primaryKey() -> String? {
        return "nextPageToken"
    }
}
