//
//  SUPMainViewController.swift
//  SwiftProject
//
//  Created by NShunJian on 2018/7/2.
//  Copyright © 2018年 superMan. All rights reserved.
//

import UIKit

class SUPMainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //  全局设置UITabbar的tintColor, 执行的越早越好,一般会放到appdelegate里面
//        UITabBar.appearance().tintColor = UIColor.orange
        //  设置自定义的Tabbar
        let tabbar = SUPTabBar()
        //  设置代理对象
        tabbar.supDelegate = self
        tabbar.composeButtonClosure = { [weak self] in
            
            SUPLog("我是闭包调用过来的\(String(describing: self))")
        }
        //  使用kvc方式给系统的只读属性设置值   (只读属性赋值要用KVC)
//        self.tab Bar //系统只读属性
        setValue(tabbar, forKey: "tabBar")
        //  添加子视图控制器
        addChildViewController(childController: SUPHomeViewController(), imageName: "tabbar_home", title: "首页")
        
        addChildViewController(childController: SUPMessageViewController(), imageName: "tabbar_message_center", title: "消息")
        addChildViewController(childController: SUPDiscoverViewController(), imageName: "tabbar_discover", title: "发现")
        addChildViewController(childController: SUPProfileViewController(), imageName: "tabbar_profile", title: "我的")
    }
    deinit {
        SUPLog("被销毁")
    }
   
}
extension SUPMainViewController: SUPTabBarDelegate {
    //  实现代理方法
    func didSelectedComposeButton() {
         SUPLog("我是代理对象调用过来的")
    }
    
    
}
extension SUPMainViewController {
    
    // MARK:- 重载添加子控制器的函数
    func addChildViewController(childController: UIViewController, imageName: String, title: String) {
        // 设置图片
//        childController.tabBarItem.image = UIImage(named: imageName)
        childController.tabBarItem.image = UIImage.init(named: imageName)
        // 修改渲染模式
//        childController.tabBarItem.selectedImage = UIImage(named: "\(imageName)_selected")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
         childController.tabBarItem.selectedImage = UIImage.init(named: "\(imageName)_selected")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        // 通过 UITabBar.appearance().tintColor = UIColor.orange 也可以设置
        
        //  设置标题
        // childController.tabBarItem.title = title
        // childController.navigationItem.title = title
        childController.title = title  //等同于上面两句
        //  添加点tabBar带文字的图片
        //        if title == "我的" {
        //            childController.title = nil
        //            childController.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
        //        }
        // 设置文字的颜色
        childController.tabBarItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.orange], for: .selected)
        // 设置字体大小
        childController.tabBarItem.setTitleTextAttributes([NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)], for: UIControlState.normal)
        // 添加到导航控制器
        let nav = UINavigationController(rootViewController: childController)
        // 给当前对象添加子视图控制器
        addChildViewController(nav)
        
    }
}













