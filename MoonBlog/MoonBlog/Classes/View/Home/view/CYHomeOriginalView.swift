//
//  CYHomeOriginalView.swift
//  MoonBlog
//
//  Created by 蔡钰 on 2017/7/4.
//  Copyright © 2017年 蔡钰. All rights reserved.
//

import UIKit

class CYHomeOriginalView: UIView {
    
    //数据模型
    var orignalVM:CYHomeCellViewModel?{
        didSet {
            //头像
            if let imgUrlStr = orignalVM?.homeStatusModel?.user?.profile_image_url   {
                headerImgV.sd_setImage(with: URL(string:imgUrlStr), placeholderImage: UIImage(named: "avatar_default_big"))
            }
            //昵称
            if let nameS = orignalVM?.homeStatusModel?.user?.screen_name {
                screenNameLab.text = nameS
            }
            //微博内容
            if let textStr = orignalVM?.homeStatusModel?.text {
                originalLab.text = textStr
            }
            //认证会员等级
            vertifyImgV.image = orignalVM?.vertifyImg
            //会员等级
            mbrankImgV.image = orignalVM?.mbrankImg
        }
    }
    
    //头像
    fileprivate lazy var headerImgV:UIImageView = {
        let headerImgV = UIImageView(image:UIImage(named: "avatar_default_big"))
        headerImgV.layer.cornerRadius = 22
        headerImgV.layer.masksToBounds = true
        return headerImgV
    }()
    
    //认证等级
    fileprivate lazy var vertifyImgV:UIImageView = {
        let headerImgV = UIImageView(image:UIImage(named: "avatar_vip"))
        return headerImgV
    }()
    
    //昵称
    fileprivate lazy var screenNameLab:UILabel = {
        let lab = UILabel(font: UIFont.systemFont(ofSize: 14), textColor: UIColor.darkGray, text: "瓷月亮")
        return lab
    }()
    
    //会员等级
    fileprivate lazy var mbrankImgV:UIImageView = {
        let mbrankImgV = UIImageView(image:UIImage(named: "common_icon_membership_level1"))
        return mbrankImgV
    }()
    
    //时间
    fileprivate lazy var timeLab:UILabel = {
        let timeLab = UILabel(font: UIFont.systemFont(ofSize: 12), textColor: UIColor.orange, text: "刚刚")
        return timeLab
    }()
    
    //来源
    fileprivate lazy var sourceLab:UILabel = {
        let sourceLab = UILabel(font: UIFont.systemFont(ofSize: 12), textColor: UIColor.darkGray, text: "来自微博")
        return sourceLab
    }()
    
    //原创微博内容
    fileprivate lazy var originalLab:UILabel = {
        let lab = UILabel(font: UIFont.systemFont(ofSize: 14), textColor: UIColor.darkGray, text: "阳光好的院子里,麻雀金黄细微的响声.生活常常把好的一面展示给人看,另外的一面是要爱的.阳光好的院子里,麻雀金黄细微的响声.生活常常把好的一面展示给人看,另外的一面是要爱的")
        lab.numberOfLines = 0
        lab.textAlignment = .left
        return lab
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = UIColor.white
        
        addSubview(headerImgV)
        addSubview(vertifyImgV)
        addSubview(screenNameLab)
        addSubview(mbrankImgV)
        addSubview(timeLab)
        addSubview(sourceLab)
        addSubview(originalLab)
        
        headerImgV.snp.makeConstraints { (make) in
            make.top.leading.equalToSuperview().offset(10)
            make.size.equalTo(CGSize(width: 45, height: 45))
        }
        
        vertifyImgV.snp.makeConstraints { (make) in
            make.centerX.equalTo(headerImgV.snp.trailing).offset(-6)
            make.centerY.equalTo(headerImgV.snp.bottom).offset(-6)
        }
        
        screenNameLab.snp.makeConstraints { (make) in
            make.top.equalTo(headerImgV)
            make.leading.equalTo(headerImgV.snp.trailing).offset(10)
        }
        
        mbrankImgV.snp.makeConstraints { (make) in
            make.top.equalTo(headerImgV)
            make.leading.equalTo(screenNameLab.snp.trailing).offset(10)
        }
        
        timeLab.snp.makeConstraints { (make) in
            make.top.equalTo(screenNameLab.snp.bottom).offset(6)
            make.leading.equalTo(screenNameLab)
        }
        
        sourceLab.snp.makeConstraints { (make) in
            make.top.equalTo(timeLab)
            make.leading.equalTo(timeLab.snp.trailing).offset(10)
        }
        
        originalLab.snp.makeConstraints { (make) in
            make.top.equalTo(headerImgV.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
        
        self.snp.makeConstraints { (make) in
            make.bottom.equalTo(originalLab.snp.bottom).offset(10)
        }
    }

}
