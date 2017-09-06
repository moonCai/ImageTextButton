//
//  CYWelcomeVC.swift
//  MoonBlog
//
//  Created by 蔡钰 on 2017/7/2.
//  Copyright © 2017年 蔡钰. All rights reserved.
//

import UIKit
import SDWebImage

class CYWelcomeVC: UIViewController {
    //背景view
    fileprivate lazy var imgV:UIImageView = {
        let imgV = UIImageView(image: UIImage(named: "ad_background"))
        return imgV
    }()
    
    //图像imgV
    fileprivate lazy var avatarImgV:UIImageView = {
        let imgV = UIImageView(image: UIImage(named: "avatar_default_big"))
        if let urlStr = CYUserAccountViewModel.sharedViewModel.userAccount?.avatar_large {
            imgV.sd_setImage(with: URL(string:urlStr), placeholderImage: UIImage(named: "avatar_default_big"))
        }
        imgV.layer.cornerRadius = 45
        imgV.layer.masksToBounds = true
        return imgV
    }()
    
    //欢迎文字label
    fileprivate lazy var welcomeLab:UILabel = {
        let lab = UILabel()
        lab.text = "欢迎回来"
        if let name = CYUserAccountViewModel.sharedViewModel.userAccount?.name {
            lab.text = "欢迎回来,\(name)"
        }
        lab.font = UIFont.systemFont(ofSize: 14)
        lab.textColor = UIColor.darkGray
        return lab
    }()
    
    override func loadView() {
        view = imgV
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
    }
    
    private func setupUI() {
        
        view.addSubview(avatarImgV)
        view.addSubview(welcomeLab)
        
        avatarImgV.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(200)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 90, height: 90))
        }
        
        welcomeLab.snp.makeConstraints { (make) in
            make.top.equalTo(avatarImgV.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        
    }
    //页面已经显示
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startWelcomeAnimation()
    }
    
    fileprivate func startWelcomeAnimation() {
        welcomeLab.alpha = 0
        
        avatarImgV.snp.updateConstraints { (make) in
            make.top.equalToSuperview().offset(100)
        }
        
        //弹簧动画
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 10, options: [], animations: {
            self.view.layoutIfNeeded()
        }) { (_) in
            UIView.animate(withDuration: 1.0, animations: { 
                 self.welcomeLab.alpha = 1.0
            }, completion: { (_) in
                //发送通知切换根控制器
                NotificationCenter.default.post(name: NSNotification.Name(Constant.switchRootVC), object: nil)
                
            })
                    }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
