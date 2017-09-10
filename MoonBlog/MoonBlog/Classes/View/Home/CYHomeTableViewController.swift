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
    
    //等待视图(上拉加载)
    fileprivate lazy var indicatorView:UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        view.color = UIColor.red
        return view
    }()
    
    //下拉刷新
    fileprivate lazy var pullDownView:UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(pullDownAction), for: .valueChanged)
        return refreshControl
    }()
    
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
            indicatorView.bounds.size.height = 60
            //设置底部视图
            tableView.tableFooterView = indicatorView
            indicatorView.startAnimating()
            //设置下拉刷新视图
            self.refreshControl = pullDownView
            
        } else { //非登录状态下
            visitorView?.updateVisitorview(imageName: nil, describeStr: nil)
        }
    
    }
    
    //MARK ---- 下拉加载
  @objc private  func pullDownAction() {
        loadData()
    }
    
    //MARK ---- 加载网页数据
    func loadData() {
        
        homeViewModel.requestHomeData(isPullUp: indicatorView.isAnimating) { (isSuccess) in
            self.stopRefresh()
            if isSuccess {
               
                self.tableView.reloadData()
            }
        }
    }
    
    func stopRefresh() {
        //停止等待视图
        self.indicatorView.stopAnimating()
        //停止下拉刷新
        self.refreshControl?.endRefreshing()
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
    
    //监听cell的显示
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    
        if indexPath.row == homeViewModel.dataArr.count - 1,!indicatorView.isAnimating {
            indicatorView.startAnimating()
            loadData()
        }
    }
    
}
