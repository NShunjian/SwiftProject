//
//  SUPStatusListViewModel.swift
//  SwiftProject
//
//  Created by NShunJian on 2018/7/6.
//  Copyright © 2018年 superMan. All rights reserved.
//

import UIKit
//  获取微博数据的ViewModel , 对应的视图是首页的TableView
class SUPStatusListViewModel: NSObject {
    //  微博数据源
    lazy var statusList: [SUPStatusViewModel] = [SUPStatusViewModel]()
    
    //  加载微博数据
    func loadData(isPullup: Bool, callBack: @escaping (_ isSuccess: Bool, _ message: String)->()) {
        
        //  上拉加载所需要的参数
        var maxId: Int64 = 0
        //  下拉刷新所需要的参数
        var sinceId: Int64 = 0
        
        if isPullup {
            //  上拉加载获取数据源里面最后一条微博数据的id
            maxId = statusList.last?.status?.id ?? 0
            SUPLog(maxId)
            if maxId > 0 {   
                //  避免重复数据
                maxId -= 1
               SUPLog(maxId)
            }
        } else {
            //  下拉刷新获取数据源里面的第一天微博的id
            sinceId = statusList.first?.status?.id ?? 0
            SUPLog(sinceId)
        }
        
        //  默认显示的tip文字
        var result = "没有加载到最新的微博数据"
        
        SUPStatusDAL.loadData(maxId: maxId, sinceId: sinceId) { (dicArray) in
            
            
              //  以下代码抽取到了 StatusDAL
            
//        }
//
//        SUPStatusDAL.checkCacheData(maxId: maxId, sinceId: sinceId)
//        SUPNetworkTools.sharedTools.requestStatuses(accessToken: SUPUserAccountViewModel.sharedUserAccount.accessToken!, maxId: maxId, sinceId: sinceId) { (response, error) -> () in
//            if error != nil {
//                SUPLog("网络请求异常,\(String(describing: error))")
//                callBack(false, result)
//                return
//            }
//            //  代码执行到此,表示网络请求成功
//            guard let dic = response as? [String: AnyObject] else {
//                SUPLog("字典格式不正确")
//                callBack(false, result)
//                return
//            }
//            //  字典格式正确
//            guard let dicArray = dic["statuses"] as? [[String: AnyObject]] else {
//                SUPLog("字典格式不正确")
//                callBack(false, result)
//                return
//            }
//
////              缓存微博数据
//            SUPStatusDAL.cacheData(statusDicArray: dicArray)
        
            var tempArray = [SUPStatusViewModel]()
            SUPLog(tempArray)
            for value in dicArray {
                
                //  字典转模型
                let status = SUPStatus(dic: value)
                
                //  viewModel
                let statusViewModel = SUPStatusViewModel(status: status)
                
                tempArray.append(statusViewModel)
                
            }
            //  设置数据源
//            self.statusList = tempArray
            if isPullup {
                //  上拉加载追加服务端返回的数据
                self.statusList.append(contentsOf: tempArray)
            } else {
                //  下拉刷新服务端返回的数据插入到第一个元素
                self.statusList.insert(contentsOf: tempArray, at: 0)
            }
            //  刷新数据
            //            self.tableView.reloadData()
            
            
            
            if tempArray.count > 0 {
                result = "加载了\(tempArray.count)条数据"
            }
            callBack(true, result)
            
        }
        
    }
}
