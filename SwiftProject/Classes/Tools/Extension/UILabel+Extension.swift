//
//  UILabel+Extension.swift
//  SwiftProject
//
//  Created by NShunJian on 2018/7/6.
//  Copyright © 2018年 superMan. All rights reserved.
//

import UIKit
extension UILabel {
//  通过便利构造函数创建label
convenience init(fontSize: CGFloat, textColor: UIColor) {
    //  使用self调用其他构造函数
    self.init()
    
    //  设置字体大小
    self.font = UIFont.systemFont(ofSize: fontSize)
    //  设置文字颜色
    self.textColor = textColor
    
}
}
