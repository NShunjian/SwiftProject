//
//  SUPStatusPictureInfo.swift
//  SwiftProject
//
//  Created by NShunJian on 2018/7/7.
//  Copyright © 2018年 superMan. All rights reserved.
//

import UIKit
//  配图信息模型
class SUPStatusPictureInfo: NSObject {
    //  配图地址
    @objc var thumbnail_pic: String?
     
    //  kvc构造函数
    init(dic: [String: AnyObject]) {
        
        super.init()
        //  kvc初始化
        setValuesForKeys(dic)
        
    }
    
    //  防止字段不匹配,导致崩溃
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
}
