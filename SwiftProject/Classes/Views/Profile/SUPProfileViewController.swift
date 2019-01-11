//
//  SUPProfileViewController.swift
//  SwiftProject
//
//  Created by NShunJian on 2018/7/2.
//  Copyright © 2018年 superMan. All rights reserved.
//

import UIKit

class SUPProfileViewController: SUPVisitorViewControlle {

    override func viewDidLoad() {
        super.viewDidLoad()
        if isLogin {
            
        } else {
            //  设置访客视图信息
            visitorView?.updateVisitorViewInfo(message: "登录后，你的微博、相册、个人资料会显示在这里，展示给别人", imageName: "visitordiscover_image_profile")
        }
    }
}
