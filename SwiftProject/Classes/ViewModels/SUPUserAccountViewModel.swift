//
//  SUPUserAccountViewModel.swift
//  SwiftProject
//
//  Created by NShunJian on 2018/7/5.
//  Copyright © 2018年 superMan. All rights reserved.
//

import UIKit
//  封装OAuth相关网络请求接口,对应的控制器 SUPOAuthViewController
class SUPUserAccountViewModel: NSObject {
    // 单例
    static let sharedUserAccount: SUPUserAccountViewModel = SUPUserAccountViewModel()
    
    //  用户账号模型
    var userAccount: SUPUserAccount? {
        return SUPUserAccount.loadUserAccount()
    }
    
    //  判断是否登录
    var isLogin: Bool {
        return accessToken != nil
    }
    //  封装accesstoken,判断逻辑
    var accessToken: String? {
        //  判断accesstoken是否为nil
        
        guard let token = userAccount?.access_token else {
            return nil
        }
        
        //  如果accesstoken不为nil,判断accesstoken的时间是否过期
        let result =  userAccount?.expiresDate?.compare(NSDate() as Date)
        //  如果是降序表示accesstoken没有过期
        if result == ComparisonResult.orderedDescending {
            return token
        } else {
            return nil
        }
    }
    //  通过code获取accesstoken
    func reqeustAccessTokenWithCode(code: String, callBack: @escaping (_ isSuccess: Bool)->()) {
        
        SUPNetworkTools.sharedTools.reqeustAccessTokenWithCode(code: code) { (response, error) -> () in
            if error != nil {
                SUPLog("网络请求失败\(String(describing: error))")
                callBack(false)
                return
            }
            
            //  代码执行到此网络请求成功
            
            //  判断服务端给的数据是否是一个正确的字典
            guard let dic = response as? [String: AnyObject] else {
                SUPLog("不是一个正确的字典格式")
                callBack(false)
                return
            }
            //  代码执行到此,字典没有问题
            let userAccount = SUPUserAccount(dic: dic)
            SUPLog(userAccount.access_token)
            //  请求用户基本信息
//            self.requestUserInfo(userAccount: userAccount, callBack: callBack)
            self.requestUserInfo(userAccount: userAccount, callBack: { (isSuccess) in
                callBack(isSuccess)
            })
            
        }
    }
    //  通过accesstoken和uid获取用户信息
    private func requestUserInfo(userAccount: SUPUserAccount, callBack: @escaping (_ isSuccess: Bool)->()) {
        
        SUPNetworkTools.sharedTools.requestUserInfo(userAccount: userAccount) { (response, error) -> () in
            
            if error != nil {
                SUPLog("网络请求失败, \(String(describing: error))")
                callBack(false)
                return
            }
            
            //  代码执行到此,表示网络请求成功
            guard let dic = response as? [String: AnyObject] else {
                SUPLog("不是一个正确的字典格式")
                callBack(false)
                return
            }
            
            //  代码执行到此,表示字典没有问题
            let name = dic["name"]
            let avatar_large = dic["avatar_large"]
            
            userAccount.name = name as? String
            userAccount.avatar_large = avatar_large as? String
            
            SUPLog(userAccount)
            
            //  表示用户登录成功
            //  保存用户账号的模型
            userAccount.saveUserAccount()
            // 执行成功回调的闭包
            callBack(true)
            
            
        }
    }
    
}
