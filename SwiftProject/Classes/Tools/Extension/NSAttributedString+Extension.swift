//
//  File.swift
//  SwiftProject
//
//  Created by NShunJian on 2018/7/15.
//  Copyright © 2018年 superMan. All rights reserved.
//

import UIKit
extension NSAttributedString {
    
    //  通过表情模型创建表情富文本对象
    class func attributedStringWithEmoticon(emoticon: SUPEmoticon, font: UIFont) -> NSAttributedString {
        
        
        //   1. 通过图片名创建一个UIImage对象
        let image = UIImage(named: emoticon.path!)
        //   2. 通过UIImage对象创建一个文本附件(NSTextAttachment)
        let attachment =  SUPTextAttachment() //NSTextAttachment()
        //  设置文本附件对象的表情模型
        attachment.emoticon = emoticon
        //  获取文字的行高
        let fontHeight = font.lineHeight
        //  设置图片大小和位置, 设置bounds会影响子控件的布局
        attachment.bounds = CGRect(x: 0, y: -4, width: fontHeight, height: fontHeight)
        //  设置图片
        attachment.image = image
        //   3. 通过文本附件创建富文本(NSAttributedString)
        let attributedStr = NSAttributedString(attachment: attachment)
        
        return attributedStr
        
        
    }
    
    
    
}
