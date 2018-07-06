//
//  SUPHomeViewController.swift
//  SwiftProject
//
//  Created by NShunJian on 2018/7/2.
//  Copyright © 2018年 superMan. All rights reserved.
//

import UIKit
//  重用标记
private let HomeTableViewCellIdentifier = "HomeTableViewCellIdentifier"

class SUPHomeViewController: SUPVisitorViewControlle {

    //  微博数据源
    var statusList: [SUPStatus]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if isLogin {
            //  设置tableview相关操作
            setupTableView()
            //  登陆成功
            loadData()
        } else {
            visitorView?.updateVisitorViewInfo(message: nil, imageName: nil)
            
        }
    }
    
    //  设置tableView相关操作
    private func setupTableView() {
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: HomeTableViewCellIdentifier)
        
    }
    
    
    //  加载微博数据
    private func loadData() {
        
        SUPNetworkTools.sharedTools.requestStatuses(accessToken: SUPUserAccountViewModel.sharedUserAccount.accessToken!) { (response, error) -> () in
            if error != nil {
                print("网络请求异常,\(String(describing: error))")
                return
            }
            
            //  代码执行到此,表示网络请求成功
            guard let dic = response as? [String: AnyObject] else {
                print("字典格式不正确")
                return
            }
            //  字典格式正确
            guard let dicArray = dic["statuses"] as? [[String: AnyObject]] else {
                print("字典格式不正确")
                return
            }
            var tempArray = [SUPStatus]()
            
            for value in dicArray {
                
                //  字典转模型
                let status = SUPStatus(dic: value)
                
                tempArray.append(status)
                
            }
            SUPLog(response)
            //  设置数据源
            self.statusList = tempArray
            //  刷新数据
            self.tableView.reloadData()
            
            
        }
        
    }
    
    
}

//  MARK: - UITableViewDataSource 数据源代理
extension SUPHomeViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statusList?.count ?? 0
    }
    

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCellIdentifier, for: indexPath as IndexPath)
        
                cell.textLabel?.text = statusList![indexPath.row].user?.screen_name
        
                return cell
            }

    }
    



