//
//  SUPEmoticonCollectionViewCell.swift
//  SwiftProject
//
//  Created by NShunJian on 2018/7/13.
//  Copyright © 2018年 superMan. All rights reserved.
//

import UIKit
//  表情视图自定义cell
class SUPEmoticonCollectionViewCell: UICollectionViewCell {
     var observer: NSObjectProtocol?
    //  表情数组模型
    var emoticons: [SUPEmoticon]? {
        didSet {
            
            guard let ets = emoticons else {
                return
            }
            
            //  默认请情况下表情按钮都隐藏,设置数据的时候再让其显示出来
            for value in emoticonButtonArray {
                //  隐藏表情
                value.isHidden = true
            }
            
            //  绑定表情数据
            for (i, value) in ets.enumerated() {
                //  获取表情按钮的控件
                let emoticonButton = emoticonButtonArray[i]
                //  绑定数据显示表情按钮
                emoticonButton.isHidden = false
                //  绑定表情模型
                emoticonButton.emoticon = value
                //  如果是0表示设置图片
                if value.type == "0" {
                    emoticonButton.setImage(UIImage(named: value.path!), for: .normal)
                    //  设置图片不需要设置文字
                    emoticonButton.setTitle(nil, for: .normal)
                } else {
                    //  设置emoji
                    emoticonButton.setTitle((value.code! as NSString).emoji(), for: .normal)
                    //  设置emoji不需要设置图片
                    emoticonButton.setImage(nil, for: .normal)
                }
              }
        }
    }
    
    //  记录创建的20个表情按钮
    private lazy var emoticonButtonArray: [SUPEmoticonButton] = [SUPEmoticonButton]()
    
    
    var indexPath: NSIndexPath? {
        didSet {
            
            guard let index = indexPath else {
                return
            }
            
//            contentView.addSubview(messageLabel)
            messageLabel.text = "当前显示的是第\(index.section + 1)组第\(index.item + 1)页"
            
            
        }
    }
    //  删除表情按钮
    private lazy var deleteButton: UIButton = {
        let button = UIButton()
        //  添加点击事件
        button.addTarget(self, action: #selector(SUPEmoticonCollectionViewCell.deleteButtonAction), for: .touchUpInside)
        button.setImage(UIImage(named: "compose_emotion_delete"), for: .normal)
        button.setImage(UIImage(named: "compose_emotion_delete_highlighted"), for: .highlighted)
        return button
    }()
    //  MARK:   --懒加载控件
    private lazy var messageLabel: UILabel = {
        let label = UILabel(fontSize: 20, textColor: UIColor.black)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    //告诉不支持xib/sb
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
//        contentView.addSubview(messageLabel)
//
//        messageLabel.snp.makeConstraints { (make) -> Void in
//            make.center.equalTo(contentView)
//        }
        
        //  添加表情按钮
        addChildButton()
        //  添加删除表情按钮
        contentView.addSubview(deleteButton)
    }
    //  添加表情按钮
    private func addChildButton() {
        //  遍历20次创建表情按钮
        for _ in 0..<20 {
            let button = SUPEmoticonButton()
            //  添加点击事件
            button.addTarget(self, action: #selector(SUPEmoticonCollectionViewCell.emoticonButtonAction(button:)), for: .touchUpInside)
            //  设置字体大小
            button.titleLabel?.font = UIFont.systemFont(ofSize: 34)
            contentView.addSubview(button)
            //  存储到数组里面
            emoticonButtonArray.append(button)
        }
    }
    
    //  MARK:   -- 点击删除按钮的事件
    @objc private func deleteButtonAction() {
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: DidSelectedDeleteEmoticonNotification), object: nil)
    }
    
    //  MARK:   -- 点击表情按钮事件
    @objc private func emoticonButtonAction(button: SUPEmoticonButton) {
        
        let emoticon = button.emoticon
        
        //  发送通知
//        NotificationCenter.defaultCenter().postNotificationName(DidSelectedEmoticonNotification, object: emoticon)
        //  发送通知
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: DidSelectedEmoticonNotification), object: emoticon)
     }
    
    //  给表情按钮布局
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //  计算表情按钮的宽度
        let itemWidth = width / 7
        //  计算表情按钮的高度
        let itemHeight = height / 3
        
        for (i, value) in emoticonButtonArray.enumerated() {
            //  设置大小
            value.size = CGSize(width: itemWidth, height: itemHeight)
            
            //  计算当前的列的索引
            let colIndex = i % 7
            //  计算当前的行的索引
            let rowIndex = i / 7
            
            //  设置x坐标和y坐标
            value.x = CGFloat(colIndex) * itemWidth
            value.y = CGFloat(rowIndex) * itemHeight
         }
        
        //  设置删除按钮的大小
        deleteButton.size = CGSize(width: itemWidth, height: itemHeight)
        //  设置x,y坐标
        deleteButton.x = width - itemWidth
        deleteButton.y = height - itemHeight
        
        
    }
    
}
