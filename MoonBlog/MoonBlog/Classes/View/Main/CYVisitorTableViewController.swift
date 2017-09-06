//
//  CYVisitorTableViewController.swift
//  MoonBlog
//
//  Created by 蔡钰 on 2017/6/18.
//  Copyright © 2017年 蔡钰. All rights reserved.
//

import UIKit
import SnapKit

class CYVisitorTableViewController: UITableViewController {
    
    //是否登录(根据归档的用户数据模型中access_token是否存在判断是否为登录状态
    var isLogin:Bool = CYUserAccountViewModel.sharedViewModel.isLogin 
    
    //访客视图
    var visitorView:CYVisitorView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func loadView() {
        if isLogin {            //登录状态下
            super.loadView()
            
        } else {                //未登录状态下
            visitorView = CYVisitorView()
            visitorView?.jumpBlock = {
                    //跳转到三方登录界面
                    let nav = UINavigationController(rootViewController: OAuthViewController())
                    self.navigationController?.present(nav, animated: true, completion: nil)
            }
    
            visitorView?.backgroundColor = UIColor(colorLiteralRed: 237.0/255.0, green: 237.0/255.0, blue: 237.0/255.0, alpha: 1.0)
            view = visitorView
            setupNavUI()
        }
    }
    
    func setupNavUI() {
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "注册", target: self, selector: #selector(registerBtnAction))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "登录", target: self, selector: #selector(registerBtnAction))
        
    }
    //MARK -- 导航栏登录/注册按钮的监听事件
    func registerBtnAction() {
        visitorView?.jumpBlock?()
    }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

   
