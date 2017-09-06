//
//  CYHomePictureCollView.swift
//  MoonBlog
//
//  Created by 蔡钰 on 2017/7/9.
//  Copyright © 2017年 蔡钰. All rights reserved.
//

import UIKit

class CYHomePictureCollView: UICollectionView {
    
    //数据源
    var dataArr:[CYHomePictureModel]? {
        didSet {
            let count = dataArr!.count
            countLabel.text = "\(count)"
            //计算配图size
            calculatePictureSize(count: count)
        }
    
    }

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: .zero, collectionViewLayout: layout)
        setupUI()
    }
    
    fileprivate lazy var countLabel:UILabel = UILabel(font: UIFont.systemFont(ofSize: 16), textColor: UIColor.yellow, text: "0")
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func calculatePictureSize(count:Int) {
        //每张配图的宽高
        let itemWH:CGFloat = (Constant.ScreenW - 10 * 2 - 5 * 2) / 3
        //列数
        let cols = count > 3 ? 3 : count
        //行数
        let rows = (count - 1) / 3 + 1
        //配图宽度
        let picWidth = CGFloat(cols) * itemWH + CGFloat((cols - 1) * 5)
        
        //配图高度
        let picHeight = CGFloat(rows) * itemWH + CGFloat((rows - 1) * 5)
        
        //更新约束
        self.snp.updateConstraints { (make) in
            make.size.equalTo(CGSize(width: picWidth, height: picHeight))
        }
    
    }
    
    private func setupUI() {
        backgroundColor = UIColor.red
        
        addSubview(countLabel)
        
        countLabel.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
    }

}
