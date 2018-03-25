//
//  PlantTableViewCell.swift
//  IntelligentPlanting
//
//  Created by Howard Wang on 3/25/18.
//  Copyright © 2018 Howard Wang. All rights reserved.
//

import UIKit

class PlantTableViewCell: UITableViewCell {
    
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
