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

class VisionAPI: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @objc var photo : Bool = false
    
    override func viewDidAppear(_ animated: Bool) {
        let label = UILabel(frame: CGRect(x: 0, y: 140, width: self.view.frame.width, height: 21))
        label.textAlignment = .center
        label.textColor = UIColor.red
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) && photo == false {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera;
            imagePicker.allowsEditing = false
            label.text = "Please take a photo of the leaf in question"
            imagePicker.cameraOverlayView = label
            self.present(imagePicker, animated: true, completion: nil)
        }
        else if photo == false {
            let picker = UIImagePickerController()
            picker.delegate = self
            self.present(picker, animated: true, completion: nil)
        }
        
        photo = true
    }
    override func viewDidLoad() {
//        var image = #imageLiteral(resourceName: "demo-image.jpg")
//        let binaryImageData = base64EncodeImage(image as! UIImage)
//        callAPI(with: binaryImageData)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
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
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage]
        self.dismiss(animated: true, completion: nil)
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
                    
                    let red = cool["red"] as! Int
                    let green = cool["green"] as! Int
                    let blue = cool["blue"] as! Int
                    
                    var alert : UIAlertController
                    
                    if(green > 200 && red < 150 && blue < 150) {
                        //healthy
                        alert = UIAlertController(title: "Your plant is healthy", message: "Keep doing what you are doing! Your plant is healthy!", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    } else if(red > 180 && green > 180) {
                        //dying
                        alert = UIAlertController(title: "Increase water content", message: "Your plant is dying. We have increased the required water content for your plant", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    } else {
                        alert = UIAlertController(title: "Your plant is healthy", message: "Keep doing what you are doing! Your plant is healthy!", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                        switch action.style{
                        case .default:
                            self.dismiss(animated: true, completion: nil)
                        case .cancel:
                            self.dismiss(animated: true, completion: nil)
                        case .destructive:
                            self.dismiss(animated: true, completion: nil)
                        }
                    }))

                }
        }
    }
}

