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

class MasterViewController: UIViewController {
    
    //let dataManager = DataManager()

    override func viewDidLoad() {
        super.viewDidLoad()
       self.navigationItem.title = "Home Screen";
        
        self.view.backgroundColor = UIColor.blue
        
        // add the table view to self.view
        self.view.addSubview(tableView)
        
        // constrain the table view to 120-pts on the top,
        //  32-pts on left, right and bottom (just to demonstrate size/position)
        
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32.0).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 120.0).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -32.0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32.0).isActive = true
        
        // set delegate and datasource
        tableView.delegate = self as? UITableViewDelegate
        tableView.dataSource = self as? UITableViewDataSource
        
        // register a defalut cell
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.tableView.tableFooterView = UIView()
        //TODO:Set up the location manager here.
        
        locationManager.delegate = self as? CLLocationManagerDelegate
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = "\(indexPath)"
        
        return cell
    }
    
    // MARK: - Table view delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // etc
    }
    @IBAction func buttonPresentFutureWeather(_ sender: UIButton) {
        performSegue(withIdentifier: "SegueFromMasterToFuture", sender: self)
        
    }
    
    let tableView : UITableView = {
        let t = UITableView()
        t.translatesAutoresizingMaskIntoConstraints = false
        return t
    }()
    
    @IBOutlet weak var faren: UISwitch!
    
    @IBAction func `switch`(_ sender: UISwitch) {
        
        if sender.isOn {
            
        }
    }
    
    //TODO: Declare instance variables here
    let locationManager = CLLocationManager()
    let weatherDataModel = WeatherDataModel()
    
    
    
    //Pre-linked IBOutlets
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    
    @IBOutlet weak var button: UIButton!
    
    
    //        else {
    //            cityLabel.text = "Weather Unavailable"
    //        }
    //    }
    
    
    
    
    //MARK: - UI Updates
    /***************************************************************/
    
    
    //Write the updateUIWithWeatherData method here:
    
    func updateUIWithWeatherData() {
        
        cityLabel.text = weatherDataModel.city
        temperatureLabel.text = "\(weatherDataModel.temperature)°"
        weatherIcon.image = UIImage(named: weatherDataModel.weatherIconName)
        
    }
    
    
    //Write the didFailWithError method here:
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        cityLabel.text = weatherDataModel.city
    }
}

