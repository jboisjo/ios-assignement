
//  Playlist.swift
//  iOS-Assignement
//
//  Created by Jérémie Boisjoli on 2020-01-26.
//  Copyright © 2020 Jérémie Boisjoli. All rights reserved.
//

import Foundation
import RealmSwift

public class Database {
    
    var realm: Realm? {
        do {
            return try Realm()
        } catch {
            print(error)
        }
        
        return nil
    }
    
    func save<T: Object>(_ object: T) {
        do {
            try realm?.write {
                // finds an existing copy of the object (with the same primary key), and update it. Otherwise, the object will be added.
                realm?.add(object)
            }
        } catch {
            print("Error saving realm object: \(object.self) with error: \(error)")
        }
    }
    
    func update<T: Object>(_ object: T) {
        do {
            try realm?.write {
                // finds an existing copy of the object (with the same primary key), and update it. Otherwise, the object will be added.
                realm?.add(object, update: .modified)
                
            }
        } catch {
            print("Error saving realm object: \(object.self) with error: \(error)")
        }
    }
    
    func getAll<T: Object>(_ object: T.Type) -> Results<T>? {
        return realm?.objects(T.self)
    }
    
    func delete<T: Object>(_ object: T) {
        do {
            try realm?.write {
                realm?.delete(object)
            }
        } catch {
            print("Error deleting a single object: \(object.self) with error: \(error)")
        }
    }
    func deleteAll<T: Object>(_ object: T) {
        do {
            if let allObjects = realm?.objects(T.self) {
                try realm?.write {
                    realm?.delete(allObjects)
                }
            }
        } catch {
            print("Error deleting all objects of type: \(object.self) with error: \(error)")
        }
    }
    func deleteAll() {
        do {
            try realm?.write {
                realm?.deleteAll()
            }
        } catch {
            print("Error deleting all realm objects with error: \(error)")
        }
    }
}
