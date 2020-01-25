//
//  Thumbnails.swift
//  iOS-Assignement
//
//  Created by Jérémie Boisjoli on 2020-01-24.
//  Copyright © 2020 Jérémie Boisjoli. All rights reserved.
//

import Foundation

struct Thumbnails: Codable {
    let standard: Standard?
}

struct Standard: Codable {
    let url: String?
    let width: Int
    let height: Int
}
