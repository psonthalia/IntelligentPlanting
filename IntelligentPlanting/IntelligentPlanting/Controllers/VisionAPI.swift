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

class VisionAPI: UIViewController, UIImagePickerControllerDelegate {
    override func viewDidLoad() {
        var image = #imageLiteral(resourceName: "demo-image.jpg")
        let binaryImageData = base64EncodeImage(image as! UIImage)
        callAPI(with: binaryImageData)
    }
    @objc func resizeImage(_ imageSize: CGSize, image: UIImage) -> Data {
        UIGraphicsBeginImageContext(imageSize)
        image.draw(in: CGRect(x: 0, y: 0, width: imageSize.width, height: imageSize.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        let resizedImage = UIImagePNGRepresentation(newImage!)
        UIGraphicsEndImageContext()
        return resizedImage!
    }
    @objc func base64EncodeImage(_ image: UIImage) -> String {
        var imagedata = UIImagePNGRepresentation(image)
        if ((imagedata?.count)! > 2097152) {
            let oldSize: CGSize = image.size
            let newSize: CGSize = CGSize(width: 800, height: oldSize.height / oldSize.width * 800)
            imagedata = resizeImage(newSize, image: image)
        }
        return imagedata!.base64EncodedString(options: .endLineWithCarriageReturn)
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
                print(responseLowecased)
        }
    }
}

