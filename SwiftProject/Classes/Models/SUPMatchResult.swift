//
//  SUPMatchResult.swift
//  SwiftProject
//
//  Created by NShunJian on 2018/7/17.
//  Copyright © 2018年 superMan. All rights reserved.
//

import UIKit
//  匹配表情描述和描述范围的模型
class SUPMatchResult: NSObject {
    //  匹配表情描述
    var matchString: String
    //  匹配表情描述对应的范围
    var matchRange: NSRange
    
    //  通过构造函数初始化必选属性
    init(matchString: String, matchRange: NSRange) {
        self.matchString = matchString
        self.matchRange = matchRange
        super.init()
    }
}
