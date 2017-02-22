//
//  TFAAppDetailsViewModel.swift
//  TopFreeAppStore
//
//  Created by Javier Manzo on 2/20/17.
//  Copyright © 2017 Javier Manzo. All rights reserved.
//

import UIKit

class TFAAppDetailsViewModel {
    
    func setStyleAndFillView(controller: TFAppDetailsViewController){
        controller.logoImageView.layer.cornerRadius = 20
        controller.logoImageView.clipsToBounds = true
        controller.logoImageView.kf.setImage(with: URL(string: controller.app.imageUrl), placeholder: UIImage(named:"image-holder"), options: [.transition(.fade(1))], progressBlock: nil, completionHandler: { (image, error, cache, url) in
            
            UIView.animate(withDuration: 0.3, delay: 0, options: [], animations: {
                
                controller.headerView.backgroundColor = controller.logoImageView.image?.getMainColor()
                controller.titleLabel.textColor = controller.logoImageView.image?.getMainColor().inverse()
                controller.artistLabel.textColor = controller.logoImageView.image?.getMainColor().inverse()
                
            }, completion: nil)
        })
        
        controller.titleLabel.text = controller.app.name
        controller.artistLabel.text = controller.app.rights
        controller.descriptionTextView.text = controller.app.summary
    }
}
