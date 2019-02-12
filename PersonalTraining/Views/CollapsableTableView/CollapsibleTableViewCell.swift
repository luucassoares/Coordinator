//
//  CollapsibleTableViewCell.swift
//  PersonalTraining
//
//  Created by Lucas Ornelas Dias Soares on 12/02/19.
//  Copyright © 2019 Lucas Ornelas Dias Soares. All rights reserved.
//

import UIKit

class CollapsibleTableViewCell: UITableViewCell {

 
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    func setup(with product: String, and mDescription: String) {
        titleLabel.text = product
        contentLabel.text = mDescription
    }
    
}
