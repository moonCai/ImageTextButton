//
//  UILabel + Extension.swift
//  MoonBlog
//
//  Created by 蔡钰 on 2017/7/5.
//  Copyright © 2017年 蔡钰. All rights reserved.
//

import UIKit

extension UILabel {
    
    convenience init(font:UIFont, textColor:UIColor, text:String) {
        self.init()
        self.font = font
        self.textColor = textColor
        self.text = text
    }
}
