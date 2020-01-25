//
//  Item.swift
//  iOS-Assignement
//
//  Created by Jérémie Boisjoli on 2020-01-24.
//  Copyright © 2020 Jérémie Boisjoli. All rights reserved.
//

import Foundation

struct Object: Codable {
    let items: [Items]?
    let etag: String?
    let nextPageToken: String?
}

struct Items: Codable {
    let id: String?
    let snippet: Snippet?
    let contentDetails: ContentDetails?
    
}
