//
//  HomeViewController.swift
//  IntelligentPlanting
//
//  Created by Howard Wang on 3/24/18.
//  Copyright © 2018 Howard Wang. All rights reserved.
//

import UIKit
import CoreLocation

class HomeViewController: UIViewController {
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ServerService.retrivePlantData { (plantDict) in
            
        }
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.distanceFilter = 50
        
        locationManager.requestLocation()
        
        
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
                let pm = CLPlacemark(placemark: placemarks![0] as CLPlacemark)
                
                let state = pm.administrativeArea
                print(state)
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
