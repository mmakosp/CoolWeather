//
//  AddCitiesViewController.swift
//  mmakosCoolsApp
//
//  Created by Mmako Sekhosana on 2019/08/07.
//  Copyright © 2019 Mmako Sekhosana. All rights reserved.
//

import UIKit
import RealmSwift
import Realm

class AddCitiesViewController: UIViewController, UITextFieldDelegate {
    
    let cities = ["One","Two","Three","Twenty-One"]
    
    var citi = [CityData]()
    let realm = try? Realm()
    let realmManager = RealmManager()
    var cityData : CityData?
    var isEditingData : Bool = false
    
    let newCityTextField : UITextField! = {
        let textField = UITextField(frame: CGRect(x: 70, y: 300, width: 300.00, height: 70));
        textField.placeholder = "Enter your city here"
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.textColor = UIColor.gray
        textField.resignFirstResponder()
        return textField
    }()
    
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        textField.resignFirstResponder()
//        return true
//    }
    
    let saveCityButton : UIButton = {
        let button = UIButton(frame: CGRect(x: 70, y: 400, width: 300, height: 70))
        button.backgroundColor = .gray
        button.setTitle("Add city to favourites", for: .normal)
        button.addTarget(self, action: #selector(saveCityButtonAction), for: .touchUpInside)
        return button
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        newCityTextField.text = cityData?.cityName ?? ""
        
        self.navigationItem.title = "Add Cities"
        self.view.addSubview(newCityTextField)
        self.view.addSubview(saveCityButton)
        
        self.newCityTextField.delegate = self
        
        saveCityButton.center.x = self.view.center.x
        saveCityButton.center.y = self.view.center.y
        
        
        newCityTextField.center.x = self.view.center.x
        newCityTextField.frame.origin.y = saveCityButton.frame.origin.y - (newCityTextField.frame.height) - 45
        
        
    }
    
    func addAlertAfterSave() {
        let alertController = UIAlertController(title: "New city", message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        
        let newcityAction = UIAlertAction(title: "Add \(newCityTextField.text!) to your favourites", style: .default, handler: {(alert: UIAlertAction!) in
            self.addNewCity()})
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {(alert: UIAlertAction!) in })
        
        alertController.addAction(newcityAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion:{})
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    @objc func saveCityButtonAction(sender: UIButton!) {
        if newCityTextField.text?.count == 0 {
            showEmptyCityAlert()
            return
        }
        addAlertAfterSave()
    }
    
    func addNewCity() {
        
        if isEditingData == true {
            let newCityData = CityData(cityCode : (cityData?.cityCode)! , cityName : newCityTextField.text ?? "")
            realmManager.editObjects(objs: newCityData)
        }
            // Adding the new city
        else if isEditingData == false {
            let cityCode = realmManager.incrementCityCode()
            let newCityData = CityData(cityCode : cityCode , cityName : newCityTextField.text ?? "")
            realmManager.saveCityObject(objs: newCityData)
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    func showEmptyCityAlert() {
        let alertController = UIAlertController.init(title: "", message: "Please enter your city" , preferredStyle: .alert)
        let logoutAction = UIAlertAction.init(title: "Ok", style: .default) { (action) in
        }
        alertController.addAction(logoutAction)
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil)
        }
    }
}
