//
//  Todos+Transformables.swift
//  Todos
//
//  Created by Andrew Shepard on 5/23/16.
//  Copyright © 2016 Andrew Shepard. All rights reserved.
//

import Foundation
import CoreData
import GROCloudStore

extension Todo: ManagedObjectTransformable {
    
    func transform(object object: NSManagedObject) {
        guard let item = object.valueForKeyPath("item") as? String else { return }
        self.item = item
        
        guard let created = object.valueForKeyPath("created") as? NSDate else { return }
        self.created = created
        
        guard let data = object.valueForKeyPath("encodedSystemFields") as? NSData else { fatalError() }
        self.encodedSystemFields = data
    }
    
    class var entityName: String {
        return "GROPlant"
    }
}

extension Todo: CloudKitTransformable {
    
    func transform(record record: CKRecord) {
        guard let item = record["item"] as? String else { return }
        self.item = item
        
        guard let created = record["created"] as? NSDate else { return }
        self.created = created
        
        self.record = record
    }
    
    func transform() -> CKRecord {
        let record = self.record
        record["item"] = self.item
        record["created"] = self.created
        
        return record
    }
    
    func references(record: CKRecord) -> [CKReference: String] {
        return [:]
    }
    
    var recordType: String {
        return "Todo"
    }
    
    var valid: Bool {
        return (self.item != "")
    }
}