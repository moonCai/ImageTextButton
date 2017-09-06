//
//  UIBarButtonItem+Extension.swift
//  MoonBlog
//
//  Created by 蔡钰 on 2017/6/18.
//  Copyright © 2017年 蔡钰. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    
    convenience init(title:String,target:Any,selector:Selector) {
        self.init()
        let btn = UIButton()
        //按钮的点击事件
        btn.addTarget(target, action: selector, for: .touchUpInside)
        btn.setTitle(title, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn.setTitleColor(UIColor.darkGray, for: .normal)
        btn.setTitleColor(UIColor.orange, for: .highlighted)
        btn.sizeToFit()
        customView = btn
    }
    
    


}
