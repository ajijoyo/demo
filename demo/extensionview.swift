//
//  extensionview.swift
//  demo
//
//  Created by Dealjava on 4/29/16.
//  Copyright © 2016 originesia. All rights reserved.
//

import UIKit

extension UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    var getHeight : CGFloat {
        return self.frame.origin.y + self.frame.height
    }
    
    var getWidth : CGFloat {
        return self.frame.origin.x  + self.frame.width
    }

}
