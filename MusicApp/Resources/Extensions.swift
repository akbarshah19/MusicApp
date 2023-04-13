//
//  Extensions.swift
//  MusicApp
//
//  Created by Akbarshah Jumanazarov on 3/23/23.
//

import UIKit

extension UIView {
    public var width: CGFloat {
        return self.frame.size.width
    }
    
    public var height: CGFloat {
        return self.frame.size.height
    }
    
    public var top: CGFloat {
        return self.frame.origin.y
    }
    
    public var bottom: CGFloat {
        return self.frame.size.height + self.frame.origin.y
    }
    
    public var left: CGFloat {
        return self.frame.origin.x
    }
    
    public var right: CGFloat {
        return self.frame.size.width + self.frame.origin.x
    }
}

extension UIColor {
    static var mainBgColor = UIColor(red: 82/255, green: 171/255, blue: 90/255, alpha: 1)
}

