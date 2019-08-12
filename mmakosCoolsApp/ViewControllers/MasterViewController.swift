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
        //TODO:Set up the location manager here.
        
        locationManager.delegate = self as? CLLocationManagerDelegate
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        cityLabel.text = weatherDataModel.city
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
}

