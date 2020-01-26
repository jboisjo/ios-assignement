//
//  ItemsDatabase.swift
//  iOS-Assignement
//
//  Created by Jérémie Boisjoli on 2020-01-26.
//  Copyright © 2020 Jérémie Boisjoli. All rights reserved.
//

import Foundation

class ItemsLocal {
    
    let appDatabase: AppDatabase!
    
    init(appDatabase: AppDatabase) {
        self.appDatabase = appDatabase
    }
    
    //@Query("SELECT * FROM items ORDER BY full_name ASC")
}
