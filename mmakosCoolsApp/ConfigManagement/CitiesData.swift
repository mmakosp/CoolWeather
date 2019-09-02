//
//  CitiesData.swift
//  mmakosCoolsApp
//
//  Created by Mmako Sekhosana on 2019/08/26.
//  Copyright © 2019 Mmako Sekhosana. All rights reserved.
//

import UIKit
import  RealmSwift

class CityData: Object {
    
    @objc private(set) dynamic var cityCode = 1
    @objc private(set) dynamic var cityName = ""
    
    
    override static func primaryKey() -> String? {
        return "cityCode"
    }
    
    convenience init(cityCode : Int, cityName: String) {
        self.init()
        self.cityCode = cityCode
        self.cityName = cityName
    }
    
}
