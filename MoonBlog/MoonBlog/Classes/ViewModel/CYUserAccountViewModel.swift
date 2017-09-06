//
//  CYUserAccountViewModel.swift
//  MoonBlog
//
//  Created by 蔡钰 on 2017/6/30.
//  Copyright © 2017年 蔡钰. All rights reserved.
//

import UIKit

class CYUserAccountViewModel: NSObject {
    
    //全局访问点
    static let sharedViewModel:CYUserAccountViewModel = CYUserAccountViewModel()
    
    //用户模型属性
    var userAccount:CYAccessTokenModel?
    
    private  override init() {
        super.init()
        userAccount = CYAccessTokenModel.loadAccessModel()
    }
    
    //封装获取accessToken的逻辑
    var accessToken:String?  {
        
        if userAccount?.expires_date?.compare(Date()) == ComparisonResult.orderedDescending { //说明没有过期
            return userAccount?.access_token
        }
        return nil
    }
    
    //封装是否登录的操作
    var isLogin:Bool {
        return accessToken != nil
    }
    
}

//MRAK ---- OAuthor登录相关的接口
extension CYUserAccountViewModel {
    func requestAccessToken(code:String,callBack:@escaping (Bool)->()) {
        CYHTTPSessionManager.sharedTools.requestAcessToken(code: code, finishBack: { (response, error) in
            if error != nil {
                print("请求异常:\(String(describing: error))")
                callBack(false)
                return
            }
            
            //服务器返回的数据格式是否为数组
            guard let dict = response as? [String:Any] else {
                print("服务端数据格式不对")
                callBack(false)
                return
            }
            
            //数组转化为模型
            let accessModel = CYAccessTokenModel(dict:dict)
            
            //根据access_token获取用户信息
            self.requestUserInfo(accessModel: accessModel,callBack: callBack)
    
        })
    }
    
    fileprivate func requestUserInfo(accessModel:CYAccessTokenModel,callBack:@escaping (Bool)->()) {
        //令牌
        let accessToken = accessModel.access_token
        //用户id
        let uid = accessModel.uid
        CYHTTPSessionManager.sharedTools.requestUserInfo(access_token: accessToken!, uid: uid) { (response, error) in
            //获取用户信息异常
            if error != nil {
                print("获取用户信息异常:\(String(describing: error))")
                callBack(false)
                return
            }
            guard let dict = response as? [String:Any] else {
                print("服务端数据格式不对")
                callBack(false)
                return
            }
            
            callBack(true)
            accessModel.name = dict["name"] as? String
            accessModel.avatar_large = dict["avatar_large"] as? String
            
            //保存用户对象
            accessModel.saveAccessModel()
            //给属性赋值
            self.userAccount = accessModel
        }
        
    }
}
