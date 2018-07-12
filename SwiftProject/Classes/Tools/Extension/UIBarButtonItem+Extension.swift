//
//  UIBarButtonItem+Extension.swift
//  Weibo30
//
//  Created by apple on 16/8/8.
//  Copyright © 2016年 itcast. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    //  不能提供指定构造函数
//    init(name: String) {
//        
//    }
    
    //  便利构造函数创建UIBarButtonItem类型的对象
    //如果不想返回nil , init? 问号可以省略
    convenience init(title: String, target: AnyObject?, action: Selector) {
        //  使用self调用其他构造函数
        self.init()
        
        let button = UIButton()
        //  添加点击事件
        button.addTarget(target, action: action, for: .touchUpInside)
        button.setTitle(title, for: .normal)
        button.setTitleColor(UIColor.darkGray, for: .normal)
        button.setTitleColor(UIColor.orange, for: .highlighted)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.sizeToFit()
        //  设置自定义视图
        customView = button
        
    }

}
