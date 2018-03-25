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
                    "type": "IMAGE_PROPERTIES"
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
//                let json = try JSONSerialization.jsonObject(with: response) as? [String: Any]
                
//                let responseLowecased = response.description.lowercased()
//                resp
//                do {
//                    if let data = response.description.data(using: String.Encoding.utf8),
//                        let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
//                        let blogs = json["responses"] as? [[String: Any]] {
//                        for blog in blogs {
//                            print(blog)
////                            if let name = blog["name"] as? String {
////                                names.append(name)
////                            }
//                        }
//                    }
//                } catch {
//                    print("Error deserializing JSON: \(error)")
//                }
                
                if let result = response.result.value {
                    let JSON = result as! Dictionary<String, Any>
                    let responses:Array = JSON["responses"] as! Array<Any>
                    let imageProps:Dictionary = responses[0] as! Dictionary<String, Any>
                    let next = imageProps["imagePropertiesAnnotation"] as! Dictionary<String, Any>
                    let asdf = next["dominantColors"] as! Dictionary<String, Any>
                    let colors = asdf["colors"] as! Array<Any>
                    let firstColor = colors[0] as! Dictionary<String, Any>
                    let cool = firstColor["color"] as! Dictionary<String, Any>
                    print(cool["blue"]!)
                    print(cool["red"]!)
                    print(cool["green"]!)

//                    let imageProps = responses["imagePropertiesAnnotation"] as! NSDictionary
//                    let domColors = imageProps["dominantColors"] as! NSDictionary
//                    let colors = domColors["colors"] as! NSArray
//                    print(colors[0])
                }
//                print(responseLowecased)
        }
    }
}

