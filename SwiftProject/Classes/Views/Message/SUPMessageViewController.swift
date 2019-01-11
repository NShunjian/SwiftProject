//
//  SUPMessageViewController.swift
//  SwiftProject
//
//  Created by NShunJian on 2018/7/2.
//  Copyright © 2018年 superMan. All rights reserved.
//

import UIKit

class SUPMessageViewController: SUPVisitorViewControlle {

    override func viewDidLoad() {
        super.viewDidLoad()
        if isLogin {
            
        } else {
            //  设置访客视图信息
            visitorView?.updateVisitorViewInfo(message: "登录后，别人评论你的微博，发给你的消息，都会在这里收到通知", imageName: "visitordiscover_image_message")
        }
    }
}
