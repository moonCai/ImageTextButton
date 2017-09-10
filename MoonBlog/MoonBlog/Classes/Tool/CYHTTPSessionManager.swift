//
//  CYHTTPSessionManager.swift
//  RequestPackage
//
//  Created by 蔡钰 on 2017/6/20.
//  Copyright © 2017年 蔡钰. All rights reserved.
//

import UIKit
import AFNetworking

enum RequestType {
    case get
    case post
}

class CYHTTPSessionManager: AFHTTPSessionManager {
    
    static let sharedTools:CYHTTPSessionManager = {
        let sharedTools = CYHTTPSessionManager()
        //指定可接收的数据类型
        sharedTools.responseSerializer.acceptableContentTypes?.insert("text/html")
        sharedTools.responseSerializer.acceptableContentTypes?.insert("text/plain")
        return sharedTools
    }()
    
    func requestData(type:RequestType,urlStr:String,params:Any?,finishCallBack:@escaping (Any?,Error?)->Void) {
        
        if type == .get {

            get(urlStr, parameters: params, progress: nil, success: { (_, response) in
                
                finishCallBack(response, nil)
                
            }, failure: { (_, error) in
                
             print(error)
                
            })
        } else {
            
            post(urlStr, parameters: params, progress: nil, success: { (_, response) in
                
                finishCallBack(response, nil)
                
            }, failure: { (_, error) in
                finishCallBack(nil, error)
            })
        }
        
    }

}

//MARK ---- 获取首页相关数据
extension CYHTTPSessionManager {
    
    func requestHomeData(isPullUp:Bool,maxID:Int64 = 0,accessToken:String,callBack:@escaping (Any?,Error?)->Void) {
        let urlStr = "https://api.weibo.com/2/statuses/home_timeline.json"
        let params = [
            "access_token":accessToken,
            "max_id":maxID
        ] as [String : Any]
        
        requestData(type: .get, urlStr: urlStr, params: params, finishCallBack: callBack)
    }
    


}

//MARK ---- OAuth登录相关接口
extension CYHTTPSessionManager {
    
    //根据code,获取accessToken
    func requestAcessToken(code:String,finishBack:@escaping (Any?,Error?)->()){
        
        //请求地址
        let urlStr = "https://api.weibo.com/oauth2/access_token"
        //请求参数
        let params:[String:Any] = [
            "client_id":appKey,
            "client_secret":appSecret,
            "grant_type":"authorization_code",
            "code":code,
            "redirect_uri":Redirect_Uri
        ]
        requestData(type: .post, urlStr: urlStr, params: params, finishCallBack: finishBack)
    }
    
    //根据获取的accessToken获取用户信息
    func requestUserInfo(access_token:String,uid:Int64,finishBack:@escaping (Any?,Error?)->()){
        
        let urlStr = "https://api.weibo.com/2/users/show.json"
     //    print(urlStr + "?access_token=\(access_token)")
        let params:[String:Any] = [
        "access_token":access_token,
        "uid":uid
        ]
        requestData(type: .get, urlStr: urlStr, params: params, finishCallBack: finishBack)
    
    }

}
