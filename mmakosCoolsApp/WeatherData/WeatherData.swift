
//
//  WeatherData.swift
//  mmakosCoolsApp
//
//  Created by Mmako Sekhosana on 2019/08/05.
//  Copyright © 2019 Mmako Sekhosana. All rights reserved.
//

public struct WeatherData {
    
    public let lat: Double
    public let long: Double
    
    public let hourData: [WeatherHourData]
    
    public init(lat: Double, long: Double, hourData: [WeatherHourData]) {
        self.lat = lat
        self.long = long
        self.hourData = hourData
    }
    
}

extension WeatherData: JSONDecodable {
    
    public init(decoder: JSONDecoder) throws {
        self.lat = try decoder.decode(key: "latitude")
        self.long = try decoder.decode(key: "longitude")
        self.hourData = try decoder.decode(key: "hourly.data")
    }
    
}
