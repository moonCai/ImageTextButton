//
//  CYTabBar.swift
//  MoonBlog
//
//  Created by 蔡钰 on 2017/6/17.
//  Copyright © 2017年 蔡钰. All rights reserved.
//

import UIKit
import SnapKit

protocol CYTabBarDelegate:NSObjectProtocol {
    func didSelectComposeButtonModalVC(tabBar:CYTabBar)->()
    
}

class CYTabBar: UITabBar {
    
    lazy var composeButton:UIButton = {
        let btn = UIButton()
        //设置按钮的背景图片
        btn.setBackgroundImage(UIImage(named:"tabbar_compose_button"), for: .normal)
    btn.setBackgroundImage(UIImage(named:"tabbar_compose_button_highlighted"), for: .highlighted)
        
        //设置按钮不同状态下的图片
        btn.setImage(UIImage(named:"tabbar_compose_icon_add"), for: .normal)
      
       btn.setImage(UIImage(named:"tabbar_compose_icon_add_highlighted"), for: .highlighted)
        
        btn.sizeToFit()
        
        //btn的监听事件
        btn.addTarget(self, action: #selector(composeBtnAction), for: .touchUpInside)
        
        return btn
    }()
    
    
    //MARK:代理属性
    weak var tabDelegate:CYTabBarDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    func setupUI() {
        addSubview(composeButton)
        //设置加号按钮的坐标
        composeButton.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        
    }
    
   @objc private func composeBtnAction() {
        
        tabDelegate?.didSelectComposeButtonModalVC(tabBar: self)
    
    }
    
    //调整子控件布局
    override func layoutSubviews() {
        super.layoutSubviews()
        var index = 0
        
        for subview in subviews {
            
            if subview .isKind(of: NSClassFromString("UITabBarButton")!) {
                subview.frame.size.width = self.bounds.width / 5
                subview.frame.origin.x = CGFloat(index) * self.bounds.width / 5
                if index == 1 {
                    index += 1
                }
                
                index += 1
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
