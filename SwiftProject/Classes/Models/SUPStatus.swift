//
//  SUPStatus.swift
//  SwiftProject
//
//  Created by NShunJian on 2018/7/6.
//  Copyright © 2018年 superMan. All rights reserved.
//

import UIKit
//  微博模型
class SUPStatus: NSObject {
    //  发微博时间
   @objc var created_at: String?
    //  微博id
   @objc var id: Int64 = 0
    //  微博内容
   @objc var text: String?
    //  来源
   @objc var source: String?
    //  关注用户的模型
   @objc var user: SUPUser?
    //  kvc构造函数
    init(dic: [String: AnyObject]) {
        super.init()
        setValuesForKeys(dic)
    }
    //这个方法写了必须调用super.setValue(value, forKey: key), 不写的话 系统会默认执行 setValue(_ value: Any?, forKey key: String)
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "user" {
            guard let dic = value as? [String: AnyObject] else {
                return
            }
            
            //  代码到此,字典没有问题
            user = SUPUser(dic: dic)
        } else {
            super.setValue(value, forKey: key)
        }
    }
    
    //  防止字段不匹配,导致崩溃
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
