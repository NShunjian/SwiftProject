//
//  CommonTools.swift
//  SwiftProject
//
//  Created by NShunJian on 2018/7/5.
//  Copyright © 2018年 superMan. All rights reserved.
//

import UIKit
/* 请输入自己的 */  //回调网址也要在微博开发平台里面写入
//  微博AppKey
let WeiboAppKey = "2969513224"
//  微博AppSecret
let WeiboAppSecret = "877b3fb57f9dc49b6a5d92bc75631a69"
//  授权回调页 微博开发平台里面将其写入里面 记住!!!!!!!!
let WeiboRedirect_Uri = "http://www.baidu.com/"


//  切换根视图控制器的通知名
let SwitchRootVCNotification = "SwitchRootVCNotification"
//  当前屏幕的宽度
let ScreenWidth = UIScreen.main.bounds.size.width
//  当前屏幕的高度
let ScreenHeight = UIScreen.main.bounds.size.height

//  通过随机数返回颜色对象
func RandomColor() -> UIColor {
    
    //  色值得取值范围0-255
    let red = arc4random() % 256
    let green = arc4random() % 256
    let blue = arc4random() % 256
    
    
    // red ,green ,blue, alpha 他们的取值范围0-1之间
    return UIColor(red: CGFloat(red) / 255   , green: CGFloat(green) / 255 , blue: CGFloat(blue) / 255 , alpha: 1)
    
}

typealias Task = (_ cancel : Bool) -> Void

func delay(_ time: TimeInterval, task: @escaping ()->()) ->  Task? {
    
    func dispatch_later(block: @escaping ()->()) {
        let t = DispatchTime.now() + time
        DispatchQueue.main.asyncAfter(deadline: t, execute: block)
    }
    var closure: (()->Void)? = task
    var result: Task?
    
    let delayedClosure: Task = {
        cancel in
        if let internalClosure = closure {
            if (cancel == false) {
                DispatchQueue.main.async(execute: internalClosure)
            }
        }
        closure = nil
        result = nil
    }
    
    result = delayedClosure
    
    dispatch_later {
        if let delayedClosure = result {
            delayedClosure(false)
        }
    }
    return result
}

func cancel(_ task: Task?) {
    task?(true)
}

