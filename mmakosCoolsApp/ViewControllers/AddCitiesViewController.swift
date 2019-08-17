//
//  AddCitiesViewController.swift
//  mmakosCoolsApp
//
//  Created by Mmako Sekhosana on 2019/08/07.
//  Copyright © 2019 Mmako Sekhosana. All rights reserved.
//

import UIKit

class AddCitiesViewController: UIViewController, UITableViewDelegate,  UITableViewDataSource, UISearchResultsUpdating {
    
    let cities = ["One","Two","Three","Twenty-One"]
    var filteredTableData = [String]()
    var resultSearchController = UISearchController()
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // 1
        // return the number of sections
        return 1
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        filteredTableData.removeAll(keepingCapacity: false)
        
        let searchPredicate = NSPredicate(format: "SELF CONTAINS[c] %@", searchController.searchBar.text!)
        let array = (cities as NSArray).filtered(using: searchPredicate)
        filteredTableData = array as! [String]
        
        self.citiesResultsTableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return the number of rows
        if  (resultSearchController.isActive) {
            return filteredTableData.count
        } else {
            return cities.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! CityCell
        
        if (resultSearchController.isActive) {
            cell.textLabel?.text = filteredTableData[indexPath.row]
            
            return cell
        }
        else {
            cell.textLabel?.text = cities[indexPath.row]
            print(cities[indexPath.row])
            return cell
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearchController()

        self.navigationItem.title = "Add Cities"
        self.view.addSubview(citiesResultsTableView)
        setupCitiesResultsTableView()
        
        // Reload the table
        citiesResultsTableView.reloadData()
    }
    
    func setupCitiesResultsTableView() {
        
        citiesResultsTableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32.0).isActive = true
        citiesResultsTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 120.0).isActive = true
        citiesResultsTableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -32.0).isActive = true
        citiesResultsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -90.0).isActive = true
        
        
        
        // set delegate and datasource
        citiesResultsTableView.delegate = self
        citiesResultsTableView.dataSource = self
        
        // register a defalut cell
        citiesResultsTableView.register(CityCell.self, forCellReuseIdentifier: "cellId")
        self.citiesResultsTableView.tableFooterView = UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func setupSearchController() {
        resultSearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.sizeToFit()
            controller.searchBar.placeholder = "Find your city"
            citiesResultsTableView.tableHeaderView = controller.searchBar
            
            return controller
        })()
    }
    
    let citiesResultsTableView : UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorColor = UIColor.white
        return tableView
    }()
    

}
