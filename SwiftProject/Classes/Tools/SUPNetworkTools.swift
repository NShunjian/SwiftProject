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
    
    //  闭包的别名
    typealias CallBackType = (_ response: AnyObject?, _ error: NSError?)->()
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
    
    
    //  封装上传图片接口
    func requestUpload(url: String, params: AnyObject?, imageData: NSData, name: String, callBack: @escaping CallBackType) {
        
        
        post(url, parameters: params, constructingBodyWith: { (formData) in
                    //  data 图片对应的二进制数据
                    //  name 服务端需要参数
                    //  fileName 图片对应名字,一般服务不会使用,因为服务端会直接根据你上传的图片随机产生一个唯一的图片名字
                    //  mimeType 资源类型
                    //  不确定参数类型 可以这个 octet-stream 类型, 二进制流
            formData.appendPart(withFileData: imageData as Data, name: name, fileName: "test", mimeType: "application/octet-stream")
            
        }, progress: nil, success: { (task: URLSessionDataTask?, response: Any?) in
            callBack(response as AnyObject, nil)
            
        }) { (_, error: Error) in
            callBack(nil, error as NSError)
            
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
    
  
    //  上传带有图片的微博接口
    //  status: 微博数据参数
    func update(access_token: String, status: String, image: UIImage, callBack: @escaping (_ response: AnyObject?, _ error: NSError?)->()) {
        //  准备url  需要到安全设置里设置一下
        let url = "https://api.weibo.com/2/statuses/update.json"
        SUPLog(access_token)
        SUPLog(status)
        //  准备参数
        let params = [
            "access_token": access_token,
            "status": status
        ]

        
        //  把图片转成二进制数据
        let imageData = UIImageJPEGRepresentation(image, 0.5)!
        
        requestUpload(url: url, params: params as AnyObject, imageData: imageData as NSData, name: "pic", callBack: callBack)
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
