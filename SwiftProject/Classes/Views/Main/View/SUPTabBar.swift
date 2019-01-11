//
//  SUPTabBar.swift
//  SwiftProject
//
//  Created by NShunJian on 2018/7/2.
//  Copyright © 2018年 superMan. All rights reserved.
//

import UIKit
// 继承 NSObjectProtocol,可以使用weak,进行弱引用修饰
protocol SUPTabBarDelegate: NSObjectProtocol {
    func didSelectedComposeButton()
}
class SUPTabBar: UITabBar {
    //  撰写按钮的闭包
    var composeButtonClosure: (()->())?
    //  定义代理对象
    weak var supDelegate: SUPTabBarDelegate?
    
    private lazy var composeButton: UIButton = {
        let button = UIButton()
        //  添加点击事件
        button.addTarget(self, action: #selector(SUPTabBar.composeButtonAction), for: .touchUpInside)
        //  设置背景图片
        button.setBackgroundImage(UIImage.init(named: "tabbar_compose_button"), for: UIControlState.normal)
        button.setBackgroundImage(UIImage(named: "tabbar_compose_button_highlighted"), for: .highlighted)
        //  设置图片
        button.setImage(UIImage(named: "tabbar_compose_icon_add"), for: .normal)
        button.setImage(UIImage(named: "tabbar_compose_icon_add_highlighted"), for: .highlighted)
        
        //  指定大小
        button.sizeToFit()
        
        return button
    }()
    
    //  手写代码的方式去创建对象
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
     //  加载xib/StoryBoard会调用该方法
    required init?(coder aDecoder: NSCoder) {
        //  不支持xib/sb创建对象
        //        fatalError("init(coder:) has not been implemented")
        //  支持xib写法
        super.init(coder: aDecoder)
        setupUI()
        
    }
    //  MARK:   --添加视图
    private func setupUI() {
        
        addSubview(composeButton)
        
    }
      //  MARK: - 点击事件
    //  使用private定义的函数是私有的, swift在运行循环里面找不到,原因是swift是编译型语言,在编译的时候就需要知道调用哪个函数, 为了追求性能
    //  可以使用@objc, 告诉系统我们使用oc基于动态运行机制调用这个函数
    @objc private func composeButtonAction() {
        
        //  执行闭包 composeButtonClosure?() 就相当于执行 SUPMainViewController中tabbar.composeButtonClosure后面的闭包
//        tabbar.composeButtonClosure = { [weak self] in
        //  进入发微博界面
//        self?.pushComposeVC()
//        SUPLog("我是闭包调用过来的\(String(describing: self))")
//    }
        
        //  使用'?'判断我们的闭包是否为nil,如果为nil后面的代码就不执行,直接返回nil,否则执行后面代码
        composeButtonClosure?()
        
        //  使用代理对象调用代理方法
        supDelegate?.didSelectedComposeButton()
        
    }
    
    //  调整子控件的布局
    override func layoutSubviews() {
        
        //  必须调用
        super.layoutSubviews()
        //  设置中心x
        composeButton.centerX = width * 0.5
        //  设置中心y
        composeButton.centerY = height * 0.5
        
        //  计算按钮的宽度
        let itemWidth = width / 5
        //  记录当前遍历的系统按钮的索引
        var index = 0
        //  怎么取按钮, 遍历子控件
        for value in subviews {
            //  判断是否是UITabBarButton, UITabBarButton.self表示取到Class, 私有的不能直接使用
            
            if value.isKind(of: NSClassFromString("UITabBarButton")!) {
                //  设置系统按钮的宽度
                value.width = itemWidth
                //  指定系统按钮的x坐标
                value.x = CGFloat(index) * itemWidth
                
                index += 1
                //  如果将要显示搜索按钮,当前index++,多一个按钮的宽度
                if index == 2 {
                    index += 1
                }
            }
            
            
            
        }
        
        
    }
    
    
        
}
