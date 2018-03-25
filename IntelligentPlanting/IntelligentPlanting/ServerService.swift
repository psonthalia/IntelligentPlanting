//
//  ServerService.swift
//  IntelligentPlanting
//
//  Created by Howard Wang on 3/24/18.
//  Copyright © 2018 Howard Wang. All rights reserved.
//

import FirebaseDatabase

struct ServerService {
    
    static func retrivePlantData(completion: @escaping ([String: Any]) -> Void) {
        let ref = Database.database().reference().child(Constants.plants)
        
        ref.observeSingleEvent(of: .value) { (snapshot) in
            guard let plantDict = snapshot.value as? [String: Any] else {
                return
            }
            completion(plantDict)
        }
        
        
    }
}
