//
//  ManageCitiesViewController.swift
//  mmakosCoolsApp
//
//  Created by Mmako Sekhosana on 2019/08/07.
//  Copyright © 2019 Mmako Sekhosana. All rights reserved.
//

import UIKit
import CoreLocation
import Realm
import RealmSwift

class ManageCitiesViewController: UIViewController, UITableViewDelegate,  UITableViewDataSource {
    
    let realmManager = RealmManager()
    var cityArr  = [CityData]()
    let realm = try? Realm()
    
    var selectedCityCell : String = ""
    
    let locationManager = CLLocationManager()
    let dataManager = DataManager()
    let config = Config()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cityToView = cityArr[indexPath.row]
        let cell = citiesTableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! CityCell
        cell.backgroundColor = UIColor.white
        cell.cityViewLabel.text = cityToView.cityName
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentCell = tableView.cellForRow(at: indexPath) as! CityCell
        selectedCityCell = currentCell.cityViewLabel.text!
        userEnteredANewCityName(city: currentCell.cityViewLabel.text!)
        MasterViewController.currentCity = selectedCityCell
        
        let masteVC = MasterViewController() 
        masteVC.citynew = selectedCityCell
        masteVC.currentWeatherTableView.reloadData()
        self.navigationController?.popViewController(animated: true)
    }

    
    

    @IBOutlet weak var addCitiesButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       self.navigationItem.title = "Manage cities"
        
        // add the table view to self.view
        self.view.addSubview(citiesTableView)
        setupCitiesTableView()
        
        //TODO:Set up the location manager here.
        locationManager.delegate = self as? CLLocationManagerDelegate
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        if let fileUrl = Realm.Configuration.defaultConfiguration.fileURL{
            print("FILE URL IS",fileUrl)
        }
        
        getAllObjects()
        self.citiesTableView.reloadData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getAllObjects()
        citiesTableView.reloadData()
        setupCitiesTableView()
        
    }
    
    // fetch all the objects in table
    func getAllObjects() {
        cityArr = [CityData]()
        if let objects = realmManager.getObjects(type: CityData.self) {
            for element in objects {
                if let citiData = element as? CityData {
                    // Do whatever you like with 'person' object
                     print("\(citiData.cityName), \(citiData.cityCode) ")
                    cityArr.append(citiData)
                }
            }
        }
    }
    
    func setupCitiesTableView() {
        citiesTableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32.0).isActive = true
        citiesTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 120.0).isActive = true
        citiesTableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -32.0).isActive = true
        citiesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -90.0).isActive = true
        
        
        
        // set delegate and datasource
        citiesTableView.delegate = self
        citiesTableView.dataSource = self
        
        // register a defalut cell
        citiesTableView.register(CityCell.self, forCellReuseIdentifier: "cellId")
        self.citiesTableView.tableFooterView = UIView()
        
        self.view.addSubview(setupAddCityButton())
    }
    
    func setupAddCityButton() -> UIButton {
        let addCityButton = addCitiesButton!
        addCityButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        addCityButton.layer.cornerRadius = 0.5 * addCityButton.bounds.size.width
        addCityButton.clipsToBounds = true
        addCityButton.setTitle("+", for: .normal)
        addCityButton.setTitleColor( .white, for: .normal)
        addCityButton.backgroundColor = .blue
        //addCitybutton.center = self.view.center
        setAddCityConstraints()

        return addCityButton
    }
    
    func setAddCityConstraints() {
        addCitiesButton.translatesAutoresizingMaskIntoConstraints = false
        addCitiesButton.rightAnchor.constraint(equalTo: citiesTableView.safeAreaLayoutGuide.rightAnchor, constant: -135).isActive = true
        addCitiesButton.bottomAnchor.constraint(equalTo: citiesTableView.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCell.EditingStyle.delete) {
            // handle delete (by removing the data from your array and updating the tableview)
            tableView.beginUpdates()
            let citydata : CityData = cityArr[indexPath.row]
            // delete an Object
            realmManager.deleteObject(objs: citydata)
            cityArr.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath],  with: UITableView.RowAnimation.automatic)
            tableView.endUpdates()
        }
    }
    
    let citiesTableView : UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorColor = UIColor.white
        return tableView
    }()
    
    
    //Write the userEnteredANewCityName Delegate method here:
    func userEnteredANewCityName(city: String) {
        
        let params : [String : String] = ["q" : city, "appid" : config.APP_ID]
        
        DataManager().getWeatherData(url: config.WEATHER_URL, parameters: params)
        
    }
    

}

class CityCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCitiesViewCells()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let cellView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.gray
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let cityViewLabel: UILabel = {
        let label = UILabel()
        label.text = "Day 1"
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setupCitiesViewCells() {
        addSubview(cellView)
        
        cellView.addSubview(cityViewLabel)
        self.selectionStyle = .none
        
        NSLayoutConstraint.activate([
            cellView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            cellView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
            cellView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            cellView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            ])
        
        cityViewLabel.heightAnchor.constraint(equalToConstant: 200).isActive = true
        cityViewLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        cityViewLabel.centerYAnchor.constraint(equalTo: cellView.centerYAnchor).isActive = true
        cityViewLabel.leftAnchor.constraint(equalTo: cellView.leftAnchor, constant: 20).isActive = true
    }
}
