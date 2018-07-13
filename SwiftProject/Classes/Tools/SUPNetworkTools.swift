//
//  SUPNetworkTools.swift
//  SwiftProject
//
//  Created by NShunJian on 2018/7/3.
//  Copyright © 2018年 superMan. All rights reserved.
//

import UIKit
import AFNetworking
//  网络请求的枚举类型
enum RequestType: Int {
    //  get 请求方式
    case GET = 0
    //  post 请求方式
    case POST = 1
}
class SUPNetworkTools: AFHTTPSessionManager {
    
    //  单例全局访问点
    static let sharedTools: SUPNetworkTools = {
        let tools = SUPNetworkTools()
        //  添加响应可接受的类型
        tools.responseSerializer.acceptableContentTypes?.insert("text/plain")
        return tools
        
    }()
    
    
    func request(Method:RequestType = .GET, URLString: String,parameters: [String: AnyObject]?, completed:@escaping ((_ response: AnyObject?, _ error: Error?)->())) {
        
        /// 定义成功回调闭包
        let success = { (task: URLSessionDataTask,response: Any?)->() in
            completed(response as AnyObject?, nil)
        }
        
        /// 定义失败回调闭包
        let failure = {(task: URLSessionDataTask?, error: Error)->() in
            completed(nil,error )
        }
        
        /// 通过请求方法,执行不同的请求
        // 如果是 GET 请求
        if Method == .GET { // GET
            
            get(URLString, parameters: parameters, progress: nil, success: success, failure: failure)
            
        } else { // POST
            
            post(URLString, parameters: parameters, progress: nil, success: success, failure: failure)
        }
    }
    
}
//  发微博相关接口
extension SUPNetworkTools {
    //  发送文字微博
    func update(access_token: String, status: String, callBack: @escaping (_ response: AnyObject?, _ error: NSError?)->()) {
        //  准备url  需要到安全设置里设置一下
        let url = "https://api.weibo.com/2/statuses/update.json"
        SUPLog(access_token)
        SUPLog(status)
        //  准备参数
        let params = [
            "access_token": access_token,
            "status": status
        ]

        request(Method: .POST, URLString: url, parameters: params as [String : AnyObject]?) { (response, error) in
            
            callBack(response as AnyObject?,error as NSError?)
        }
    }
    
}
//  首页相关接口
extension SUPNetworkTools {
    
    //  获取当前登录用户及其所关注（授权）用户的最新微博
    func requestStatuses(accessToken: String, maxId: Int64 = 0, sinceId: Int64 = 0, callBack: @escaping (_ response: AnyObject?, _ error: NSError?)->()) {
        //  准备url  https://api.weibo.com/2/statuses/home_timeline.json
        let url = "https://api.weibo.com/2/statuses/home_timeline.json"
        //  准备参数
        let params = [
            "access_token": accessToken,
            "max_id": "\(maxId)",
            "since_id": "\(sinceId)"
        ]
        
        let path = url + "?access_token=" + accessToken
        SUPLog(path)
        
        request(Method: .GET, URLString: url, parameters: params as [String : AnyObject]?) { (response, error) in
            
            callBack(response as AnyObject?,error as NSError?)
        }
    }
    
}


//  OAuth登录相关接口
extension SUPNetworkTools {
    //  通过code获取accesstoken
    func reqeustAccessTokenWithCode(code: String, callBack:@escaping (_ response: AnyObject?, _ error: NSError?)->()) {
        //  准备url
        let url = "https://api.weibo.com/oauth2/access_token"
        
        //  准备参数
        let params = [
            "client_id": WeiboAppKey,
            "client_secret": WeiboAppSecret,
            "grant_type": "authorization_code",
            "code": code,
            "redirect_uri": WeiboRedirect_Uri
        ]

        request(Method: .POST, URLString: url, parameters: params as [String : AnyObject]?) { (response, error) in
            
            callBack(response as AnyObject?,error as NSError?)
        }
        
    }
    //  通过accesstoken和uid获取用户信息
    func requestUserInfo(userAccount: SUPUserAccount, callBack: @escaping (_ response: AnyObject?, _ error: NSError?)->()) {
        //  准备url
        let url = "https://api.weibo.com/2/users/show.json"
        
        //  准备参数
        let params = [
            "access_token": userAccount.access_token!,
            "uid": "\(userAccount.uid)"
        ]
        
        //  执行请求
        request(Method: .GET, URLString: url, parameters: params as [String : AnyObject]?) { (response, error) in
            
            callBack(response as AnyObject?,error as NSError?)
        }
    }
}
