//
//  HomeViewController.swift
//  IntelligentPlanting
//
//  Created by Howard Wang on 3/24/18.
//  Copyright © 2018 Howard Wang. All rights reserved.
//

import UIKit
import CoreLocation
import FirebaseDatabase
import UserNotifications

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var locationManager = CLLocationManager()
    
    var plantData = [String]()
    
    let stateDictionary: [String : String] = [
        "AK" : "Alaska",
        "AL" : "Alabama",
        "AR" : "Arkansas",
        "AS" : "American Samoa",
        "AZ" : "Arizona",
        "CA" : "California",
        "CO" : "Colorado",
        "CT" : "Connecticut",
        "DC" : "District of Columbia",
        "DE" : "Delaware",
        "FL" : "Florida",
        "GA" : "Georgia",
        "GU" : "Guam",
        "HI" : "Hawaii",
        "IA" : "Iowa",
        "ID" : "Idaho",
        "IL" : "Illinois",
        "IN" : "Indiana",
        "KS" : "Kansas",
        "KY" : "Kentucky",
        "LA" : "Louisiana",
        "MA" : "Massachusetts",
        "MD" : "Maryland",
        "ME" : "Maine",
        "MI" : "Michigan",
        "MN" : "Minnesota",
        "MO" : "Missouri",
        "MS" : "Mississippi",
        "MT" : "Montana",
        "NC" : "North Carolina",
        "ND" : " North Dakota",
        "NE" : "Nebraska",
        "NH" : "New Hampshire",
        "NJ" : "New Jersey",
        "NM" : "New Mexico",
        "NV" : "Nevada",
        "NY" : "New York",
        "OH" : "Ohio",
        "OK" : "Oklahoma",
        "OR" : "Oregon",
        "PA" : "Pennsylvania",
        "PR" : "Puerto Rico",
        "RI" : "Rhode Island",
        "SC" : "South Carolina",
        "SD" : "South Dakota",
        "TN" : "Tennessee",
        "TX" : "Texas",
        "UT" : "Utah",
        "VA" : "Virginia",
        "VI" : "Virgin Islands",
        "VT" : "Vermont",
        "WA" : "Washington",
        "WI" : "Wisconsin",
        "WV" : "West Virginia",
        "WY" : "Wyoming"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.distanceFilter = 50
        
        locationManager.requestLocation()
        
        //Notifications
        var ref: DatabaseReference!
        
        ref = Database.database().reference().child("SID").child("111111111111")
        
        DispatchQueue.global(qos: .background).async {
            ref.observe(DataEventType.value, with: { (snapshot) in
                if let postDict = snapshot.value as? [String] {
                    if(Int(postDict[postDict.count - 1])! > 280) {
                        let calendar = Calendar.current
                        let selectedDate = calendar.date(byAdding: .minute, value: 1, to: Date())
                        let delegate = UIApplication.shared.delegate as? AppDelegate
                        delegate?.scheduleNotification(at: selectedDate!)
                    }
                }
            })
        }
        
        // Register the table view cell class and its reuse id
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        // This view controller itself will provide the delegate methods and row data for the table view.
        tableView.delegate = self
        tableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cameraButtonTapped(_ sender: Any) {
        self.performSegue(withIdentifier: Constants.toAR, sender: nil)
    }
    
}

extension HomeViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location: CLLocation = locations.last!
        
        //use location to determine state
        CLGeocoder().reverseGeocodeLocation(location) { (placemarks, error) -> Void in
            if let error = error {
                print(error)
            } else {
                let placemark = CLPlacemark(placemark: placemarks![0] as CLPlacemark)
                
                let stateAbbreviation = placemark.administrativeArea
                
                ServerService.retrivePlantData { (plantDict) in
                    
                    if let abbreviation = stateAbbreviation,
                        let state = self.stateDictionary[abbreviation],
                        let plantArray = plantDict[state] as? [[String : String]] {
                        
                        var array = [String]()
                        for dict in plantArray {
                            if let name = dict["Name"] {
                                array.append(name)
                            }
                        }
                        self.plantData = array
                        print(self.plantData)
                    }
                    
                    self.tableView.reloadData()
                }
                
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted:
            print("Location access was restricted.")
        case .denied:
            print("User denied access to location")
            
        case .notDetermined:
            print("Location status not determined")
        case .authorizedAlways: fallthrough
        case .authorizedWhenInUse:
            print("Location status is OK.")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error: \(error)")
    }
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.plantData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "cell") as UITableViewCell!
        
        cell.textLabel?.text = self.plantData[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Tapped \(self.plantData[indexPath.row])")
        ARViewController.plant = self.plantData[indexPath.row]
        self.performSegue(withIdentifier: Constants.toAR, sender: nil)
    }
    
}
