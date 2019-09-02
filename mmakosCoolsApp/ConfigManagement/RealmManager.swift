//
//  RealmManager.swift
//  mmakosCoolsApp
//
//  Created by Mmako Sekhosana on 2019/08/26.
//  Copyright © 2019 Mmako Sekhosana. All rights reserved.
//

import Foundation
import  RealmSwift

class RealmManager {
    let realm = try? Realm()
    
    // delete table
    func deleteDatabase() {
        try! realm?.write({
            realm?.deleteAll()
        })
    }
    
    // delete particular object
    func deleteObject(objs : Object) {
        try? realm?.write ({
            realm?.delete(objs)
        })
    }
    
    func saveCityObject(objs: Object) {
        try? realm?.write ({
            // If update = false, adds the object
            realm?.add(objs, update: true)
        })
    }
    
    // editing the object
    func editObjects(objs: Object) {
        try? realm?.write ({
            // If update = true, objects that are already in the Realm will be
            // updated instead of added a new.
            realm?.add(objs, update: true)
        })
    }
    
    //Returs an array as Results<object>?
    func getObjects(type: Object.Type) -> Results<Object>? {
        return realm?.objects(type)
    }
    
    func incrementCityCode() -> Int {
        return (realm?.objects(CityData.self).max(ofProperty: "cityCode") as Int? ?? 0) + 1
    }
    
}
