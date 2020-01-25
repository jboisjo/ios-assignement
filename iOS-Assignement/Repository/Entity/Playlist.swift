//
//  Playlist.swift
//  iOS-Assignement
//
//  Created by Jérémie Boisjoli on 2020-01-23.
//  Copyright © 2020 Jérémie Boisjoli. All rights reserved.
//

import Foundation

struct Playlist: Codable {
    let nextPageToken: String?
    let pageInfo: Int
    let resultsPerPage: Int
    let items: [Items]
}
