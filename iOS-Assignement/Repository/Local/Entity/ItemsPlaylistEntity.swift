//
//  ExampleObject.swift
//  iOS-Assignement
//
//  Created by Jérémie Boisjoli on 2020-01-26.
//  Copyright © 2020 Jérémie Boisjoli. All rights reserved.
//

import Foundation
import RealmSwift

class ItemsPlaylistEntity: Object {
    @objc dynamic var nextPageToken: String?
    @objc dynamic var etag: String?
    let playlists = List<PlaylistsEntity>()
}

