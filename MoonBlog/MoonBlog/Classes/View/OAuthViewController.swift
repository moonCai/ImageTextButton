//
//  OAuthViewController.swift
//  MoonBlog
//
//  Created by 蔡钰 on 2017/6/21.
//  Copyright © 2017年 蔡钰. All rights reserved.
//

import UIKit
import SVProgressHUD

let appKey = 2967344303
let appSecret = "f9941352f57d211bfd424aad720bbbd4"
let Redirect_Uri = "http://www.jianshu.com"

class OAuthViewController: UIViewController,UIWebViewDelegate {
    
    var webView:UIWebView = UIWebView()
  
    //自定义登录界面视图
    override func loadView() {
        view = webView
        webView.delegate = self
        if let url = URL(string: "https://api.weibo.com/oauth2/authorize?client_id=\(appKey)&redirect_uri=\(Redirect_Uri)") {
            
            webView.loadRequest(URLRequest(url: url))
    
        }
     
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       setupUI()
       
    }
    
    private func setupUI() {
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消", target: self, selector: #selector(backBtnAction))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "自动填充", target: self, selector: #selector(autoFillAction))
        navigationItem.title = "微博登录"
    
    }
    
    @objc private func backBtnAction() {
        
       dismiss(animated: true, completion: nil)
    
    }
    
    @objc private func autoFillAction() {
        webView.stringByEvaluatingJavaScript(from: "document.getElementById('userId').value = '18618354668';document.getElementById('passwd').value = 'qinranran250';")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


extension OAuthViewController {
    //即将加载
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
    
       //判断加载路径是否为nil
        guard let urlStr = request.url?.absoluteString else {
            return false
        }
     
        //判断加载路径不是否授权回调页地址的情况
        if !urlStr.hasPrefix(Redirect_Uri) {
            return true
        }
        
        //执行到此,说明urlStr是授权回调页地址.截取授权码
        if let query = request.url?.query, query.hasPrefix("code=") { //点击了授权
            let code = query.substring(from: "code=".endIndex)
            
            CYUserAccountViewModel.sharedViewModel.requestAccessToken(code: code, callBack: { (isSuccess) -> () in
                if isSuccess {
                print("数据请求成功")
                    self.dismiss(animated: true, completion: { 
                        //发送通知,切换根控制器
                        NotificationCenter.default.post(name: NSNotification.Name(Constant.switchRootVC), object: self)
                    })
                } else {
                  print("数据请求失败")
                }
            })
          
            return false
        } else { //点击了取消授权
            dismiss(animated: true, completion: nil)
        }
        
        return false
    }
    
    //MARK:webView开始加载
    func webViewDidStartLoad(_ webView: UIWebView) {
        //开启等待指示视图
        SVProgressHUD.show()
    }
    
    //完成加载
    func webViewDidFinishLoad(_ webView: UIWebView) {
        //移除等待指示视图
        SVProgressHUD.dismiss()
    }
    
    //加载失败
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        //移除等待指示视图
        SVProgressHUD.dismiss()
    }
}





