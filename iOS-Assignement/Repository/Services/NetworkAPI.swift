//
//  LoginViewService.swift
//  iOS-Assignement
//
//  Created by Jérémie Boisjoli on 2020-01-24.
//  Copyright © 2020 Jérémie Boisjoli. All rights reserved.

import Foundation

struct NetworkAPI {
    static let apiKey = ""
    static let baseUrl = "https://www.googleapis.com/youtube/v3/" //we usually put baseUrl in configs to setup different environement (dev, test and prod)
    
    static let getPlaylistUrl = "playlists?part=snippet%2CcontentDetails&maxResults=10&mine=true&" //set filters inside VM's or services
    static let getPlaylistWithId = "playlistItems?part=snippet%2CcontentDetails&maxResults=10"
    static let getVideoId = "videos?part=snippet%2CcontentDetails%2Cstatistics"
}
