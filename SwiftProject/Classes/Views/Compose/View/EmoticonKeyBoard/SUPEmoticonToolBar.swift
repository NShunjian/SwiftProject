//
//  SUPEmoticonToolBar.swift
//  SwiftProject
//
//  Created by NShunJian on 2018/7/13.
//  Copyright © 2018年 superMan. All rights reserved.
//

import UIKit

enum SUPEmoticonToolBarButtonType: Int {
    //  默认表情
    case Normal = 1000
    //  emoji表情
    case Emoji = 1001
    //  浪小花表情
    case LXH = 1002
}


class SUPEmoticonToolBar: UIStackView {

    //  点击toolbar按钮执行的闭包
    var didSeletedButtonClosure: ((_ type: SUPEmoticonToolBarButtonType)->())?
    
    
    
    //  记录上一次的选中按钮
    var lastSelectedButton: UIButton?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupUI() {
        //  水平方向布局
        axis = .horizontal
        //  等比填充
        distribution = .fillEqually
        
        addChildButton(title: "默认", imageName: "compose_emotion_table_left", type: .Normal)
        addChildButton(title: "Emoji", imageName: "compose_emotion_table_mid", type: .Emoji)
        addChildButton(title: "浪小花", imageName: "compose_emotion_table_right", type: .LXH)
    }
    
    //  添加子按钮的通用方法
    private func addChildButton(title: String, imageName: String, type: SUPEmoticonToolBarButtonType) {
        let button = UIButton()
        //  根据枚举的原始值最为tag
        button.tag = type.rawValue
        //  添加点击事件
        button.addTarget(self, action: #selector(SUPEmoticonToolBar.buttonAction(button:)), for: .touchUpInside)
        button.setTitle(title, for: .normal)
        //  设置不同状态的文字颜色
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitleColor(UIColor.gray, for: .selected)
        
        //  设置不同状态的背景图片
        button.setBackgroundImage(UIImage(named: "\(imageName)_normal"), for: .normal)
        button.setBackgroundImage(UIImage(named: "\(imageName)_selected"), for: .selected)
        //  设置字体大小
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        //  去掉高亮
        button.adjustsImageWhenHighlighted = false
        //
        addArrangedSubview(button)
        if type == .Normal {
            lastSelectedButton?.isSelected = false
            button.isSelected = true
            lastSelectedButton = button
        }
    }
    
    //  MARK: -- 点击事件
    @objc private func buttonAction(button: UIButton) {
        //  如果上次点击的选中的按钮和这次点击的按钮一样,那么就直接返回,不执行后面的代码
        if lastSelectedButton == button {
            return
        }
        
        //  上一次的按钮取消选中
        lastSelectedButton?.isSelected = false
        //  设置选中状态
        button.isSelected = true
        //  保存选中的按钮
        lastSelectedButton = button
        //  通过枚举的原始值获取枚举
        let type = SUPEmoticonToolBarButtonType(rawValue: button.tag)!
        //  执行点击闭包
        didSeletedButtonClosure?(type)
        
    }
    
    //  通过指定的section选中相应的按钮
    
    func selectedButtonWithSection(section: Int) {
        
        //  通过tag获取相应的按钮, 建议以后给控件设置tag的时候不要设置0,因为0获取不是指定类型的控件,获取的自身
        let button = viewWithTag(section + 1000) as! UIButton
        //        if lastSelectedButton == button {
        //            return
        //        }
        
//        上面 if lastSelectedButton == button 也可以
        if lastSelectedButton?.tag == section + 1000 {
            return
        }
        
        
        SUPLog(section)
        lastSelectedButton?.isSelected = false
        button.isSelected = true
        lastSelectedButton = button
    }
}
