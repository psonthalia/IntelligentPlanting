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
    override func viewDidLoad() {
        let binaryImageData = base64EncodeImage(image as! UIImage)
        callAPI(with: binaryImageData)
    }
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
        
        
        Alamofire.request("https://vision.googleapis.com/v1/images:annotate?key=AIzaSyB2ChYrBpVPQiqv7R4buQDm1jWXZFdkVEc", method: .post, parameters: jsonRequest, encoding: JSONEncoding.default)
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
                
        }
    }
}
