//
//  ViewController.swift
//  mmakosCoolsApp
//
//  Created by Mmako Sekhosana on 2019/07/30.
//  Copyright © 2019 Mmako Sekhosana. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON

class MasterViewController: UIViewController, UITableViewDelegate,  UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = currentWeatherTableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! CurrentWeatherTableViewCell
        cell.backgroundColor = UIColor.gray
        cell.weatherComponentLabel.text = cell.updateWeatherLabels(indexNumber: indexPath.row)
        cell.weatherComponentLabel.font = cell.asFont(indexNumber: indexPath.row)
        cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
        return cell
    }
    
    
    //let dataManager = DataManager()

    override func viewDidLoad() {
        super.viewDidLoad()
       self.navigationItem.title = "Home Screen";
        
        self.view.backgroundColor = UIColor.white
        //TODO:Set up the location manager here.
        
        locationManager.delegate = self as? CLLocationManagerDelegate
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        //cityLabel.text = weatherDataModel.city
        self.view.addSubview(currentWeatherTableView)
        setupCurrentWeatherTableView()
    }
    
    func setupCurrentWeatherTableView() {
        currentWeatherTableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0.0).isActive = true
        currentWeatherTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 150.0).isActive = true
        currentWeatherTableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0.0).isActive = true
        currentWeatherTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -90.0).isActive = true
        
        
        
        // set delegate and datasource
        currentWeatherTableView.delegate = self
        currentWeatherTableView.dataSource = self
        
        // register a defalut cell
        currentWeatherTableView.register(CurrentWeatherTableViewCell.self, forCellReuseIdentifier: "cellId")
        self.currentWeatherTableView.tableFooterView = UIView()
    }
    
    @IBAction func buttonPresentFutureWeather(_ sender: UIButton) {
        performSegue(withIdentifier: "SegueFromMasterToFuture", sender: self)
        
    }
    
    //TODO: Declare instance variables here
    let locationManager = CLLocationManager()
    let weatherDataModel = WeatherDataModel()
    
    
    @IBOutlet weak var cityLabel: UILabel!
    
    
    //Write the didFailWithError method here:
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        cityLabel.text = weatherDataModel.city
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    let currentWeatherTableView : UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorColor = UIColor.clear
        return tableView
    }()
}
