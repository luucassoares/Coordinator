//
//  LottieCell.swift
//  PersonalTraining
//
//  Created by Lucas Ornelas Dias Soares on 11/02/19.
//  Copyright © 2019 Lucas Ornelas Dias Soares. All rights reserved.
//

import UIKit

class LottieCell: UICollectionViewCell {

    @IBOutlet weak var imageIcon: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setup(withName: String, withIcon: String) {
        nameLabel.text = withName
        imageIcon.image = UIImage(named: withIcon)
    }
}
