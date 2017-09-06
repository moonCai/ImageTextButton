//
//  CYHomeCellViewModel.swift
//  MoonBlog
//
//  Created by 蔡钰 on 2017/7/6.
//  Copyright © 2017年 蔡钰. All rights reserved.
//

import UIKit

class CYHomeCellViewModel: NSObject {
    
    //微博数据模型
    var homeStatusModel:CYHomeStatusModel? {
        didSet {
            let verfityType = homeStatusModel?.user?.verified_type
            dealWithVertifyType(verity: verfityType ?? 0)
            let mbrank = homeStatusModel?.user?.mbrank
            dealWithMbrank(mbrank: mbrank ?? 0)
            let repostCount = homeStatusModel?.reposts_count
            repostStr = repostCount! > 0 ? "\(repostCount!)" : "转发"
            let commendCount = homeStatusModel?.comments_count
            commendStr = commendCount! > 0 ? "\(commendCount!)" : "评论"
            let attitudeCount = homeStatusModel?.attitudes_count
            attitudeStr = attitudeCount! > 0 ? "\(attitudeCount!)" : "赞"
            //转发微博内容
            if let currentStatus = homeStatusModel {
                handleRetweetContent(status: currentStatus)
            }
        }
    }
    //认证类型等级图片
    var vertifyImg:UIImage?
    //会员等级图片
    var mbrankImg:UIImage?
    //转发数
    var repostStr:String?
    //评论
    var commendStr:String?
    //赞
    var attitudeStr:String?
    //转发微博内容
    var retweetContent:String?
    
    func dealWithCount(count:Int) {
        repostStr = count > 0 ? "\(count)" : "转发"
    }
    
    //处理转发微博显示的内容(在转发内容前拼接上"@原博的作者"
    fileprivate func handleRetweetContent(status:CYHomeStatusModel) {
        //判断转发微博是否存在
        if let retweetStatus = status.retweeted_status {
            //判断原博作者昵称和原博内容同时存在
            if let screenName = retweetStatus.user?.screen_name,let text = retweetStatus.text {
                retweetContent = "@\(screenName):\(text)"
            }
        
        }
    
    }
    
    
    //认证类型 -1:没有认证  1:认证用户 2,3,5:企业用户 220:达人
    fileprivate func dealWithVertifyType(verity:Int) {
        
        switch verity {
        case 1:
            vertifyImg = UIImage(named: "avatar_vip")!
        case 2,3,5:
            vertifyImg = UIImage(named: "avatar_enterprise_vip")!
        case 220:
            vertifyImg = UIImage(named: "avatar_grassroot")!
        default:
            vertifyImg = nil
        }
    
    }
    
    //会员等级
    fileprivate func dealWithMbrank(mbrank:Int) {
        if mbrank >= 1 && mbrank <= 6 {
            mbrankImg = UIImage(named: "common_icon_membership_level\(mbrank)")
        }
    
    }

}
