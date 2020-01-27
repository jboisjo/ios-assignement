//
//  VideoEntity.swift
//  iOS-Assignement
//
//  Created by Jérémie Boisjoli on 2020-01-26.
//  Copyright © 2020 Jérémie Boisjoli. All rights reserved.
//

import RealmSwift
import Foundation

class VideoEntity: Object {
    @objc dynamic var nextPageToken: String?
    @objc dynamic var id: String?
    @objc dynamic var title: String?
    @objc dynamic var channelTitle: String?
    @objc dynamic var url: String?
    @objc dynamic var videoId: String?
    @objc dynamic var duration: String?
}
