//
//  ViewController.swift
//  ImageTextButton
//
//  Created by moonCai on 2017/12/6.
//  Copyright © 2017年 moonCai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // 样式一: 图片在上 文字在下
        let btn1 = ImageTextButton(font: UIFont.systemFont(ofSize: 16), textColor: .black, spacing: 10, imageName: "test", imageSize: CGSize(width: 50, height: 50), title: "瓷月亮", aligment: .center)
        btn1.frame = CGRect(x: 130, y: 50, width: 60, height: 100)
        view.addSubview(btn1)
        
        // 样式二: 图片在左 文字在右(自定义文字与图片的间距)
        let btn2 = ImageTextButton(frame: CGRect(x: 100, y: 200, width: 120, height: 60))
        btn2.setImage(UIImage(named: "test"), for: .normal)
        btn2.setTitle("瓷月亮", for: .normal)
        btn2.setTitleColor(.black, for: .normal)
        btn2.spacing = 10
        view.addSubview(btn2)
        
        // 样式三: 图片在右 文字在左(自定义文字与图片的间距)
        let btn3 = ImageTextButton(frame: CGRect(x: 100, y: 320, width: 120, height: 60))
        btn3.setImage(UIImage(named: "test"), for: .normal)
        btn3.setTitle("瓷月亮", for: .normal)
        btn3.setTitleColor(.black, for: .normal)
        btn3.spacing = 10
        btn3.isReverse = true
        view.addSubview(btn3)
    }
    
}


