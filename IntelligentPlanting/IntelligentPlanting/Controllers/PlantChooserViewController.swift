//
//  PlantChooserViewController.swift
//  IntelligentPlanting
//
//  Created by Howard Wang on 3/24/18.
//  Copyright © 2018 Howard Wang. All rights reserved.
//

import UIKit

class PlantChooserViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cameraButtonTapped(_ sender: Any) {
        self.performSegue(withIdentifier: Constants.toAR, sender: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
