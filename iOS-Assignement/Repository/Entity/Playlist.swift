//
//  Playlist.swift
//  iOS-Assignement
//
//  Created by Jérémie Boisjoli on 2020-01-23.
//  Copyright © 2020 Jérémie Boisjoli. All rights reserved.
//

import Foundation

struct Playlist: Codable {
    let title: String?
    let thumbnail: String?
    let number: Int
    
    init(title: String? = nil, thumbnail: String? = nil, number: Int = 0) {
        self.title = title
        self.thumbnail = thumbnail
        self.number = number
    }
}
