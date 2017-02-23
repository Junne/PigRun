//
//  Location.swift
//  PigRun
//
//  Created by baijf on 23/02/2017.
//  Copyright © 2017 Junne. All rights reserved.
//

import RealmSwift
import Foundation

class Location: Object {
    
    dynamic var longitude: Double = 0.0
    dynamic var latitude: Double = 0.0
    dynamic var timestamp: Date?
    
    
// Specify properties to ignore (Realm won't persist these)
    
//  override static func ignoredProperties() -> [String] {
//    return []
//  }
}
