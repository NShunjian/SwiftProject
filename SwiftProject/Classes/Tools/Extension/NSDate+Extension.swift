//
//  NSDate+Extension.swift
//  SwiftProject
//
//  Created by NShunJian on 2018/7/11.
//  Copyright © 2018年 superMan. All rights reserved.
//

import UIKit
extension NSDate {
    //  通过时间字符串转成时间对象
    class func sinaDate(createDateStr: String) -> NSDate {
        //  代码执行到此,表示发微博时间不为nil,表示没有问题
        let dt = DateFormatter()
        //  指定格式化方式
        dt.dateFormat = "EEE MMM dd HH:mm:ss z yyyy"
        //  指定本地化信息
        dt.locale = NSLocale(localeIdentifier: "en_US") as Locale!
        //  通过格式化方式转成成时间对象
        //  当前时间加上多少秒
        //  NSDate().dateByAddingTimeInterval(-3600-1000)
        let createDate = dt.date(from: createDateStr)!
        
        return createDate as NSDate
    }
    
    var sinaDateString: String {
        
        let dt = DateFormatter()
        //  指定本地化信息
        dt.locale = NSLocale(localeIdentifier: "en_US") as Locale!
        
        if isThisYear(createDate: self) {
            //  是今年
            //  日历对象
            let calendar = NSCalendar.current
            
            
            if calendar.isDateInToday(self as Date) {
                //  是今天
                //                createDate.timeIntervalSinceDate(<#T##anotherDate: NSDate##NSDate#>)
                //  获取发微博时间距离当前时间差多少秒
                let timeInterVal = abs(self.timeIntervalSinceNow)
                
                if timeInterVal < 60 {
                    return "刚刚"
                } else if timeInterVal < 3600 {
                    
                    let result = timeInterVal / 60
                    
                    return "\(Int(result))分钟前"
                    
                } else {
                    let result = timeInterVal / 3600
                    return "\(Int(result))小时前"
                }
                
            } else if calendar.isDateInYesterday(self as Date) {
                //  昨天
                dt.dateFormat = "昨天 HH:mm"
            } else {
                //  其它
                dt.dateFormat = "MM-dd HH:mm"
            }
            
            
            
        } else {
            //  不是今年 2015-10-20 20:10
            dt.dateFormat = "yyyy-MM-dd HH:mm"
        }
        
        return dt.string(from: self as Date)
        
    }
    
    
    
    //  根据时间判断是否是今年
    private func isThisYear(createDate: NSDate) -> Bool {
        
        let dt = DateFormatter()
        //  指定格式化方式
        dt.dateFormat = "yyyy"
        //  指定本地化信息
        dt.locale = NSLocale(localeIdentifier: "en_US") as Locale!
        //  获取发微博时间的年份
        let createDateYear = dt.string(from: createDate as Date as Date)
        //  获取当前时间的年份
        let currentDateYear = dt.string(from: NSDate() as Date)
        //  对比年份是否相同
        return createDateYear == currentDateYear
        
        
        
    }
    
    
}
