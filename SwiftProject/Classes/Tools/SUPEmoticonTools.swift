//
//  SUPEmoticonTools.swift
//  SwiftProject
//
//  Created by NShunJian on 2018/7/15.
//  Copyright © 2018年 superMan. All rights reserved.
//

import UIKit

//  每页显示20个表情
let NumberOfPage = 20

//  专门负责读取表情数据的工具类
class SUPEmoticonTools: NSObject {
    //  单例全局访问点
    static let sharedTools: SUPEmoticonTools = SUPEmoticonTools()
    
    //  构造函数私有化
    private override init() {
        super.init()
        
       _ = sectionEmoticonsWidthEmoticonArray(emoticonArray: defaultEmoticonArray)
        
    }
    
    //  创建bundle对象
    private lazy var emoticonBundle: Bundle = {
        //  emoticonbundle路径
        let path = Bundle.main.path(forResource: "Emoticons", ofType: "bundle")!
        
        //  创建emoticonBundle对象
        let bundle = Bundle(path: path)!
        
        return bundle
    }()
    
    //  读取默认表情图片数据
    private lazy var defaultEmoticonArray: [SUPEmoticon] = {
        
        return self.loadEmoticonsWithSubPath(subPath: "default/info.plist")
        
    }()
    
    //  读取emoji表情数据
    private lazy var emojiEmoticonArray: [SUPEmoticon] = {
        return self.loadEmoticonsWithSubPath(subPath: "emoji/info.plist")
    }()
    
    //  读取浪小花表情数据
    private lazy var lxhEmoticonArray: [SUPEmoticon] = {
        return self.loadEmoticonsWithSubPath(subPath: "lxh/info.plist")
        
    }()
    
    //  给表情视图(CollectionView)提供的数据
    lazy var allEmoticonArray: [[[SUPEmoticon]]] = {
        
        return [
            //  默认这组数据
            self.sectionEmoticonsWidthEmoticonArray(emoticonArray: self.defaultEmoticonArray),
            //  emoji这组数据
            self.sectionEmoticonsWidthEmoticonArray(emoticonArray: self.emojiEmoticonArray),
            //  lxh这组数据
            self.sectionEmoticonsWidthEmoticonArray(emoticonArray: self.lxhEmoticonArray)
        ]
    }()
    
    
    //  根据表情数组拆分成二维数据->(表示每种表情分成多少页显示完)
    
    private func sectionEmoticonsWidthEmoticonArray(emoticonArray: [SUPEmoticon]) -> [[SUPEmoticon]] {
        
        //  计算每种表情分成多少页显示
        let pageCount = (emoticonArray.count - 1) / NumberOfPage + 1
        
        
        var tempArray = [[SUPEmoticon]]()
        //  遍历页数
        for page in 0..<pageCount {
            
            //  从哪个索引开始截取
            let loc = page * NumberOfPage
            //  截取的长度
            var length = NumberOfPage
            //  表示数组不够截取
            if loc + length > emoticonArray.count {
                //  当前数组的个数 - 开始的截取的索引 = 剩余个数
                length = emoticonArray.count - loc
            }
           
            //  截取范围
            let range = NSMakeRange(loc, length)
            
            //  截取到子数组
            let subArray = (emoticonArray as NSArray).subarray(with: range)
            //  添加元素
            tempArray.append(subArray as! [SUPEmoticon])
            
        }
        return tempArray
        
    }
    
    //  根据表情子路径读取相应的数据
    private func loadEmoticonsWithSubPath(subPath: String) -> [SUPEmoticon] {
        //  获取info.plist文件路径
        let path = self.emoticonBundle.path(forResource: subPath, ofType: nil)!
        print(path)
        //  读取指定文件的数据
        let array = NSArray(contentsOfFile: path)!
        
        var tempArray = [SUPEmoticon]()
        //  遍历数组完成字典转模型
        for dic in array {
            //  字典转模型
            let emoticon = SUPEmoticon(dic: dic as! [String : AnyObject])
            //  只有图片才需要拼接路径
            if emoticon.type == "0" {
                //  删除后面的文件名
                let result = (path as NSString).deletingLastPathComponent
                //  设置图片的全路径
                emoticon.path = result + "/" + emoticon.png!
                
            }
            
            tempArray.append(emoticon)
            
        }
        return tempArray
        
    }
}
