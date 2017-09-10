//
//  CYHomePictureCollView.swift
//  MoonBlog
//
//  Created by 蔡钰 on 2017/7/9.
//  Copyright © 2017年 蔡钰. All rights reserved.
//

import UIKit

//每张配图的宽高
let itemWH:CGFloat = (Constant.ScreenW - 10 * 2 - 5 * 2) / 3

class CYHomePictureCollView: UICollectionView {
    
    //数据源
    var dataArr:[CYHomePictureModel]? {
        didSet {
            let count = dataArr!.count
//            countLabel.text = "\(count)"
            //计算配图size
            calculatePictureSize(count: count)
            //刷新数据源
            reloadData()
        }
    
    }

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: itemWH, height: itemWH)
        flowLayout.minimumInteritemSpacing = 5
        flowLayout.minimumLineSpacing = 5
        super.init(frame: frame, collectionViewLayout: flowLayout)
        setupUI()
    }
    
   // fileprivate lazy var countLabel:UILabel = UILabel(font: UIFont.systemFont(ofSize: 16), textColor: UIColor.yellow, text: "0")
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func calculatePictureSize(count:Int) {
   
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
        backgroundColor = UIColor(white: 0.93, alpha: 1.0)
        //添加控件
        dataSource = self
        //注册cell
        register(CYPictureCell.self, forCellWithReuseIdentifier: Constant.retPictureCell_ID)
//        addSubview(countLabel)
//        
//        countLabel.snp.makeConstraints { (make) in
//            make.center.equalToSuperview()
//        }
    }
}

extension CYHomePictureCollView:UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArr?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.retPictureCell_ID, for: indexPath) as! CYPictureCell
        cell.pictureInfo = dataArr?[indexPath.item]
        return cell
    }

}

class CYPictureCell: UICollectionViewCell {
    
    var pictureInfo:CYHomePictureModel? {
        didSet {
            if let url = pictureInfo?.thumbnail_pic {
                imgV.sd_setImage(with: URL(string:url), placeholderImage: UIImage(named:"timeline_image_placeholder"))
            }
        }
    }
    
    fileprivate lazy var imgV:UIImageView = {
        let imgV = UIImageView(image:UIImage(named: "timeline_image_placeholder"))
        imgV.contentMode = .scaleAspectFill
        //剪切超出的部分
        imgV.clipsToBounds = true
        return imgV
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imgV)
        imgV.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
