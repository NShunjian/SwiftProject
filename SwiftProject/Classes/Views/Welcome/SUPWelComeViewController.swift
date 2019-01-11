//
//  SUPWelComeViewController.swift
//  SwiftProject
//
//  Created by NShunJian on 2018/7/5.
//  Copyright © 2018年 superMan. All rights reserved.
//

import UIKit
import SnapKit
import SDWebImage
//  欢迎页面
class SUPWelComeViewController: UIViewController {
    //  MARK: --懒加载控件
    //  背景图片
    private lazy var bgImageView: UIImageView = UIImageView(image: UIImage(named: "ad_background"))
    //  头像
    private lazy var headImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "avatar_default_big"))
        //  修改圆角
        imageView.layer.cornerRadius = 45
        //  剪切掉多余图片
        imageView.layer.masksToBounds = true
        return imageView
        
    }()
    //  欢迎信息
    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = UIColor.darkGray
        label.font = UIFont.systemFont(ofSize: 14)
        
        //  如果有头像,我们服务端提供的头像
        if let avatar_large = SUPUserAccountViewModel.sharedUserAccount.userAccount?.avatar_large {
            self.headImageView.sd_setImage(with: NSURL(string: avatar_large) as URL?, placeholderImage: UIImage(named: "avatar_default_big"))
        }
        
        if let name = SUPUserAccountViewModel.sharedUserAccount.userAccount?.name {
            label.text = "欢迎回来, \(name)"
        } else {
            label.text = "欢迎回来"
        }
        
        
        return label
        
    }()
    
    
    override func loadView() {
        view = bgImageView
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    //  页面已经显示出来,执行动画
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startAnimation()
    }
    
    
    //  执行动画
    private func startAnimation() {
        //  更新约束
        //  设置透明度
        messageLabel.alpha = 0
        headImageView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(view).offset(100)
        }
        //  usingSpringWithDamping 表示阻尼, 0-1, 阻尼越大表示弹簧效果越小
        //  initialSpringVelocity 表示弹簧初始速度
        //  枚举什么不传,可以使用中括号, 多个枚举使用,隔开
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: [], animations: { () -> Void in
            
            self.view.layoutIfNeeded()
            
        }) { (_) -> Void in
            
            
            UIView.animate(withDuration: 1, animations: { () -> Void in
                
                self.messageLabel.alpha = 1
                
                
            }, completion: { (_) -> Void in
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: SwitchRootVCNotification), object: nil)
            })
        }
        
    }
    
    
    //  添加视图,设置约束pm
    private func setupUI() {
        view.addSubview(headImageView)
        view.addSubview(messageLabel)
        
        headImageView.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(view)
            make.top.equalTo(view).offset(200)
            make.size.equalTo(CGSize(width: 90, height: 90))
            
        }
        messageLabel.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(headImageView)
            make.top.equalTo(headImageView.snp.bottom).offset(10)
        }
        
    }


}
