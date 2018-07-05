//
//  SUPUserAccount.swift
//  SwiftProject
//
//  Created by NShunJian on 2018/7/3.
//  Copyright © 2018年 superMan. All rights reserved.
//

import UIKit

class SUPUserAccount: NSObject, NSCoding {
   
    //  用户授权的唯一票据
    @objc var access_token: String?
    //  access_token的生命周期，单位是秒数。
    @objc var expires_in: TimeInterval = 0 {
        didSet {
            //  过期时间 = 获取accesstoken那一刻起的时间 + 过期秒数
            //  dateByAddingTimeInterval函数的意思在当前时间的基础加上多少秒
            expiresDate = NSDate().addingTimeInterval(expires_in)
            
        }
    }
    
    //  过期时间
    @objc var expiresDate: NSDate?
    
    //  授权用户的UID
    @objc var uid: Int64 = 0
    //  用户名
    @objc var name: String?
    //  头像
    @objc var avatar_large: String?

    //  kvc构造函数
    //  AnyObject 好比oc里面id类型,表示任意对象类型
    init(dic: [String: AnyObject]) {
        SUPLog(dic)
        super.init()
        setValuesForKeys(dic)
        
    }
   
    //  防止字段不匹配,导致崩溃
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
    //  重写description
    override var description: String {
        
        let keys = ["access_token", "expires_in", "uid", "name", "avatar_large"]
        
        return dictionaryWithValues(forKeys: keys).description
    }
    
    
    //  归档
    func encode(with aCoder: NSCoder) {
        aCoder.encode(access_token, forKey: "access_token")
        aCoder.encode(expiresDate, forKey: "expiresDate")
        aCoder.encode(uid, forKey: "uid")
        aCoder.encode(name, forKey: "name")
        aCoder.encode(avatar_large, forKey: "avatar_large")
    }
    
    //  解档
    required init?(coder aDecoder: NSCoder) {
        access_token = aDecoder.decodeObject(forKey: "access_token") as? String
        expiresDate = aDecoder.decodeObject(forKey: "expiresDate") as? NSDate
        uid = aDecoder.decodeInt64(forKey: "uid")
        name = aDecoder.decodeObject(forKey: "name") as? String
        avatar_large = aDecoder.decodeObject(forKey: "avatar_large") as? String
    }
    //  调用该方法保存用户对象到指定沙盒路径
    func saveUserAccount() {
        //  设置保存路径
        let path = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! as NSString).appendingPathComponent("userAccount.archive")
        SUPLog(path)
        //  执行归档
        SUPLog(self)
        NSKeyedArchiver.archiveRootObject(self, toFile: path)
        
    }
    //  类函数
    class func loadUserAccount() -> SUPUserAccount?{
        //  设置保存路径
        let path = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! as NSString).appendingPathComponent("userAccount.archive")
        SUPLog(path)
        //  执行解档
        return NSKeyedUnarchiver.unarchiveObject(withFile: path) as? SUPUserAccount
    }
    
    
    
    
}
