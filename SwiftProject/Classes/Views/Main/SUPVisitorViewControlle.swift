//
//  SUPVisitorViewControlle.swift
//  SwiftProject
//
//  Created by NShunJian on 2018/7/3.
//  Copyright © 2018年 superMan. All rights reserved.
//

import UIKit
//  访客视图控制器
class SUPVisitorViewControlle: UITableViewController {
     //  是否登录的标记
    var isLogin:Bool = false
    var visitorView: SUPVisitorView?
    override func loadView() {
        //  登录状态下使用系统提供的视图
        if isLogin {
            super.loadView()
        } else {
            //  未登录视图,使用自己的定义访客视图
            
            visitorView = SUPVisitorView()
            
            visitorView?.loginClosure = { [weak self] in
                
                
                self?.reqeustOAuthVC()
                
            }
            
            view = visitorView
            //  设置导航栏按钮
            setNavUI()
    }
}
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }

    
    
}
extension SUPVisitorViewControlle {
    private func setNavUI() {
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "注册", target: self, action: #selector(SUPVisitorViewControlle.registerAction))
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "登录", target: self, action: #selector(SUPVisitorViewControlle.loginAction))
    }
    
    //  MARK: --点击事件
    @objc private func registerAction() {
        
        print("注册")
                reqeustOAuthVC()
    }
    @objc private func loginAction() {
        
        print("登录")
                reqeustOAuthVC()
    }
    
    //  登录第三方的函数
    private func reqeustOAuthVC() {
        
        print("登录新浪微博页面")
        
    }
}
