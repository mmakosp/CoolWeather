//
//  CurrentWeatherTableViewCell.swift
//  mmakosCoolsApp
//
//  Created by Mmako Sekhosana on 2019/08/17.
//  Copyright © 2019 Mmako Sekhosana. All rights reserved.
//

import UIKit
import Foundation
import Alamofire
import SwiftyJSON

enum FontSize: Int {
    case normal
    case normalBold
    case bigsize
}

public class CurrentWeatherTableViewCell: UITableViewCell {
    
    let weatherDataModel = WeatherDataModel()
    let config = Config()
    var temperature : Int = 0
    var condition : String = ""
    var city : String = "Pretoria"
    var minTemp : Int = 0
    var maxTemp : Int = 0
    var weatherTime : String = ""
    let masterVC = MasterViewController()
    
    var temperatureVar: Int = {
        let tempString = Int()
        return tempString
    }()

    
    override public func awakeFromNib() {
        super.awakeFromNib()
    }

    override public func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCitiesViewCells()
        getUpdateWeather(city: MasterViewController.currentCity)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let cellView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let weatherComponentLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.gray
        label.font = UIFont.boldSystemFont(ofSize: 21)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    func getUpdateWeather(city: String) {
        
        let params : [String : String] = ["q" : city, "appid" : config.APP_ID]
        
        getWeatherData(url: config.WEATHER_URL, parameters: params)
    }
    
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
        
        
        temperatureVar = Int(convertTempToCelcius(convertTemp: json["main"]["temp"].doubleValue))
        
        city = json["name"].stringValue
        
        condition = json["weather"][0]["description"].stringValue
        
        minTemp = Int(convertTempToCelcius(convertTemp: json["main"]["temp_min"].doubleValue))
        
        maxTemp = Int(convertTempToCelcius(convertTemp: json["main"]["temp_max"].doubleValue))
        
        //weatherTime = UTCToLocal(date: json["dt"].intValue)
        
    }
    
    func convertTempToCelcius(convertTemp : Double) -> Double{
        return (convertTemp - 273.15)
    }
    
    func updateWeatherLabels(indexNumber: Int) -> String {
        
        switch indexNumber {
        case 0:
            return "City \(city)"
        case 1:
            return "Time : --:--"
        case 2:
            return "\(temperatureVar) °C"
        case 3:
            return "Min : \(minTemp)"
        case 4:
            return "Max : \(maxTemp)"
        case 5:
            return "Condition : \(condition)"
        default:
            return "N/A"
        }
    }
    
    func asFont(indexNumber: Int) -> UIFont {
        
        switch indexNumber {
        case 0:
            return UIFont.boldSystemFont(ofSize: 16)
        case 2:
            return UIFont.boldSystemFont(ofSize: 56)
        default :
            return UIFont.systemFont(ofSize: 16)
        }
    }
    
    func setupCitiesViewCells() {
        addSubview(cellView)
        cellView.addSubview(weatherComponentLabel)
        self.selectionStyle = .none
        
        NSLayoutConstraint.activate([
            cellView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            cellView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
            cellView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            cellView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            ])
        
        weatherComponentLabel.heightAnchor.constraint(equalToConstant: 200).isActive = true
        weatherComponentLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        weatherComponentLabel.centerYAnchor.constraint(equalTo: cellView.centerYAnchor).isActive = true
        weatherComponentLabel.centerXAnchor.constraint(equalTo: cellView.centerXAnchor).isActive = true
        weatherComponentLabel.leftAnchor.constraint(equalTo: cellView.leftAnchor, constant: 20).isActive = true
    }
}
