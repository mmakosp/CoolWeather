//
//  WeatherHourData.swift
//  mmakosCoolsApp
//
//  Created by Mmako Sekhosana on 2019/08/05.
//  Copyright © 2019 Mmako Sekhosana. All rights reserved.
//

import Foundation

public struct WeatherHourData {
    
    public let time: Date
    public let windSpeed: Int
    public let temperature: Double
    public let precipitation: Double
    
    public init(time: Date, windSpeed: Int, temperature: Double, precipitation: Double) {
        self.time = time
        self.windSpeed = windSpeed
        self.temperature = temperature
        self.precipitation = precipitation
    }
    
}

extension WeatherHourData: JSONDecodable {
    
    public init(decoder: JSONDecoder) throws {
        self.windSpeed = try decoder.decode(key: "windSpeed")
        self.temperature = try decoder.decode(key: "temperature")
        self.precipitation = try decoder.decode(key: "precipIntensity")
        
        let time: Double = try decoder.decode(key: "time")
        self.time = Date(timeIntervalSince1970: time)
    }
    
}
