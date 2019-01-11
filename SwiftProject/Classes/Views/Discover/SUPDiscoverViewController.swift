//
//  SUPDiscoverViewController.swift
//  SwiftProject
//
//  Created by NShunJian on 2018/7/2.
//  Copyright © 2018年 superMan. All rights reserved.
//

import UIKit

class SUPDiscoverViewController: SUPVisitorViewControlle {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isLogin {
            
        } else {
            //  设置访客视图信息
            visitorView?.updateVisitorViewInfo(message: "登录后，最新、最热微博尽在掌握，不再会与实事潮流擦肩而过", imageName: "visitordiscover_image_message")
        }
    }
}
