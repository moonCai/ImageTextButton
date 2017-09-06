//
//  CYTabBarController.swift
//  MoonBlog
//
//  Created by 蔡钰 on 2017/6/17.
//  Copyright © 2017年 蔡钰. All rights reserved.
//

import UIKit

class CYTabBarController: UITabBarController,CYTabBarDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //添加子视图控制器
        addChildViewController(childController: CYHomeTableViewController(), imageStr: "tabbar_home", title: "首页")
        addChildViewController(childController: CYMessageTableViewController(), imageStr: "tabbar_message_center", title: "消息")
        addChildViewController(childController: CYDiscoverTableViewController(), imageStr: "tabbar_discover", title: "发现")
        addChildViewController(childController: CYMineTableViewController(), imageStr: "tabbar_profile", title: "我的")
        
        //自定义tabBar
        let tabBar = CYTabBar()
        //遵守代理
        tabBar.tabDelegate = self
        self.setValue(tabBar, forKey: "tabBar")
    
    }
    
    func addChildViewController(childController: UIViewController,imageStr:String,title:String) {
        
        childController.title = title
    
        //设置title选中时的渲染颜色
        childController.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.orange], for: .selected)
        childController.tabBarItem.image = UIImage(named: imageStr)
        //设置标签页选中item图片的渲染方式
        childController.tabBarItem.selectedImage = UIImage(named: imageStr + "_selected")?.withRenderingMode(.alwaysOriginal)
        let nav = UINavigationController(rootViewController: childController)
        addChildViewController(nav)
    }
    
    func didSelectComposeButtonModalVC(tabBar: CYTabBar) {
        print("加号按钮被点击了")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
