//
//  UICollectionViewCell-Extension.swift
//  TopFreeAppStore
//
//  Created by Javier Manzo on 2/19/17.
//  Copyright © 2017 Javier Manzo. All rights reserved.
//

import UIKit

extension UICollectionViewCell {
    
    static var id: String {
        return String(describing: self.self)
    }
    
    static var cellNib: UINib {
        return UINib(nibName: id, bundle: nil)
    }
    
}
