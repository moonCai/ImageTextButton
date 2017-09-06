//
//  CYHomeRetweetView.swift
//  MoonBlog
//
//  Created by 蔡钰 on 2017/7/8.
//  Copyright © 2017年 蔡钰. All rights reserved.
//

import UIKit
import SnapKit

class CYHomeRetweetView: UIView {
    
    //记录转发微博视图的底部约束
    fileprivate var retweetBottomContriant:Constraint?
    
    //绑定数据源
    var statusVM:CYHomeCellViewModel? {
        didSet {
            //转发微博内容
            retweetLabel.text = statusVM?.retweetContent
            //卸掉底部约束
            retweetBottomContriant?.deactivate()
            //转发微博配图
            if let picDict = statusVM?.homeStatusModel?.retweeted_status?.pic_urls, picDict.count > 0 { //有配图
                //取消隐藏
                pictureView.isHidden = false
                //重建约束
                self.snp.makeConstraints({ (make) in
                     retweetBottomContriant = make.bottom.equalTo(pictureView).offset(10).constraint
                })
        
                pictureView.dataArr = picDict
                
            } else { //无配图
                //隐藏配图
                pictureView.isHidden = true
                //重建约束
                self.snp.makeConstraints({ (make) in
                     retweetBottomContriant = make.bottom.equalTo(retweetLabel).offset(10).constraint
                })

            }
            
        }
    
    }
    
    fileprivate lazy var pictureView:CYHomePictureCollView = {
        let flowLayout = UICollectionViewFlowLayout()
        let picView = CYHomePictureCollView(frame: .zero, collectionViewLayout: flowLayout)
        return picView
        
    }()
    
     lazy var retweetLabel:UILabel = {
        let lab = UILabel()
        lab.text = "桃花仙桃花仙桃花仙桃花仙桃花仙桃花仙桃花仙桃花仙桃花仙桃花仙桃花仙桃花仙桃花仙桃花仙桃花仙桃花仙桃花仙桃花仙桃花仙桃花仙桃花仙桃花仙桃花仙桃花仙桃花仙桃花仙桃花仙桃花仙"
        lab.numberOfLines = 0
        lab.textColor = UIColor.lightGray
        lab.font = UIFont.systemFont(ofSize: 13)
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
        
        addSubview(retweetLabel)
        addSubview(pictureView)
        
        retweetLabel.snp.makeConstraints { (make) in
            make.top.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
        
        pictureView.snp.makeConstraints { (make) in
            make.top.equalTo(retweetLabel.snp.bottom).offset(6)
            make.leading.equalTo(retweetLabel)
            make.size.equalTo(CGSize(width: 100, height: 100))
        }
    
        self.snp.makeConstraints { (make) in
        retweetBottomContriant = make.bottom.equalTo(pictureView).offset(10).constraint
        }
    }

}
