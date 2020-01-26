//
//  LoginViewService.swift
//  iOS-Assignement
//
//  Created by Jérémie Boisjoli on 2020-01-24.
//  Copyright © 2020 Jérémie Boisjoli. All rights reserved.

import Foundation
import UIKit

struct NetworkAPI {
    static let apiKey = ""
    static let baseUrl = "https://www.googleapis.com/youtube/v3/" //we usually put baseUrl in configs to setup different environement (dev, test and prod)
    
    static let getPlaylistUrl = baseUrl + "playlists?part=snippet%2CcontentDetails&maxResults=10&mine=true" //set filters inside VM's or services
    static let getPlaylistWithId = baseUrl + "playlistItems?part=snippet%2CcontentDetails&maxResults=10"
    static let getVideoId = baseUrl + "videos?part=snippet%2CcontentDetails%2Cstatistics"
}
