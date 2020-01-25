//
//  LoginViewService.swift
//  iOS-Assignement
//
//  Created by Jérémie Boisjoli on 2020-01-24.
//  Copyright © 2020 Jérémie Boisjoli. All rights reserved.
// GET https://www.googleapis.com/youtube/v3/playlists?part=snippet%2CcontentDetails&maxResults=25&mine=true&key=[YOUR_API_KEY] HTTP/1.1
// GET https://www.googleapis.com/youtube/v3/playlistItems?part=snippet%2CcontentDetails&maxResults=50&playlistId=FL246q6l7HiUwjsDBS9HQY2w&key=[YOUR_API_KEY] HTTP/1.1

//GET https://www.googleapis.com/youtube/v3/videos?part=snippet%2CcontentDetails%2Cstatistics&id=Ks-_Mh1QhMc&key=[YOUR_API_KEY] HTTP/1.1

//GET https://www.googleapis.com/youtube/v3/videos?part=snippet%2CcontentDetails%2Cstatistics&id=I8EcWhv2h2A&key=[YOUR_API_KEY] HTTP/1.1

//GET https://www.googleapis.com/youtube/v3/playlists?part=snippet%2CcontentDetails&channelId=UC_x5XG1OV2P6uZZ5FSM9Ttw&maxResults=5&pageToken=CAUQAA&key=[YOUR_API_KEY] HTTP/1.1
//GET https://www.googleapis.com/youtube/v3/videos?part=snippet%2CcontentDetails%2Cstatistics&id=I8EcWhv2h2A&pageToken=CAoQAA&key=AIzaSyDgDd696IAufTQqezRG2Wm-8Ce7HK7FVKU





import Foundation

struct LoginViewService {
    static let baseUrl = "https://www.googleapis.com/youtube/v3/" //we usually put baseUrl in configs to setup different environement (dev, test and prod)
    
    static let getPlaylistUrl = "playlists?part=snippet%2CcontentDetails&maxResults=10&mine=true&key=AIzaSyDgDd696IAufTQqezRG2Wm-8Ce7HK7FVKU"
    static let getPlaylistWithId = "playlistItems?part=snippet%2CcontentDetails&maxResults=10"
    static let getVideoId = "videos?part=snippet%2CcontentDetails%2Cstatistics"
    
    static let apiKey = ""
    
    
    
}
