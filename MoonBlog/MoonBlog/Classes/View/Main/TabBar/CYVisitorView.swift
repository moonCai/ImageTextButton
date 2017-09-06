//
//  CYVisitorView.swift
//  MoonBlog
//
//  Created by 蔡钰 on 2017/6/18.
//  Copyright © 2017年 蔡钰. All rights reserved.
//

import UIKit

class CYVisitorView: UIView {
    //是否登录
    var isLogin:Bool = false
    
    //跳转到登录页面的闭包
    var jumpBlock:(()->())?
    
    //circleImageView
    private lazy var circleImgview = UIImageView(image: UIImage(named: "visitordiscover_feed_image_smallicon"))
    
    //maskImageView
    private lazy var maskImageview = UIImageView(image: UIImage(named: "visitordiscover_feed_mask_smallicon"))
    
    //homeImageView
    private lazy var homeImageview = UIImageView(image:UIImage(named: "visitordiscover_feed_image_house"))
    
    //describeLabel
    private lazy var describeLabel:UILabel = {
        let label = UILabel()
        label.text = "时光有序/而生活总是把好的一面给人看/另外的一面是要爱的"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.darkGray
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
        
    }()
    
    //registerBtn
    private lazy var registerBtn:UIButton = {
        let btn = UIButton()
        btn.addTarget(self, action: #selector(loginAction), for: .touchUpInside)
        btn.setTitle("注册", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        btn.setTitleColor(UIColor.darkGray, for: .normal)
        btn.setTitleColor(UIColor.orange, for: .highlighted)
 btn.setBackgroundImage(UIImage(named:"common_button_white_disable"), for: .normal)
        
//        image对象.resizableImage(withCapInsets: UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1), resizingMode: UIImageResizingMode.stretch)
        btn.layer.cornerRadius = 12
        btn.layer.masksToBounds = true
        return btn
    }()
    
    //loginBtn
    private lazy var loginBtn:UIButton = {
        let btn = UIButton()
        btn.addTarget(self, action: #selector(loginAction), for: .touchUpInside)
        btn.setTitle("登录", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        btn.setTitleColor(UIColor.darkGray, for: .normal)
        btn.setTitleColor(UIColor.orange, for: .highlighted)
        btn.setBackgroundImage(UIImage(named:"common_button_white_disable"), for: .normal)
        btn.layer.cornerRadius = 12
        btn.layer.masksToBounds = true
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK - 登录跳转
   @objc private func loginAction() {
        
        jumpBlock?()
    
    }
    
    func setupUI() {
        
        //MARK -- 添加子控件
        addSubview(circleImgview)
        addSubview(maskImageview)
        addSubview(homeImageview)
        addSubview(describeLabel)
        addSubview(registerBtn)
        addSubview(loginBtn)
        
        //取消按钮图片的高亮效果
        registerBtn.adjustsImageWhenHighlighted = false
        loginBtn.adjustsImageWhenHighlighted = false
        
        //MARK -- 设置子控件布局
        circleImgview.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        
        maskImageview.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(circleImgview)
        }
        
        homeImageview.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        
        describeLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(circleImgview.snp.bottom).offset(8)
            make.width.equalTo(237)
        }
        
        registerBtn.snp.makeConstraints { (make) in
            make.top.equalTo(describeLabel.snp.bottom).offset(8)
            make.leading.equalTo(describeLabel)
            make.size.equalTo(CGSize(width: 60, height: 35))
        }
        
        loginBtn.snp.makeConstraints { (make) in
            make.top.equalTo(describeLabel.snp.bottom).offset(8)
            make.trailing.equalTo(describeLabel)
            make.size.equalTo(CGSize(width: 60, height: 35))
        }
        
        
    }
    
    func circleImageviewAnimation() {
        
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        animation.toValue = Double.pi * 2
        animation.duration = 30
        animation.repeatCount = MAXFLOAT
        //在动画执行次数内不会被释放(动画失去焦点会被释放)
        animation.isRemovedOnCompletion = false
        circleImgview.layer.add(animation, forKey: nil)
        
    }
    
    //MARK -- 更新访客视图
    func updateVisitorview(imageName:String?,describeStr:String?) {
        
        if let imageN = imageName,let describeS = describeStr { //不是首页
            homeImageview.image = UIImage(named: imageN)
            describeLabel.text = describeS
            //隐藏circleImageview
            circleImgview.isHidden = true
        } else { //是首页
            //旋转动画
            circleImageviewAnimation()
        }
        
    }
    
}
