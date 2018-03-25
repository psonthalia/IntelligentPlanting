//
//  VisionAPITest.swift
//  IntelligentPlanting
//
//  Created by Paran Sonthalia on 3/25/18.
//  Copyright © 2018 Howard Wang. All rights reserved.
//

import Foundation
import Alamofire
import UIKit

class VisionAPITest: UIViewController {
@objc func callAPI(with imageBase64: String) {
    
    let jsonRequest = [
        "requests": [
            "image": [
                "content": imageBase64
            ],
            "features": [
                "type": "DOCUMENT_TEXT_DETECTION"
            ]
        ]
    ]
    
    
    Alamofire.request("https://vision.googleapis.com/v1/images:annotate?key=AIzaSyAIULZ2WTCIix_qfpsze4X4vzNLGVZgJlI", method: .post, parameters: jsonRequest, encoding: JSONEncoding.default)
        .responseJSON { response in
            if let status = response.response?.statusCode {
                switch(status){
                case 201:
                    print("example success")
                default:
                    print("")
                }
            }
            
            let responseLowecased = response.description.lowercased()
            if responseLowecased.description.range(of:"once") != nil {
                self.timesPerDay = 1
            } else if responseLowecased.description.range(of:"twice") != nil {
                self.timesPerDay = 2
            } else if responseLowecased.description.range(of:"thrice") != nil {
                self.timesPerDay = 3
            } else if responseLowecased.description.range(of:"one") != nil {
                self.timesPerDay = 1
            } else if responseLowecased.description.range(of:"two") != nil {
                self.timesPerDay = 2
            } else if responseLowecased.description.range(of:"three") != nil {
                self.timesPerDay = 3
            }
            else {
                self.timesPerDay = 0;
            }
            //                var arrayOfTimes = [Int]()
            //                if(UserDefaults.standard.array(forKey: "timesPerDay") != nil) {
            //                    arrayOfTimes = UserDefaults.standard.array(forKey: "timesPerDay") as! [Int]
            //                }
            //                arrayOfTimes.append(self.timesPerDay);
            //
            //                UserDefaults.standard.set(arrayOfTimes, forKey: "timesPerDay")
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "Datacheck") as! DataCheck
            controller.fromCamera = true
            controller.timePerDayOriginal = self.timesPerDay
            self.present(controller, animated: true, completion: nil)
    }
}
}
