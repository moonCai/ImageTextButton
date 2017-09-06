//
//  CYAttentionModel.swift
//  MoonBlog
//
//  Created by 蔡钰 on 2017/7/2.
//  Copyright © 2017年 蔡钰. All rights reserved.
//

import UIKit
//关注用户的数据模型
class CYAttentionModel: NSObject {
    //用户id
    var id:Int64 = 0
    //用户昵称
    var screen_name:String?
    //头像地址
    var profile_image_url:String?
    //认证类型等级
    var verified_type:Int = 0
    //会员等级
    var mbrank:Int = 0

}
