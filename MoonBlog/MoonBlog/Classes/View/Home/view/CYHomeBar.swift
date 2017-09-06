//
//  CYHomeBar.swift
//  MoonBlog
//
//  Created by 蔡钰 on 2017/7/7.
//  Copyright © 2017年 蔡钰. All rights reserved.
//

import UIKit

class CYHomeBar: UIView {
    
    var retweetBtn:UIButton?
    
    var commentBtn:UIButton?
    
    var unlikeBtn:UIButton?
    
    var homeBarVM:CYHomeCellViewModel? {
        didSet {
            retweetBtn?.setTitle(homeBarVM?.repostStr, for: .normal)
            commentBtn?.setTitle(homeBarVM?.commendStr, for: .normal)
            unlikeBtn?.setTitle(homeBarVM?.attitudeStr, for: .normal)
        }
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        
        retweetBtn = addChildButton(title: " 转发", imageName:"timeline_icon_retweet" )
        commentBtn = addChildButton(title: " 评论", imageName:"timeline_icon_comment")
        unlikeBtn = addChildButton(title: " 赞", imageName:"timeline_icon_unlike")
        let firstLineImgV = addLineImage(imageName: "timeline_card_bottom_line")
        let secondLineImgV = addLineImage(imageName: "timeline_card_bottom_line")
        
        retweetBtn?.snp.makeConstraints { (make) in
            make.leading.bottom.top.equalToSuperview()
            make.width.equalTo(commentBtn!)
        }
        
        commentBtn?.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.leading.equalTo((retweetBtn?.snp.trailing)!)
            make.width.equalTo(unlikeBtn!)
        }
        
        unlikeBtn?.snp.makeConstraints { (make) in
            make.top.bottom.trailing.equalToSuperview()
            make.leading.equalTo((commentBtn?.snp.trailing)!)
        }
        
        firstLineImgV.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.leading.equalTo((retweetBtn?.snp.trailing)!)
        }
        
        secondLineImgV.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.leading.equalTo((commentBtn?.snp.trailing)!)
        }
        
        
    }
    
    fileprivate func addChildButton(title:String,imageName:String)->UIButton {
        let btn = UIButton()
        btn.setTitle(title, for: .normal)
        btn.setTitleColor(UIColor.darkGray, for: .normal)
        btn.setImage(UIImage(named:imageName), for: .normal)
        btn.setBackgroundImage(UIImage(named:"timeline_card_bottom_background"), for: .normal)
        btn.setBackgroundImage(UIImage(named:"timeline_card_bottom_background_highlighted"), for: .highlighted)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        addSubview(btn)
        return btn
    }
    
    fileprivate func addLineImage(imageName:String)->UIImageView {
        let lineImgV = UIImageView(image: UIImage(named: imageName))
        addSubview(lineImgV)
        return lineImgV
    }
    
}
