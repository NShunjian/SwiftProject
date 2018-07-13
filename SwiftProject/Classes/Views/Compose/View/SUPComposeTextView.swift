//
//  SUPComposeTextView.swift
//  SwiftProject
//
//  Created by NShunJian on 2018/7/12.
//  Copyright © 2018年 superMan. All rights reserved.
//

import UIKit
//  自定义UITextView
//  @IBDesignable 实时看到修改后属性的值
@IBDesignable
class SUPComposeTextView: UITextView {

    //  占位label
    private lazy var placeHolderLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.text = "听说下雨天音乐跟辣条更配哟~"
        label.textColor = UIColor.lightGray
        //  多行显示
        label.numberOfLines = 0
        
        return label
    }()
    
    //  提供外界设置占位文字的属性
    //  @IBInspectable 给xib/sb添加可以设置的属性
    @IBInspectable var placeHolder: String? {
        didSet {
            placeHolderLabel.text = placeHolder
            
        }
    }
    //  重写font
    override var font: UIFont? {
        didSet {
            if font != nil {
                //  当前外界设置Font让占位label与其同步
                placeHolderLabel.font = font
            }
        }
    }
    //  重写text
    override var text: String? {
        didSet {
            //  根据文本内容显示占位label
            placeHolderLabel.isHidden = hasText
        }
    }
    
    //  手写代码方式
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        setupUI()
    }
    
    //  使用xib加载方式
    required init?(coder aDecoder: NSCoder) {
        //  支持xib的写法
        super.init(coder: aDecoder)
        setupUI()
    }
    
    
    //  添加控件设置约束
    private func setupUI() {
        
        //  监听文字改变的通知
        NotificationCenter.default.addObserver(self, selector: #selector(SUPComposeTextView.textChange), name: NSNotification.Name.UITextViewTextDidChange, object: nil)
        
        
        addSubview(placeHolderLabel)
        
        //  使用系统约束  之前设置 placeHolderLabel.translatesAutoresizingMaskIntoConstraints = false
        
        placeHolderLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addConstraint(NSLayoutConstraint(item: placeHolderLabel, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1, constant: -10))
        
    }
    
    
    //  MARK: --监听文字改变的通知
    @objc private func textChange() {
        
        //        if hasText() {
        //            placeHolderLabel.hidden = true
        //        } else {
        //            placeHolderLabel.hidden = false
        //        }
        
        
        
        //  根据是否有值判断是否显示占位label
        placeHolderLabel.isHidden = hasText
        
    }
    
    
    //  给子控件设置约束
    override func layoutSubviews() {
        super.layoutSubviews()
        //  设置x,y坐标
        placeHolderLabel.frame.origin.x = 5
        placeHolderLabel.frame.origin.y = 7
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        
    }
    

}
