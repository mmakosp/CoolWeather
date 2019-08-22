//
//  CurrentWeatherTableViewCell.swift
//  mmakosCoolsApp
//
//  Created by Mmako Sekhosana on 2019/08/17.
//  Copyright © 2019 Mmako Sekhosana. All rights reserved.
//

import UIKit

enum FontSize: Int {
    case normal
    case normalBold
    case bigsize
}

class CurrentWeatherTableViewCell: UITableViewCell {

    let dataModel = WeatherDataModel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
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
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let weatherComponentLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 21)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    func updateWeatherLabels(indexNumber: Int) -> String {
        switch indexNumber {
        case 0:
            return dataModel.city
        case 1:
            return "08:06"
        case 2:
            return "26"
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
