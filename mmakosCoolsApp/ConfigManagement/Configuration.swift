//
//  Configuration.swift
//  mmakosCoolsApp
//
//  Created by Mmako Sekhosana on 2019/08/04.
//  Copyright © 2019 Mmako Sekhosana. All rights reserved.
//

import Foundation

struct API {
    
    static let APIKey = "4fa9b99cde25c19f78dbff9311e7b75a"
    static let BaseURL = URL(string: "https://api.darksky.net/forecast/")!
    
    static var AuthenticatedBaseURL: URL {
        return BaseURL.appendingPathComponent(APIKey)
    }

}

struct Defaults {
    
    static let Latitude: Double = 37.8267
    static let Longitude: Double = -122.423
    
}
