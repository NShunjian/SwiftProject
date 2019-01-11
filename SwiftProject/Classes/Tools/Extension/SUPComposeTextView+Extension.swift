//
//  SUPComposeTextView.swift
//  SwiftProject
//
//  Created by NShunJian on 2018/7/15.
//  Copyright © 2018年 superMan. All rights reserved.
//

import UIKit

extension SUPComposeTextView {
    //  通过遍历富文本获取字符串基本信息
    var emoticonText: String {
        
        //  info 富文本的信息
        //  range 富文本的范围
        //  是否停止 stop -> stop.memory = true
        var result = ""
        //枚举不传 直接来个 [] 就可以 例如:options
        self.attributedText.enumerateAttributes(in: NSMakeRange(0, self.attributedText.length), options: []) { (info, range, stop) -> Void in
            //            print(info)
            //            print(range)
            if let attachment = info[NSAttributedStringKey.init(rawValue: "NSAttachment")] as? SUPTextAttachment {
                //  表示图片富文本
                let emoticon = attachment.emoticon!
                
                //  获取表情描述
                result += emoticon.chs!
                
                
            } else {
                //  文本富文本  就是文字之类的
                //  获取文本富文本的字符串, 通过指定的范围获取富文本然后再获取富文本对应的字符串
                result += self.attributedText.attributedSubstring(from: range).string
            }
            
            
        }
        return result
        
    }
    
    
    //  插入表情富文本的方法
    func insertEmoticon(emoticon: SUPEmoticon) {
        //  通过不同的表情类型设置不同表情内容
        if emoticon.type == "0" {
            //  图片
            //            textView.insertText(emoticon.chs!)
            
            //  记录上一次的富文本
            let originalAttributeStr = NSMutableAttributedString(attributedString: self.attributedText)
            
            //            //   1. 通过图片名创建一个UIImage对象
            //            let image = UIImage(named: emoticon.path!)
            //            //   2. 通过UIImage对象创建一个文本附件(NSTextAttachment)
            //            let attachment =  CZTextAttachment() //NSTextAttachment()
            //            //  设置文本附件对象的表情模型
            //            attachment.emoticon = emoticon
            //            //  获取文字的行高
            //            let fontHeight = self.font!.lineHeight
            //            //  设置图片大小和位置, 设置bounds会影响子控件的布局
            //            attachment.bounds = CGRect(x: 0, y: -4, width: fontHeight, height: fontHeight)
            //            //  设置图片
            //            attachment.image = image
            //            //   3. 通过文本附件创建富文本(NSAttributedString)
            //            let attributedStr = NSAttributedString(attachment: attachment)
            
            //  通过表情模型创建富文本对象
            let attributedStr = NSAttributedString.attributedStringWithEmoticon(emoticon: emoticon, font: self.font!)
            
            //  追加富文本
            //  originalAttributeStr.appendAttributedString(attributedStr)
            
            //  获取选中的富文本的范围
            var range = self.selectedRange
            //  设置选中范围的富文本
            originalAttributeStr.replaceCharacters(in: range, with: attributedStr)
            
            
            //   设置富文本字体的大小
            originalAttributeStr.addAttribute(kCTFontAttributeName as NSAttributedStringKey, value: self.font!, range: NSMakeRange(0, originalAttributeStr.length))
            
            //   4. 设置富文本
            self.attributedText = originalAttributeStr
            
            //  添加一个表情富文本让其光标位置+1, 让选中范围设置为0
            range.location += 1; range.length = 0
            
            //  设置选中范围
            self.selectedRange = range
            
            //  自己发送文字改变的通知
            NotificationCenter.default.post(name: NSNotification.Name.UITextViewTextDidChange, object: nil)
            
            //  自己通过代理对象调用代理方法
            //  如果使用! 表示我们确定代理对象已经实现这个代理方法, 没有实现就崩溃
            //  如果使用? 表示代理对象如果实现了代理方法那么可以直接执行,否则不执行直接返回nil
            //  使用!和?都可以, 但是为了安全可以使用?更好一些
            delegate?.textViewDidChange?(self)
            
            
            
        } else {
            //  emoji
            self.insertText((emoticon.code! as NSString).emoji())
        }
    }
}
