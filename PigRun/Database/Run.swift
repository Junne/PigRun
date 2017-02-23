//
//  Run.swift
//  PigRun
//
//  Created by baijf on 23/02/2017.
//  Copyright © 2017 Junne. All rights reserved.
//

import RealmSwift
import Foundation

class Run: Object {
    
    dynamic var distance: Float = 0
    dynamic var duration: Double = 0.0
    dynamic var timestamp: Date?
    
// Specify properties to ignore (Realm won't persist these)
    
//  override static func ignoredProperties() -> [String] {
//    return []
//  }
}
