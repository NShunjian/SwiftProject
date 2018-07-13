//
//  SUPComposeToolBar.swift
//  SwiftProject
//
//  Created by NShunJian on 2018/7/12.
//  Copyright © 2018年 superMan. All rights reserved.
//

import UIKit

//  toolbar按钮的枚举类型
enum CZComposeToolBarButtonType: Int {
    //  图片
    case Picture = 0
    //  @
    case Mention = 1
    //  #
    case Trend = 2
    //  表情
    case Emoticon = 3
    //  加号
    case Add = 4
}
//  自定义发微博toolbar
//  UIStackView 是容器, 不具备渲染功能,颜色根据子控件显示
class SUPComposeToolBar: UIStackView {

    //  点击按钮需要执行的闭包
    var didSelecteToolBarButtonClosure: ((_ type: CZComposeToolBarButtonType)->())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    //  添加控件设置布局方式
    private func setupUI() {
        //  水平方向布局
        axis = .horizontal
        //  子控件等比填充
        distribution = .fillEqually
        //  创建按钮
        addChildButton(imageName: "compose_toolbar_picture", type: .Picture)
        addChildButton(imageName: "compose_mentionbutton_background", type: .Mention)
        addChildButton(imageName: "compose_trendbutton_background", type: .Trend)
        addChildButton(imageName: "compose_emoticonbutton_background", type: .Emoticon)
        addChildButton(imageName: "compose_add_background", type: .Add)
    }
    
    //  创建子按钮的通用方法
    private func addChildButton(imageName: String, type: CZComposeToolBarButtonType) {
        let button = UIButton()
        //  根据枚举的原始值,作为按钮的tag
        button.tag = type.rawValue
        
        //  添加点击事件
        button.addTarget(self, action: #selector(SUPComposeToolBar.buttonAction(button:)), for: .touchUpInside)
        //  设置图片
        button.setImage(UIImage(named: imageName), for: .normal)
        button.setImage(UIImage(named: "\(imageName)_highlighted"), for: .highlighted)
        
        //  设置背景图片
        button.setBackgroundImage(UIImage(named: "compose_toolbar_background"), for: .normal)
        
        //button.backgroundColor = UIColor(patternImage: UIImage(named: "compose_toolbar_background")!)
        
        //  取消高亮效果
        button.adjustsImageWhenHighlighted = false
        
        //  添加按钮
        addArrangedSubview(button)
        
    }
    
    
    //  MARK:   - 点击事件
    
    @objc private func buttonAction(button: UIButton) {
        //  通过原始值获取枚举
        let type = CZComposeToolBarButtonType(rawValue: button.tag)!
        
        //  执行闭包,传入参数(枚举)
        didSelecteToolBarButtonClosure?(type)
    }
    
    

}
