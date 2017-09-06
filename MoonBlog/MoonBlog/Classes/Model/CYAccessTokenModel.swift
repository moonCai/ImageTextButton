//
//  CYAccessTokenModel.swift
//  MoonBlog
//
//  Created by 蔡钰 on 2017/6/25.
//  Copyright © 2017年 蔡钰. All rights reserved.
//

import UIKit

//归档/解档路径
 let filePath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! as NSString).appendingPathComponent("accessModel")
class CYAccessTokenModel: NSObject,NSCoding {
    //用户授权的唯一票据
    var access_token:String?
    //access_token的生命周期,单位是秒数
    var expires_in:Int = 0 {
        didSet{
        expires_date = Date().addingTimeInterval(TimeInterval(expires_in)) //当前时间+有效时长
        }
    }
    //access_token的有效期
    var expires_date:Date?
    //uid
    var uid:Int64 = 0
    //用户名
    var name:String?
    //用户图片
    var avatar_large:String?
    
    init(dict:[String:Any]) {
        super.init()
        setValuesForKeys(dict)
       // super.init()
    }
    //空实现,过滤未定义字段
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
    //归档
    func encode(with aCoder: NSCoder) {
        aCoder.encode(access_token, forKey: "access_token")
        aCoder.encode(expires_date, forKey: "expires_date")
        aCoder.encode(uid, forKey: "uid")
        aCoder.encode(name, forKey: "name")
        aCoder.encode(avatar_large, forKey: "avatar_large")
    }
    
    //解档
    required init?(coder aDecoder: NSCoder) {
        access_token = aDecoder.decodeObject(forKey: "access_token") as? String
        expires_date = aDecoder.decodeObject(forKey: "expires_date") as? Date
        uid = aDecoder.decodeInt64(forKey: "uid")
        name = aDecoder.decodeObject(forKey: "name") as? String
        avatar_large =
            aDecoder.decodeObject(forKey: "avatar_large") as? String
    }
    
    //保存用户对象模型
    func saveAccessModel() {
       
    //归档用户对象
        NSKeyedArchiver.archiveRootObject(self, toFile: filePath)
    }
    
    //获取本地用户对象模型
    class func loadAccessModel()->CYAccessTokenModel? {
        let  obj = NSKeyedUnarchiver.unarchiveObject(withFile: filePath)
        return obj as? CYAccessTokenModel //第一次登录时,userAccount为nil.在viewModel中创建时如果强行解包会崩溃.
    }
}
