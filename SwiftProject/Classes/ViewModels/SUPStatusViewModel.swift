//
//  SUPStatusViewModel.swift
//  SwiftProject
//
//  Created by NShunJian on 2018/7/6.
//  Copyright © 2018年 superMan. All rights reserved.
//

import UIKit
//  微博数据处理的ViewModel 对应的视图是首页自定义的cell(SUPStatusTableViewCell)
class SUPStatusViewModel: NSObject {
    
    /*
     这里就是 MVVM中  viewModel 引用 model  var status: SUPStatus?
     */
    //  提供微博数据模型
    var status: SUPStatus?
    
    //  转发数内容
    var retweetCountContent: String?
    //  评论数内容
    var commentCountContent: String?
    //  赞数内容
    var unlikeCountContent: String?
    
    
    //  转发微博内容
    var retweetContent: String?
    //  来源数据
    var sourceContent: String?
    //  会员等级图片
    var mbrankImage: UIImage?
    //  认证类型等级图片
    var verifiedTypeImage: UIImage?
    /*
     //  判断时间是否是今年
     //  判断是否是今天
     //  判断是否是1分钟之内
     //  - 刚刚
     //  判断是否是1小时之内
     //  - xx分钟前
     //  其它
     //  - xx小时前
     //  判断是否是昨天
     //  - 昨天 10:10
     //  其他
     08-14 08:41
     //  不是今年
     //  2015-10-20 20:10
     
     */
    
    var timeContent: String? {
        
        guard let createDateStr = status?.created_at else {
            return nil
        }
        
        return NSDate.sinaDate(createDateStr: createDateStr).sinaDateString
        
        
        
    }
    //  通过重载构造函数初始化当前对象
    init(status: SUPStatus) {
        super.init()
        /*
         这里就是 MVVM中  model 绑定数据 给 viewModel  self.status = status(下面的属性都有绑定数据)   因为这里的viewModel引用了var status: SUPStatus? model模型
         */
        self.status = status
        //  处理转发,评论,赞的逻辑处理
        retweetCountContent = handleCount(count: status.reposts_count, defaultTitle: "转发")
        commentCountContent = handleCount(count: status.comments_count, defaultTitle: "评论")
        unlikeCountContent = handleCount(count: status.attitudes_count, defaultTitle: "赞")
        
        //  处理转发微博
        handleRetweetContent(status: status)
        //  处理来源数据
        SUPLog(status.source)
        handleSource(source: status.source ?? "")
        //  处理会员等级图片
        handleMbrankImage(mbrank: status.user?.mbrank ?? 0)
        //  处理认证类型等级图片
        handleVerifiedTypeImage(verifiedType: status.user?.verified_type ?? -1)
}
    
    //  处理微博数据里面的逻辑...
    //  处理认证类型等级图片
    private func handleVerifiedTypeImage(verifiedType: Int) {
        
        //认证类型等级 -1 没有认证 ，0 认证用户，2，3，5 企业认证 ， 220 达人
        
        switch verifiedType {
        case 0:
            verifiedTypeImage = UIImage(named: "avatar_vip")
        case 2, 3 ,5:
            verifiedTypeImage = UIImage(named: "avatar_enterprise_vip")
        case 220:
            verifiedTypeImage = UIImage(named: "avatar_grassroot")
        default:
            verifiedTypeImage = nil
            
        }
        
    }
    //  处理会员等级图片
    private func handleMbrankImage(mbrank: Int) {
        
        if mbrank >= 1 && mbrank <= 6  {
            
            //  合法的会员等级范围
            mbrankImage = UIImage(named: "common_icon_membership_level\(mbrank)")
        }
    }
    //  处理来源数据
    private func handleSource(source: String) {
        //  判断字符串中是否包含这样关键字符串
        if source.contains("\">") && source.contains("</") {
            //  开始光标位置
            // \"> 这个字符串在我们整体字符串source里的范围 下面同理
            let startIndex = source.range(of: "\">")!.upperBound //光标在 \">| 最前面 | 表示光标
            //  结束光标位置
            let endIndex = source.range(of: "</")!.lowerBound //光标在 |</ 最后面  | 表示光标
            
            //  获取指定范围的字符串
          let result = source[source.index(startIndex, offsetBy: 0)..<source.index(endIndex, offsetBy: 0)];
               SUPLog(source)
               SUPLog(result)
            //  设置给来源数据
            sourceContent = "来自: " + result
        }
    }
    
    //  处理转发微博内容的拼接逻辑
    private func handleRetweetContent(status: SUPStatus) {
        //  判断是否有转发微博内容
        if status.retweeted_status != nil {
            //  取到内容
            //  取到转发的用户昵称
            guard let text = status.retweeted_status?.text, let name = status.retweeted_status?.user?.screen_name else {
                return
            }
            
            //  拼接转发微博内容
            let result = "@\(name): \(text)"
            
            retweetContent = result
        }
        
    }
    
    //  处理转发, 评论,赞数的逻辑
    private func handleCount(count: Int, defaultTitle: String) -> String {
        //  判断传入的参数是否大于0
        //     判断是否大于等于10000
        //  显示 1.x万, ...
        // 不是大于等于10000
        //  显示当前的数据
        
        //  不大与0
        //  显示原始文本
        
        if count > 0 {
            
            if count >= 10000 {
                
                let result = CGFloat(count / 1000) / 10
                
                
                var resultStr = "\(result)万"
                //  判断字符串中是否包含0
                if resultStr.contains(".0") {

                    resultStr = resultStr.replacingOccurrences(of:".0", with: "")
                }
                return resultStr
                
                
            } else {
                return "\(count)"
            }
            
            
        } else {
            
            return defaultTitle
        }
        
    }
    
}



