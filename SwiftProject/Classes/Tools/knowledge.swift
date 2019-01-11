//
//  knowledge.swift
//  SwiftProject
//
//  Created by NShunJian on 2018/7/6.
//  Copyright © 2018年 superMan. All rights reserved.
//

import Foundation




//通知闭包的方式
/*
 返回的观察者
 var observer: NSObjectProtocol?
 override func viewDidLoad() {
 super.viewDidLoad()
 
 //  注册通知
 //  name: 通知名
 //  object: 能够接收哪个对象发送的通知, 如果传入nil表示任意对象发送的通知都能接收
 //  queue: 表示队列, 如果传入nil表示在当前队列执行,否则根据你传入的队列执行这个闭包
 //  usingBlock 监听通知的方法
 
 /*
 1. 使用self会产生循环引用 -> [weak self]解决
 2. 会给我返回一个观察者对象,不能直接使用self移除通知,要移除返回的观察者对象
 -NSNotificationCenter.defaultCenter().removeObserver(observer!)
 */
 
 observer = NSNotificationCenter.defaultCenter().addObserverForName("test", object: nil, queue: nil) { [weak self] (noti) -> Void in
 
 //  监听通知方法的回调
 print(self?.view)
 
 }
 
 
 }
 
 override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
 //  发送通知
 NSNotificationCenter.defaultCenter().postNotificationName("test", object: nil)
 }
 
 
 
 deinit {
 print("over")
 //  移除通知
 NSNotificationCenter.defaultCenter().removeObserver(observer!)
 
 }
 */

