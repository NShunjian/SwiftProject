//
//  SqliteManager.swift
//  FMDBSwift
//
//  Created by NShunJian on 2018/7/17.
//  Copyright © 2018年 superMan. All rights reserved.
//

import UIKit
import FMDB
//  数据库名称
let DBName = "Sina.db"
//  数据库存储的沙盒路径
let DBPath =  (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! as NSString).appendingPathComponent(DBName)

//  数据库操作专用类型
class SqliteManager: NSObject {

    //  单例全局访问点
    static let sharedManager: SqliteManager = SqliteManager()
    
    //  数据库操作队列
    lazy var queue = FMDatabaseQueue(path: "/Users/cuishunjian/Desktop/Sina.db")
//    lazy var queue = FMDatabaseQueue(path: DBPath) //上面这个临时用的 一般都是放在沙盒路径中的
    
    //  构造函数私有化
    private override init() {
        super.init()
        print(DBPath)
        print(queue)
        createTables()
        
    }
    
    
    //  通过查询sql语句返回数组字典
    func queryDicArrayForSql(sql: String) -> [[String: AnyObject]] {
        
        var tempArray = [[String: AnyObject]]()
        
        queue.inDatabase { (db) in
            let resultSet = db.executeQuery(sql, withArgumentsIn: [])
            //  遍历结果集,判断是否有下一条记录
            while (resultSet?.next())! {

                //  获取列数
                guard let cols = resultSet?.columnCount else{
                    return
                }

                var dic = [String: AnyObject]()
                
                //  遍历列数
                for i in 0..<cols {

                    
                    //  获取列名对应的值
                    let colValue = resultSet?.object(forColumnIndex: i)
                    //resultSet.objectForColumnName(colName)

                    //dic.updateValue(<#T##value: Value##Value#>, forKey: <#T##Hashable#>)
                    //  添加键值对
                    //  获取列名
                    if let colName = resultSet?.columnName(for: i) {
                          dic[colName] = colValue as AnyObject
                    }
                  
                }

                tempArray.append(dic)

            }

        }

        return tempArray
        
    }
    
    
    //  查询结果以字典的形式输出
    func selectIntoDic() {
        //  准备sql
        let sql = "SELECT * FROM T_PERSON"
        //  执行sql
        queue.inDatabase { (db) in
            let resultSet = db.executeQuery(sql, withArgumentsIn: [])
            //  遍历结果集,判断是否有下一条记录
            while (resultSet?.next())! {
                
                //  获取列数
                guard let cols = resultSet?.columnCount else{
                    return
                }

                var dic = [String: AnyObject]()
                print(cols)
                //  遍历列数
                for i in 0..<cols {
                    
                    
                    //  获取列名对应的值
                    let colValue = resultSet?.object(forColumnIndex: i)
                    print(colValue)
                    //resultSet.objectForColumnName(colName)
                    //  获取列名
                    if let colName = resultSet?.columnName(for: i) {
                        
                        //  添加键值对
                        //dic.updateValue(<#T##value: Value##Value#>, forKey: <#T##Hashable#>)
                        dic[colName] = colValue as AnyObject
                    }
                    
                }
                
                print(dic)
                
            }
            
        }
        
    }
    
    
    
    
    //  删除数据
    func delete() {
        //  准备sql语句
        let sql = "DELETE FROM T_PERSON WHERE ID = ?"
        //  执行sql
        queue.inDatabase { (db) -> Void in
            let result = db.executeUpdate(sql, withArgumentsIn: [14])
            if result {
                print("删除成功")
            } else {
                print("删除失败")
            }
        }
    }
    
    //  修改数据
    func update() {
        //  准备sql
        let sql = "UPDATE T_PERSON SET NAME = ? WHERE ID = ?"
        //  执行sql
        queue.inDatabase { (db) -> Void in
            let result = db.executeUpdate(sql, withArgumentsIn: ["杨幂", 12])
            if result {
                print("修改成功")
            } else {
                print("修改失败")
            }
        }
        
    }
    
    
    //  查询数据
    func select() {
        //  准备sql
        let sql = "SELECT ID, NAME, AGE FROM T_PERSON"
        //  执行sql语句
        queue.inDatabase { (db) in
            //  查询到的结果集
            let resultSet = db.executeQuery(sql, withArgumentsIn: [])
            
            //  判断其是否有下一条记录
            print((resultSet?.next())!)
            
            while (resultSet?.next())! {
                //  获取id
                let id = resultSet?.int(forColumn: "ID")
                //  获取名字
                let name = resultSet?.string(forColumn: "NAME")
                
                //  年龄
                let age = resultSet?.int(forColumn: "AGE")
                
                
                print("id: \(id), name: \(name), age: \(age) ")
                
                
            }

        }
        
    }
    
    //  插入数据
    func insert() {
        //  准备sql
        let sql = "INSERT INTO T_PERSON (NAME, AGE) VALUES (?, ?)"
        //  执行sql语句
        queue.inDatabase { (db) in
            let result = db.executeUpdate(sql, withArgumentsIn: ["杨钰莹", 18])
            if result {
                print("插入成功")
            } else {
                print("插入失败")
            }
        }
        
    }
    
    
    
    
    
    
    //  创建表
    private func createTables() {
        
        let path = Bundle.main.path(forResource: "db.sql", ofType: nil)!
        
        //  准备sql语句 -> 获取文件中sql语句
        //  try! 表示文件内容没有问题, 有问题崩溃
        //  try? 表示如果有问题则不会崩溃,有问题返回nil
        //  结合do - catch, 相当于 (java , c#, ...)try - catch
        //        do {
        //            let sql = try String(contentsOfFile: path)
        //        } catch {
        //            //  error 内置参数
        //            print(error)
        //        }
        //
        
        let sql = try! String(contentsOfFile: path)
        print(sql)
        //  可以执行增加删除修改查询
        queue.inDatabase { (db) in
            let result = db.executeStatements(sql)
            if result {
                print("创表成功")
            } else {
                print("创表失败")
            }
        }
        
        
        
        
        
        
    }
    
}
