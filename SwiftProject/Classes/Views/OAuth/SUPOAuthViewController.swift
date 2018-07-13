//
//  SUPOAuthViewController.swift
//  SwiftProject
////    //  通过code获取accesstoken
//    private func reqeustAccessTokenWithCode(code: String) {
//        SUPNetworkTools.sharedTools.reqeustAccessTokenWithCode(code: code) { (response, error) in
//            if error != nil {
//                SUPLog("网络请求失败\(String(describing: error))")
//                return
//            }
//
//            //  代码执行到此网络请求成功
//
//            //  判断服务端给的数据是否是一个正确的字典
//            guard let dic = response as? [String: AnyObject] else {
//                SUPLog("不是一个正确的字典格式")
//                return
//            }
//            //  代码执行到此,字典没有问题
//            let userAccount = SUPUserAccount(dic: dic)
//            SUPLog(userAccount.access_token)
//            //  请求用户基本信息
//            self.requestUserInfo(userAccount: userAccount)
//
//        }
//
//
//    }
//
//    //  通过accesstoken和uid获取用户信息
//    private func requestUserInfo(userAccount: SUPUserAccount) {
//        //  准备url
//        let url = "https://api.weibo.com/2/users/show.json"
//        //  准备参数
//        let params = [
//            "access_token": userAccount.access_token!,
//            "uid": "\(userAccount.uid)"
//        ]
//
//        let path = url + "?access_token=" + userAccount.access_token! + "&uid=" + "\(userAccount.uid)"
//        SUPLog("--" + path)
//
//        //  创建sessionManager对象
//        let sessionManager = AFHTTPSessionManager()
//        sessionManager.responseSerializer.acceptableContentTypes?.insert("text/plain")
//        //  发送get请求
//        sessionManager.get(url, parameters: params, progress: nil, success: { (_, response) -> Void in
//            //  判断服务端给的数据是否是一个正确的json数据
//            guard let dic = response as? [String: AnyObject] else {
//                SUPLog("不是一个正确的字典格式")
//                return
//            }
//
//            //  代码执行到此,字典没有问题
//            let name = dic["name"]
//            let avatar_large = dic["avatar_large"]
//
//            userAccount.name = name as? String
//            userAccount.avatar_large = avatar_large as? String
//
//            SUPLog(userAccount)
//
//            //  表示用户登录成功
//            //  保存用户账号的模型
//            userAccount.saveUserAccount()
//
//
//        }) { (_, error) -> Void in
//            SUPLog(error)
//        }
//    }

//  Created by NShunJian on 2018/7/3.
//  Copyright © 2018年 superMan. All rights reserved.
//

import UIKit
import AFNetworking
import SVProgressHUD


////  微博AppKey
//let WeiboAppKey = "3165859311"  //请输入自己的
////  微博AppSecret
//let WeiboAppSecret = "c495c40b528ffc1e29045073b4b1da71"   //请输入自己的
////  授权回调页
//let WeiboRedirect_Uri = "http://www.baidu.cn"

class SUPOAuthViewController: UIViewController {
    //  MARK:   -- 懒加载
    private lazy var webView: UIWebView = UIWebView()
    //    如果让webView作为当前控制器的一个视图 要重写loadView
    override func loadView() {
        //  改成透明的
        webView.isOpaque = false
        //  设置代理
        webView.delegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavUI()
        requestOAuthLogin()
        // Do any additional setup after loading the view.
    }
    private func setNavUI() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消", target: self, action: #selector(SUPOAuthViewController.cancelAction))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "自动填充", target: self, action: #selector(SUPOAuthViewController.autoFillAction))
        navigationItem.title = "微博登录"
        
    }
    
    //  MARK:   --点击事件
    @objc private func cancelAction() {
        
        dismiss(animated: true, completion: nil)
        
    }
    
    @objc private func autoFillAction() {
        
        webView.stringByEvaluatingJavaScript(from: "document.getElementById('userId').value = '13671234700';document.getElementById('passwd').value = '1594040902Csj'")
        
        
    }
    
    
    //  请求第三方登录页面
    private func requestOAuthLogin() {
        
        //  准备url
        let url = "https://api.weibo.com/oauth2/authorize?client_id=\(WeiboAppKey)&redirect_uri=\(WeiboRedirect_Uri)"
        
        SUPLog(url)
        
        //  准备urlRequest
        let urlRequest = NSURLRequest.init(url: NSURL(string: url)! as URL)
        //  通过webView加载页面
        webView.loadRequest(urlRequest as URLRequest)
        
    }
    
    
}



//  MARK: -UIWebViewDelegate 代理
extension SUPOAuthViewController: UIWebViewDelegate {
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        SUPLog(request.url?.absoluteString)//完整的url字符串
        
        guard let url = request.url else {
            return false
        }
        
        //  代码执行到此,url一定有值
        
        //  不是以回调页打头, 我不需要关心
        if !url.absoluteString.hasPrefix(WeiboRedirect_Uri) {
            return true
        }
        //  代码执行到此,是我们的回调页打头
        
        if let query = url.query, query.hasPrefix("code=") {
            //  获取code
            SUPLog(query)
            
            let code = (query as NSString).substring(from: "code=".count)
            
            SUPLog(code)
            //  获取accesstoken
            //                    reqeustAccessTokenWithCode(code: code)
            
            SUPUserAccountViewModel.sharedUserAccount.reqeustAccessTokenWithCode(code: code, callBack: { (isSuccess) in
                
                if isSuccess {
                    SUPLog("登录成功")
                    //  切换根视图控制器需要在线dismis完成以后闭包里面, 要不然能present这个控制器不能释放
                    self.dismiss(animated: false, completion: {
                         NotificationCenter.default.post(name: NSNotification.Name.init(rawValue: SwitchRootVCNotification), object: self)
                    })
                   
                    
                } else {
                    SUPLog("登录失败")
                }
            })
            
        }else {
            
            dismiss(animated: true, completion: nil)
        }
        return false  //不加载
        //        return true   //加载
    }
    
    
    
    //  开始加载
    func webViewDidStartLoad(_ webView: UIWebView) {
        SVProgressHUD.show()
    }
    
    //  加载完成
    func webViewDidFinishLoad(_ webView: UIWebView) {
        SVProgressHUD.dismiss()
    }
    
    //  加载失败
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        SVProgressHUD.dismiss()
        if (error as NSError).code == NSURLErrorCancelled {
            return;
        }
    }
    
    
    
}

