//
//  CYHomeStatusModel.swift
//  MoonBlog
//
//  Created by 蔡钰 on 2017/7/2.
//  Copyright © 2017年 蔡钰. All rights reserved.
//

import UIKit

//首页数据模型类
class CYHomeStatusModel: NSObject {
    //发微博时间
    var created_at:String?
    //微博id
    var id:Int64 = 0
    //微博内容
    var text:String?
    //微博来源
    var source:String?
    //转发数
    var reposts_count:Int = 0
    //评论数
    var comments_count:Int = 0
    //赞数
    var attitudes_count:Int = 0
    //关注用户模型
    var user:CYAttentionModel?
    //转发微博
    var retweeted_status:CYHomeStatusModel?
    //配图
    var pic_urls:[CYHomePictureModel]?
    
    //指定容器属性
    class func modelContainerPropertyGenericClass()->[String:Any] {
        return [
        "pic_urls" : CYHomePictureModel.self
        ]
    }


}
