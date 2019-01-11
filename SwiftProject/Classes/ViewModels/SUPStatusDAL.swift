//
//  SUPStatusDAL.swift
//  SwiftProject
//
//  Created by NShunJian on 2018/7/18.
//  Copyright © 2018年 superMan. All rights reserved.
//

import UIKit
//  最后删除缓存时间
let MaxTimeInterval: TimeInterval = -7 * 24 * 60 * 60
//  数据库访问层, 用于缓存微博数据及加载网络请求的微博数据

class SUPStatusDAL: NSObject {
    //  处理微博首页数据缓存逻辑
    
    class func loadData(maxId: Int64, sinceId: Int64, callBack: @escaping (_ statusDicArray: [[String: AnyObject]])->()) {
        
        //  1 判断本地是否有缓存数据(完成)
        let result = checkCacheData(maxId: maxId, sinceId: sinceId)
        //  2.如果本地有缓存数据直接返回缓存数据
        if result.count > 0 {
            callBack(result)
            return
        }
        //  3.如果本地没有缓存数据那么去网络请求微博数据
        SUPNetworkTools.sharedTools.requestStatuses(accessToken: SUPUserAccountViewModel.sharedUserAccount.accessToken!, maxId: maxId, sinceId: sinceId) { (response, error) -> () in
            if error != nil {
                SUPLog("网络请求异常,\(String(describing: error))")
                callBack(result)
                return
            }
            //  代码执行到此,表示网络请求成功
            guard let dic = response as? [String: AnyObject] else {
                SUPLog("字典格式不正确")
                callBack(result)
                return
            }
            //  字典格式正确
            guard let dicArray = dic["statuses"] as? [[String: AnyObject]] else {
                SUPLog("字典格式不正确")
                callBack(result)
                return
            }
            
            //  4. 网络请求成功后缓存到本地 (完成)
            //  缓存微博数据
            SUPStatusDAL.cacheData(statusDicArray: dicArray)
            //  5. 缓存到本地成功后返回网络请求的数据
            callBack(dicArray)
        }
        
        
    }
    //  查询本地缓存数据
    class func checkCacheData(maxId: Int64, sinceId: Int64) -> [[String: AnyObject]] {
        //  SELECT * FROM statuses where statusid > 4010861599809739 and userid = 1800530611 order by statusid desc limit 20
        //  准备sql
        var sql = "SELECT * FROM statuses\n"
        
        if maxId > 0 {    
            //  上拉加载
            sql += "where statusid < \(maxId)\n"
        } else {
            //  下拉刷新
            sql += "where statusid > \(sinceId)\n"
        }
        //  拼接userid
        sql += "and userid = \(SUPUserAccountViewModel.sharedUserAccount.userAccount!.uid)\n"
        //  排序方式
        sql += "order by statusid desc\n"
        //  最大获取数量
        sql += "limit 20\n"
        
        
        let result = SqliteManager.sharedManager.queryDicArrayForSql(sql: sql)

        var tempArray = [[String: AnyObject]]()
        for value in result {
            //  获取微博二进制数据
            let statusData = value["status"]! as! NSData
            //  通过微博二进制数据转成微博字典
            let statusDic = try! JSONSerialization.jsonObject(with: statusData as Data, options: []) as! [String: AnyObject]
            tempArray.append(statusDic)
        }
        
        return tempArray
        
        
    }
    
    
    //  缓存微博数据
    class func cacheData(statusDicArray: [[String: AnyObject]]) {
        //  准备sql
        let sql = "INSERT OR Replace INTO statuses (statusid, status, userid) VALUES (?, ?, ?)"
        //  用户id
        let userid = SUPUserAccountViewModel.sharedUserAccount.userAccount!.uid
        //  执行sql语句
        SqliteManager.sharedManager.queue.inTransaction { (db, rollBack) -> Void in
            //  遍历微博字典数组插入数据
            for statusDic in statusDicArray {
                //  微博id
                let id = statusDic["id"]!
                //  微博内容
                let statusDicData = try! JSONSerialization.data(withJSONObject: statusDic, options: [])
                let result = db.executeUpdate(sql, withArgumentsIn: [id, statusDicData, "\(userid)"])
                
                if result == false {
                    //  如果出现异常让事务回滚
//                    rollBack.pointee = true

                    rollBack.pointee  = true
                    break
                }
                
                
            }
            
            
        }
        
        
    }
    
    
    //  清除缓存数据
    class func clearCacheData() {
//        let date = NSDate().addingTimeInterval(-10 * 60)  //表示当前时间的10分钟之前的时间,比如: 当前时间 10:28 10分钟之前的是 10:18 ,   后面的数据库就是要删除掉 10:18以前的数据, 保留当前时间 10分钟 之内的数据, 就是10:28 到 10:18 之内 10分钟 的数据
//        SUPLog(NSDate())
//        SUPLog(NSDate().addingTimeInterval(10 * 60))
//        SUPLog(date)
        
        
        let date = NSDate().addingTimeInterval(MaxTimeInterval) //表示当前时间的7天之前的时间
        let dt = DateFormatter()
        dt.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dt.locale = NSLocale(localeIdentifier: "en_US") as Locale?
        
        //  获取时间字符串
        let dtStr = dt.string(from: date as Date)
        SUPLog(dtStr)
        //  准备sql语句
        let sql = "Delete FROM statuses where time < '\(dtStr)'"
        //  执行sql语句
        SqliteManager.sharedManager.queue.inDatabase { (db) -> Void in
            let result = db.executeUpdate(sql, withArgumentsIn: [])
            if result {
                //  changes 这次数据操作影响的行数
                SUPLog("删除数据成功, 影响了\(db.changes)条数据")
            } else {
                SUPLog("删除数据失败")
            }
        }
        
    }
    
    
    
    
}
