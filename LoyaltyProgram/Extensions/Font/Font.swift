//
//  Font.swift
//  Graffity
//
//  Created by Karen Khachatryan on 25.11.24.
//

import UIKit

extension UIFont {
    
    static func regular(size: CFloat) -> UIFont? {
        return UIFont(name: "RobotoMono-Regular", size: CGFloat(size))
    }
    
    static func medium(size: CFloat) -> UIFont? {
        return UIFont(name: "RobotoMono-Medium", size: CGFloat(size))
    }
    
    static func semibold(size: CFloat) -> UIFont? {
        return UIFont(name: "Roboto-BoldCondensed", size: CGFloat(size))
    }
    
    static func bold(size: CFloat) -> UIFont? {
        return UIFont(name: "RobotoMono-Bold", size: CGFloat(size))
    }
    
    static func black(size: CFloat) -> UIFont? {
        return UIFont(name: "Roboto-Black", size: CGFloat(size))
    }
    
    static func italic(size: CFloat) -> UIFont? {
        return UIFont(name: "RobotoMono-Italic", size: CGFloat(size))
    }
}
