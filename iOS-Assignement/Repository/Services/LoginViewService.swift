//
//  LoginViewService.swift
//  iOS-Assignement
//
//  Created by Jérémie Boisjoli on 2020-01-24.
//  Copyright © 2020 Jérémie Boisjoli. All rights reserved.
// GET https://www.googleapis.com/youtube/v3/playlists?part=snippet%2CcontentDetails&maxResults=25&mine=true&key=[YOUR_API_KEY] HTTP/1.1


import Foundation

struct LoginViewService {
    static let baseUrl = "https://www.googleapis.com/youtube/v3/" //we usually put baseUrl in configs to setup different environement (dev, test and prod)
    
    static let getPlaylistUrl = "playlists?part=snippet%2CcontentDetails&maxResults=25&mine=true&key=AIzaSyAhkx80I5cOJkYN3YijGC6e6K4K-uqHL10"
    static let getPlaylistWithId = "playlistItems?part=snippet"
    
    static let apiKey = "AIzaSyAhkx80I5cOJkYN3YijGC6e6K4K-uqHL10"
    
}
