//
//  TFAListiPadCollectionViewCell.swift
//  TopFreeAppStore
//
//  Created by Javier Manzo on 2/19/17.
//  Copyright © 2017 Javier Manzo. All rights reserved.
//

import UIKit

class TFAListiPadCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.logoImageView.layer.cornerRadius = 10
        self.logoImageView.clipsToBounds = true
        
        self.containerView.layer.cornerRadius = 10
        self.containerView.clipsToBounds = true
        self.containerView.layer.borderColor = UIColor.lightGray.cgColor
        self.containerView.layer.borderWidth = 1.0
    }

}
