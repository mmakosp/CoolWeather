//
//  ManageCitiesViewController.swift
//  mmakosCoolsApp
//
//  Created by Mmako Sekhosana on 2019/08/07.
//  Copyright © 2019 Mmako Sekhosana. All rights reserved.
//

import UIKit

class ManageCitiesViewController: UIViewController {
    

    @IBOutlet weak var addCitiesButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       self.navigationItem.title = "Manage cities"
        
        self.view.backgroundColor = UIColor.orange
        
        // add the table view to self.view
        self.view.addSubview(citiesTableView)
        
        // constrain the table view to 120-pts on the top,
        //  32-pts on left, right and bottom (just to demonstrate size/position)
        
        citiesTableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32.0).isActive = true
        citiesTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 120.0).isActive = true
        citiesTableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -32.0).isActive = true
        citiesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -90.0).isActive = true
        
        // set delegate and datasource
        citiesTableView.delegate = self as? UITableViewDelegate
        citiesTableView.dataSource = self as? UITableViewDataSource
        
        // register a defalut cell
        citiesTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.citiesTableView.tableFooterView = UIView()
        
        self.view.addSubview(setupAddCityButton())
        
        //set constrains
    }
    
    func setupAddCityButton() -> UIButton {
        let addCityButton = addCitiesButton!
        addCityButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        addCityButton.layer.cornerRadius = 0.5 * addCityButton.bounds.size.width
        addCityButton.clipsToBounds = true
        addCityButton.setTitle("+", for: .normal)
        addCityButton.setTitleColor( .white, for: .normal)
        addCityButton.backgroundColor = .gray
        //addCitybutton.center = self.view.center
        //set constrains
        addCityButton.translatesAutoresizingMaskIntoConstraints = false
        addCityButton.rightAnchor.constraint(equalTo: citiesTableView.safeAreaLayoutGuide.rightAnchor, constant: -135).isActive = true
        addCityButton.bottomAnchor.constraint(equalTo: citiesTableView.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        return addCityButton
    }
    
    let citiesTableView : UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

}
