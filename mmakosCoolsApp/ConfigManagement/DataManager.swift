//
//  DataManager.swift
//  mmakosCoolsApp
//
//  Created by Mmako Sekhosana on 2019/08/04.
//  Copyright © 2019 Mmako Sekhosana. All rights reserved.
//

import Foundation
import CoreLocation
import Alamofire
import SwiftyJSON

enum DataManagerError: Error {
    
    case Unknown
    case FailedRequest
    case InvalidResponse
    
}
public class DataManager {
    
    //TODO: Declare instance variables here
    let weatherDataModel = WeatherDataModel()
    let masterClass = MasterViewController()
    let config = Config()
    
    func getWeatherData(url: String, parameters: [String: String]) {
        
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON {
            response in
            if response.result.isSuccess {
                
                print("Success! Got the weather data")
                let weatherJSON : JSON = JSON(response.result.value!)
                
                
                print(weatherJSON)
                
                self.updateWeatherData(json: weatherJSON)
                
            }
            else {
                print("Error \(String(describing: response.result.error))")
                //self.weatherDataModel.city = "Check your Internet Connection"
            }
        }
        
    }
    func updateWeatherData(json : JSON) {

        weatherDataModel.temperature = Int(convertTempToCelcius(convertTemp: json["main"]["temp"].doubleValue))

        weatherDataModel.city = json["name"].stringValue

        weatherDataModel.condition = json["weather"][0]["description"].stringValue
        
        weatherDataModel.minTemp = Int(convertTempToCelcius(convertTemp: json["main"]["temp_min"].doubleValue))
        
        weatherDataModel.maxTemp = Int(convertTempToCelcius(convertTemp: json["main"]["temp_max"].doubleValue))
        
        //weatherDataModel.weatherTime = UTCToLocal(date: json["dt"].intValue)

        //masterClass.updateUIWithWeatherData()
    }
    
    func UTCToLocal(date:Int) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "H:mm:ss"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        let dt = dateFormatter.date(from: String(date))
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "h:mm a"
        
        return dateFormatter.string(from: dt!)
    }
    
    func convertTempToCelcius(convertTemp : Double) -> Double{
        return (convertTemp - 273.15)
    }
    
    //Write the didUpdateLocations method here:
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count - 1]
        if location.horizontalAccuracy > 0 {
            
            //self.locationManager.stopUpdatingLocation()
            
            print("longitude = \(location.coordinate.longitude), latitude = \(location.coordinate.latitude)")
            
            let latitude = String(location.coordinate.latitude)
            let longitude = String(location.coordinate.longitude)
            
            let params : [String : String] = ["lat" : latitude, "lon" : longitude, "appid" : config.APP_ID]
            
            getWeatherData(url: config.WEATHER_URL, parameters: params)
        }
    }
    
    
    //Write the didFailWithError method here:
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        //weatherDataModel.city = "Location Unavailable"
    }
}
