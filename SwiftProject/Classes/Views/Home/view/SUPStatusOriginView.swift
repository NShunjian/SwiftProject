//
//  SUPStatusOriginView.swift
//  SwiftProject
//
//  Created by NShunJian on 2018/7/6.
//  Copyright © 2018年 superMan. All rights reserved.
//

import UIKit
import SnapKit
import SDWebImage

//  原创微博视图
class SUPStatusOriginView: UIView {
    //  记录原创微博底部约束
    var originViewConstraint: Constraint?
    var statusViewModel: SUPStatusViewModel? {
        didSet {
            //  设置控件的数据
            
            if let profile = statusViewModel?.status?.user?.profile_image_url {
                //  绑定头像数据
                headImageView.sd_setImage(with: NSURL(string: profile)! as URL, placeholderImage: UIImage(named: "avatar_default_big"))
            }
            //  绑定昵称
            screenNameLabel.text = statusViewModel?.status?.user?.screen_name
            //  设置微博数据
            contentLabel.text = statusViewModel?.status?.text
            //  来源
            sourceLabel.text = statusViewModel?.sourceContent
            //  设置会员等级图片
            mbrankImageView.image = statusViewModel?.mbrankImage
            //  设置认证类型等级图片
            verifiedTypeImageView.image = statusViewModel?.verifiedTypeImage
            //  设置时间
            timeLabel.text = statusViewModel?.timeContent
            //  卸载上次约束
            originViewConstraint?.deactivate()
            //  判断原创微博的配图个数是否大于0
            if let picUrls = statusViewModel?.status?.pic_urls, picUrls.count > 0 {
                //  有配图并且个数大于0
                //  显示配图
                pictureView.isHidden = false
                //  绑定原创微博数据源
                pictureView.picUrls = picUrls
                
                //  更新约束
                self.snp.makeConstraints({ (make) -> Void in
                    self.originViewConstraint = make.bottom.equalTo(pictureView).offset(StatusTableViewCellMargin).constraint
                })
                
                
            } else {
                //  隐藏配图
                pictureView.isHidden = true
                self.snp.makeConstraints({ (make) -> Void in
                    self.originViewConstraint = make.bottom.equalTo(contentLabel).offset(StatusTableViewCellMargin).constraint
                })
            }
            
        }
    }
    
    //  MARK:   -懒加载控件
    //  头像
    private lazy var headImageView: UIImageView = {
        let headImage = UIImageView(image: UIImage(named: "avatar_default_big"))
        headImage.size = CGSize(width: 35, height: 35)
        return headImage
    }()
    //  认证类型等级图片
    private lazy var verifiedTypeImageView: UIImageView = UIImageView(image: UIImage(named: "avatar_vip"))
    //  昵称
    private lazy var screenNameLabel: UILabel = UILabel(fontSize: 15, textColor: UIColor.darkGray)
    
    //  会员等级
    private lazy var mbrankImageView: UIImageView = UIImageView(image: UIImage(named: "common_icon_membership"))
    
    //  时间
    private lazy var timeLabel: UILabel = UILabel(fontSize: 12, textColor: UIColor.orange)
    //  来源
    private lazy var sourceLabel: UILabel = UILabel(fontSize: 12, textColor: UIColor.lightGray)
    
    //  微博内容
    private lazy var contentLabel: UILabel = {
        let label = UILabel(fontSize: 14, textColor: UIColor.darkGray)
        
        //  多行显示
        label.numberOfLines = 0
        
        return label
        
    }()
    //  配图
    private lazy var pictureView: SUPStatusPictureView = {
        let view = SUPStatusPictureView()
        view.backgroundColor = self.backgroundColor
        return view
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //  添加控件设置约束
    private func setupUI() {
        //  添加控件
        addSubview(headImageView)
        addSubview(verifiedTypeImageView)
        addSubview(screenNameLabel)
        addSubview(mbrankImageView)
        addSubview(timeLabel)
        addSubview(sourceLabel)
        addSubview(contentLabel)
        addSubview(pictureView)
//        screenNameLabel.text = "小白"
        timeLabel.text = "刚刚"
//        sourceLabel.text = "Swift 4.0"
//        contentLabel.text = "愤怒的开发开放空间开发浪蝶狂蜂没看到付款,愤怒的开发开放空间开发浪蝶狂蜂没看到付款,愤怒的开发开放空间开发浪蝶狂蜂没看到付款"
        //  设置约束
        //  @noescape 表示闭包不能被其他属性持有, 在闭包里面可以省略self
        
        headImageView.snp.makeConstraints { (make) -> Void in
//            let height = m.height.equalTo(height).constraint
//            height.layoutConstraints.first?.priority = UILayoutPriorityDefaultLow
//            将你设置的约束的优先级降低
           let top = make.top.equalTo(self).offset(StatusTableViewCellMargin).constraint
            top.layoutConstraints.first?.priority = UILayoutPriority.defaultLow
            make.leading.equalTo(self).offset(StatusTableViewCellMargin)
            
//            make.size.equalTo(CGSize(width: 35, height: 35))
        }
        
        verifiedTypeImageView.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(headImageView.snp.trailing)
            make.centerY.equalTo(headImageView.snp.bottom)
        }
        
        screenNameLabel.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(headImageView.snp.trailing).offset(StatusTableViewCellMargin)
            make.top.equalTo(headImageView)
        }
        
        mbrankImageView.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(screenNameLabel.snp.trailing).offset(StatusTableViewCellMargin)
            make.top.equalTo(screenNameLabel)
        }
        
        timeLabel.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(screenNameLabel)
            make.bottom.equalTo(headImageView)
        }
        
        sourceLabel.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(headImageView)
            make.leading.equalTo(timeLabel.snp.trailing).offset(StatusTableViewCellMargin)
        }
        
        contentLabel.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(headImageView)
            make.top.equalTo(headImageView.snp.bottom).offset(StatusTableViewCellMargin)
            make.trailing.equalTo(self).offset(-StatusTableViewCellMargin)
        }
        pictureView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(contentLabel.snp.bottom).offset(StatusTableViewCellMargin)
            make.leading.equalTo(contentLabel)
        }
        
        
        //  关键约束  原创微博视图的底部约束 = 微博内容的底部约束 + 间距
        
//        self.snp.makeConstraints { (make) -> Void in
//            make.bottom.equalTo(contentLabel).offset(StatusTableViewCellMargin)
//        }
//
        self.snp.makeConstraints { (make) -> Void in
            self.originViewConstraint = make.bottom.equalTo(pictureView).offset(StatusTableViewCellMargin).constraint
        }
    }
    

}
