//
//  UIView+Extension.swift
//  MoonBlog
//
//  Created by 蔡钰 on 2017/6/18.
//  Copyright © 2017年 蔡钰. All rights reserved.
//

import UIKit

extension UIView {
    
    //x坐标
    var x:CGFloat {
        get {
            return frame.origin.x
        } set {
            frame.origin.x = newValue
        }
    }
    
    //y坐标
    var y:CGFloat {
        get {
            return frame.origin.y
        } set {
            frame.origin.y = newValue
        }
    }
    
    //width
    var width:CGFloat {
        get {
            return frame.size.width
        } set {
            frame.size.width = newValue
        }
    }
    
    //height
    var height:CGFloat {
        get {
            return frame.size.height
        } set {
            frame.size.height = newValue
        }
    }
    
    //size
    var size:CGSize {
        get {
            return frame.size
        } set {
            frame.size = newValue
        }
    }
    
    //center.x
    var centerX:CGFloat {
        get {
            return center.x
        } set {
            center.x = newValue
        }
    }
    
    //center.y
    var centerY:CGFloat {
        get {
            return center.y
        } set {
            center.y = newValue
        }
    }
    
}
