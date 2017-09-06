//
//  CYHomeViewModel.swift
//  MoonBlog
//
//  Created by 蔡钰 on 2017/7/3.
//  Copyright © 2017年 蔡钰. All rights reserved.
//

import UIKit

class CYHomeViewModel: NSObject {
    
    //数据源
    lazy var dataArr:[CYHomeCellViewModel] = [CYHomeCellViewModel]()

//MARK ---- 首页相关接口
    func requestHomeData(callBack:@escaping (Bool)->()) {
        CYHTTPSessionManager.sharedTools.requestHomeData(accessToken: (CYUserAccountViewModel.sharedViewModel.userAccount?.access_token)!) { (response, error) in
            if error != nil {
                print("网络异常,\(String(describing: error))")
                callBack(false)
                return
            }
            
            //判断数据是否是标准JSON
            guard let dict = response as? [String:Any] else {
                print("数据格式不对")
                callBack(false)
                return
            }
            
            guard let  statusArr = dict["statuses"] as? [[String:Any]] else {
                print("返回数据格式异常")
                callBack(false)
                return
            }
            
            //将字典数组转化为模型数组
            let modelArr = NSArray.yy_modelArray(with: CYHomeStatusModel.self, json: statusArr) as! [CYHomeStatusModel]
            
            var tmpArr = [CYHomeCellViewModel]()
            for statusModel in modelArr {
                let cellVM = CYHomeCellViewModel()
                cellVM.homeStatusModel = statusModel
                tmpArr.append(cellVM)
            }
            
            self.dataArr = tmpArr
          //  print(tmpArr)
            callBack(true)
    
        }

    }
}
