//
//  CYHomeTableViewController.swift
//  MoonBlog
//
//  Created by 蔡钰 on 2017/6/17.
//  Copyright © 2017年 蔡钰. All rights reserved.
//

import UIKit
import YYModel

class CYHomeTableViewController: CYVisitorTableViewController {
    
    fileprivate lazy var homeViewModel:CYHomeViewModel = CYHomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isLogin { //登录状态下
            loadData()
            
            //注册单元格
            tableView.register(CYHomeTableViewCell.self, forCellReuseIdentifier: Constant.HomeCell_ID)
            
            tableView.rowHeight = UITableViewAutomaticDimension
            tableView.estimatedRowHeight = 200
            //取消分割线
            tableView.separatorStyle = .none
            
        } else { //非登录状态下
            visitorView?.updateVisitorview(imageName: nil, describeStr: nil)
        }
    
    }
    
    //MARK ---- 加载网页数据
    func loadData() {
        
        homeViewModel.requestHomeData { (isSuccess) in
            if isSuccess {
                self.tableView.reloadData()
            }
        }
    }
}

// MARK: - Table view data source
extension CYHomeTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeViewModel.dataArr.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.HomeCell_ID, for: indexPath) as! CYHomeTableViewCell
        cell.dataVM = homeViewModel.dataArr[indexPath.row]
        //print(cell.dataVM!)
        //取消cell选中状态
        cell.selectionStyle = .none
        return cell
    }
    
}