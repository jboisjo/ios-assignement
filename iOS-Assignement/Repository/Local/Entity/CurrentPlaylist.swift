//
//  Playlist.swift
//  iOS-Assignement
//
//  Created by Jérémie Boisjoli on 2020-01-26.
//  Copyright © 2020 Jérémie Boisjoli. All rights reserved.
//

import Foundation

struct CurrentPlaylist: Codable {
    let id: Int?
    let playlistId: String?
    let playlistTitle: String?
    let playlistTracksCount: Int?
    let playlistImageUrl: String?
}
