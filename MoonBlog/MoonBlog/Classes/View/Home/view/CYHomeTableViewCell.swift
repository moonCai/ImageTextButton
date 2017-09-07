//
//  CYHomeTableViewCell.swift
//  MoonBlog
//
//  Created by 蔡钰 on 2017/7/4.
//  Copyright © 2017年 蔡钰. All rights reserved.
//

import UIKit
import SnapKit

//展示动态的自定义cell,包含原创微博. 转发微博和评论/转发/点赞
class CYHomeTableViewCell: UITableViewCell {
 
    //homeBar的顶部约束
    var topConstrant: Constraint?
    
    //数据模型
    var dataVM:CYHomeCellViewModel?{
        didSet {
            //原创微博
            originalView.orignalVM = self.dataVM
            //转发/评论/赞
            homeBarView.homeBarVM = self.dataVM
            //转发微博
            retweetView.statusVM = self.dataVM
            //去掉homeBarView的顶部约束
            topConstrant?.deactivate()
            
            if self.dataVM?.homeStatusModel?.retweeted_status == nil { //没有转发微博
                retweetView.isHidden = true
                //重建homeBarView的顶部约束
                homeBarView.snp.makeConstraints({ (make) in
                 topConstrant = make.top.equalTo(originalView.snp.bottom).constraint
                })
            } else {
                retweetView.isHidden = false
                homeBarView.snp.makeConstraints({ (make) in
                   topConstrant = make.top.equalTo(retweetView.snp.bottom).constraint
                })
            }
        }
    
    }
    
    //原创微博视图
    fileprivate lazy var originalView:CYHomeOriginalView = {
        let originalView = CYHomeOriginalView()
        return originalView
    }()
    
    //转发微博视图
    fileprivate lazy var retweetView:CYHomeRetweetView = {
        let retView = CYHomeRetweetView()
        return retView
    }()
        
    //转发/评论/赞
    fileprivate lazy var homeBarView:CYHomeBar = {
        let homeBar = CYHomeBar()
        return homeBar
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.backgroundColor = UIColor(white: 0.93, alpha: 1.0)
        //添加控件
        contentView.addSubview(originalView)
        contentView.addSubview(retweetView)
        contentView.addSubview(homeBarView)
        
        //布局
        originalView.snp.makeConstraints({ (make) in
            make.top.equalToSuperview().offset(8)
            make.leading.trailing.equalToSuperview()
        })
        
        retweetView.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(originalView.snp.bottom)
        }
        
        homeBarView.snp.makeConstraints { (make) in
           topConstrant = make.top.equalTo(retweetView.snp.bottom).constraint
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(35)
            make.bottom.equalToSuperview()
        }
   
    }



    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
