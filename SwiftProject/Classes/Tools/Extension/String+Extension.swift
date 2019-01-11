//
//  String+Extension.swift
//  SwiftProject
//
//  Created by NShunJian on 2018/7/7.
//  Copyright © 2018年 superMan. All rights reserved.
//

import UIKit
//更优雅的写法
extension String{
    subscript(range:ClosedRange<Int>)->String{
        let range = self.index(startIndex, offsetBy: range.lowerBound )...self.index(startIndex, offsetBy: range.upperBound)
        return String(self[range]);
    }
}
//调用
//let string = "你好,我是酷走天涯"
//let subString1 = string[1...5];


//扩展下标写法(好东西,写共有方法,经常用)
extension String {
    subscript(n : Int) -> Character {
        let index = self.index(self.startIndex , offsetBy: n);
        return self[index];
    }
}
//// 调用
//let string = "你好,我是酷走天涯"
//let bbbstr = string[2];

////截取字符串
//let greeting = "Guqten Tag!";
////截取单个
//greeting[greeting.startIndex];
//greeting.startIndex
//greeting[greeting.index(greeting.startIndex, offsetBy: 2)];
////截取一段
//
//greeting[greeting.index(greeting.startIndex, offsetBy: 2)..<greeting.index(greeting.endIndex, offsetBy: -3)];
//"Guqten Tag!"[greeting.index(greeting.endIndex, offsetBy: -1)]
//greeting.endIndex
//greeting.index(greeting.endIndex, offsetBy: -1)
//greeting.index(greeting.startIndex, offsetBy: 2)

