//
//  PlaylistDetail.swift
//  iOS-Assignement
//
//  Created by Jérémie Boisjoli on 2020-01-23.
//  Copyright © 2020 Jérémie Boisjoli. All rights reserved.
//

import Foundation

struct PlaylistDetail: Codable {
    let title: String?
    let thumbnail: String?
    let author: String?
    let duration: Int
    
    init(title: String? = nil, thumbnail: String? = nil, author: String? = nil, duration: Int = 0) {
        self.title = title
        self.thumbnail = thumbnail
        self.author = author
        self.duration = duration
    }
}
