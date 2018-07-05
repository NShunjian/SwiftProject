//
//  SUPVisitorView.swift
//  SwiftProject
//
//  Created by NShunJian on 2018/7/3.
//  Copyright © 2018年 superMan. All rights reserved.
//

import UIKit
import SnapKit
let refbutWork: String = "refbutWork";
//  访客视图
class SUPVisitorView: UIView {
    //  延时初始化
    var loginClosure: (()->())?
    //  MARK: - 懒加载控件
    //  旋转图片
    private lazy var cycleImageView: UIImageView = UIImageView(image: UIImage(named: "visitordiscover_feed_image_smallicon"))
    //  罩层
    private lazy var maskImageView: UIImageView = UIImageView(image: UIImage(named: "visitordiscover_feed_mask_smallicon"))

     //  主页图片
    private lazy var iconImageView: UIImageView = UIImageView.init(image: UIImage.init(named: "visitordiscover_feed_image_house"))
    //提示
    private lazy var msgLab: UILabel = {
        let lable = UILabel()

        lable.text = "***请在SUPOAuthViewController.swift中输入自己的***\r\n\r\n 微博AppKey: WeiboAppKey = 3165859311\r\n\r\n 微博AppSecret: WeiboAppSecret = c495c40b528ffc1e29045073b4b1da71\r\n\r\n 授权回调页: WeiboRedirect_Uri = http://www.baidu.cn"
        lable.textColor = UIColor.darkGray
        lable.font = UIFont.systemFont(ofSize: 18)
        lable.textAlignment = .center
        lable.numberOfLines = 0
        return lable
    }()
     //  消息信息
    private lazy var messageLable: UILabel = {
        let lable = UILabel()
        lable.text = "关注一些人，回这里看看有什么惊喜关注一些人，回这里看看有什么惊喜"
        lable.textColor = UIColor.darkGray
        lable.font = UIFont.systemFont(ofSize: 14)
        lable.textAlignment = .center
        lable.numberOfLines = 0
        return lable
    }()
    //注册
    private lazy var registerButton: UIButton = {
        let button = UIButton()
//        button.frame = CGRect(x: 100, y: 100, width: 30, height: 50)
        button.addTarget(self, action: #selector(SUPVisitorView.registerButtonAction), for: .touchUpInside)
        button.setTitle("注册", for: .normal)
        button.setTitleColor(UIColor.darkGray, for: .normal)
        button.setTitleColor(UIColor.orange, for: .highlighted)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.setBackgroundImage(UIImage.init(named: "common_button_white_disable"), for: .normal)
        return button
    }()
    //登录
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(SUPVisitorView.loginButtonAction), for: .touchUpInside)
        button.setTitle("登录", for: .normal)
        button.setTitleColor(UIColor.darkGray, for: .normal)
        button.setTitleColor(UIColor.orange, for: .highlighted)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.setBackgroundImage(UIImage.init(named: "common_button_white_disable"), for: .normal)
        return button
    }()
    
    private lazy var disButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(SUPVisitorView.disButtonAction), for: .touchUpInside)
        button.setTitle("移除当前页面", for: .normal)
        button.setTitleColor(UIColor.darkGray, for: .normal)
        button.setTitleColor(UIColor.orange, for: .highlighted)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.setBackgroundImage(UIImage.init(named: "common_button_white_disable"), for: .normal)
        return button
    }()
    @objc private func registerButtonAction() {
        SUPLog("注册")
        //  执行闭包
        loginClosure?()
    }
    @objc private func loginButtonAction() {
        SUPLog("登录")
        //  执行闭包
        loginClosure?()
    }
    @objc private func disButtonAction(){
        SUPLog("移除当前页面")

        NotificationCenter.default.post(name: NSNotification.Name.init(rawValue: refbutWork), object: self)
    }
    //  手写代码的方式去创建对象
    override init(frame: CGRect) {
        super.init(frame: frame)
//        self.backgroundColor = UIColor.red
        setupUI()
    }
    
    //  加载xib/StoryBoard会调用该方法
    required init?(coder aDecoder: NSCoder) {
        //  不支持xib/sb创建对象
        //        fatalError("init(coder:) has not been implemented")
        //  支持xib写法
        super.init(coder: aDecoder)
    }
    private func setupUI() {
        //  设置背景色
        backgroundColor = UIColor(white: 237.0 / 255.0, alpha: 1)
        
        addSubview(msgLab)
        addSubview(cycleImageView)
        addSubview(maskImageView)
        addSubview(iconImageView)
        addSubview(messageLable)
        addSubview(registerButton)
        addSubview(loginButton)
        addSubview(disButton)
        
        //  设置约束
        
        msgLab.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.centerY.equalTo(self).offset(-180)
            make.width.equalTo(350)
        }
        
        cycleImageView.snp.makeConstraints { (make) in
            make.center.equalTo(self)
        }
        
        maskImageView.snp.makeConstraints { (make) in
            make.center.equalTo(self)
        }
        iconImageView.snp.makeConstraints { (make) in
            make.center.equalTo(self)
        }
        messageLable.snp.makeConstraints { (make) in
            make.top.equalTo(cycleImageView.snp.bottom)
            make.centerX.equalTo(cycleImageView)
            make.width.equalTo(230)
        }
        registerButton.snp.makeConstraints {(make) in
            make.top.equalTo(messageLable.snp.bottom).offset(10)
            make.leading.equalTo(messageLable)
            make.width.equalTo(100)
            make.height.equalTo(35)
            
        }
        loginButton.snp.makeConstraints { (make) in
            make.top.equalTo(messageLable.snp.bottom).offset(10)
            make.trailing.equalTo(messageLable)
            make.size.equalTo(registerButton)
        }
        
        disButton.snp.makeConstraints { (make) in
            make.top.equalTo(loginButton.snp.bottom).offset(30)
            make.trailing.equalTo(loginButton)
            make.leading.equalTo(registerButton)
            make.height.equalTo(35)
            
        }
        
//        startAnimation()
    }
    
    
}

extension SUPVisitorView {
    //  开启动画
    private func startAnimation() {
        
        //  创建核心动画
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        //  动画目的地
        animation.toValue = 2 * Double.pi
        //  动画时长
        animation.duration = 20
        //  执行次数
        animation.repeatCount = MAXFLOAT
        //  动画执行完成不让其释放
        animation.isRemovedOnCompletion = false
        //  执行动画
        cycleImageView.layer.add(animation, forKey: nil)
        
    }
    //  修改访客视图信息
    func updateVisitorViewInfo(message: String?, imageName: String?) {
        
        if let msg = message,let imgName = imageName {
            //  消息,发现,我的设置的访客视图信息
            messageLable.text = msg
            iconImageView.image = UIImage(named: imgName)
            //  隐藏旋转图片
            cycleImageView.isHidden = true
        }else {
            //  表示首页要设置的访客视图情况
            //  显示旋转图片
            cycleImageView.isHidden = false
            //  只有首页开启旋转动画
            startAnimation()
        }
    }
}


