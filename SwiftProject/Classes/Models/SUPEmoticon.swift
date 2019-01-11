//
//  SUPEmoticon.swift
//  SwiftProject
//
//  Created by NShunJian on 2018/7/15.
//  Copyright © 2018年 superMan. All rights reserved.
//

import UIKit
//  表情模型
class SUPEmoticon: NSObject {
    //  表情描述 -> 发送后台让其识别为表情的字段
   @objc var chs: String?
    //  图片名称
   @objc var png: String?
    //  表情类型 0 - 图片, 1 - emoji
   @objc var type: String?
    
    //  16进制的emoji表情字符串
   @objc var code: String?
    
    //  图片全路径 -> 原因是在Emoticons.boundle里的图片在mainbundle找不到
   @objc var path: String?
    
    //  kvc构造函数
    init(dic: [String: AnyObject]) {
        super.init()
        setValuesForKeys(dic)
        
    }
    //  防止字段不匹配导致崩溃
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
    
}
