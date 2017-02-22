//
//  UIColor-Extension.swift
//  TopFreeAppStore
//
//  Created by Javier Manzo on 2/20/17.
//  Copyright © 2017 Javier Manzo. All rights reserved.
//

import UIKit

extension UIColor {

    func inverse() -> UIColor{
        var a: CGFloat = 0.0; var r: CGFloat = 0.0; var g: CGFloat = 0.0; var b: CGFloat = 0.0;
        self.getRed(&r, green: &g, blue: &b, alpha: &a);
        return UIColor(red: -r, green: -g, blue: -b, alpha: a);
    }
    
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(hex:Int) {
        self.init(red:(hex >> 16) & 0xff, green:(hex >> 8) & 0xff, blue:hex & 0xff)
    }
    
}
