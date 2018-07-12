//
//  SUPStatusRetweetView.swift
//  SwiftProject
//
//  Created by NShunJian on 2018/7/6.
//  Copyright © 2018年 superMan. All rights reserved.
//

import UIKit
import SnapKit
//  转发微博视图
class SUPStatusRetweetView: UIView {
    //  记录转发微博视图的底部约束
    var retweetViewBottomConstraint: Constraint?
    
    //  使用ViewModel绑定数据
    var statusViewModel: SUPStatusViewModel? {
        didSet {
            //  绑定转发微博内容
             contentLabel.text = statusViewModel?.retweetContent
            //  卸载上一次约束
            retweetViewBottomConstraint?.deactivate()
            //  判断配图是否存在并且是否大于0
            if let picUrls = statusViewModel?.status?.retweeted_status?.pic_urls, picUrls.count > 0 {
                //  显示配图
                pictureView.isHidden = false
                //  设置配图信息
                pictureView.picUrls = picUrls
                //  更新约束
                
                self.snp.makeConstraints({ (make) -> Void in
                    self.retweetViewBottomConstraint =  make.bottom.equalTo(pictureView).offset(StatusTableViewCellMargin).constraint
                })
                
                
            } else {
                //  隐藏配图
                pictureView.isHidden = true
                //  更新约束
                self.snp.makeConstraints({ (make) -> Void in
                    self.retweetViewBottomConstraint = make.bottom.equalTo(contentLabel).offset(StatusTableViewCellMargin).constraint
                })
            }
            
            
        }
    }
    
    //  MARK:   --懒加载控件
    private lazy var contentLabel: UILabel = {
        let label = UILabel(fontSize: 14, textColor: UIColor.gray)
        //  多行显示
        label.numberOfLines = 0
        return label
        
    }()
    
    //  配图视图
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
        backgroundColor = UIColor(white: 0.95, alpha: 1)
        //  添加控件
        addSubview(contentLabel)
        addSubview(pictureView)
        
        //  设置约束
        contentLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(StatusTableViewCellMargin)
            make.leading.equalTo(self).offset(StatusTableViewCellMargin)
            make.trailing.equalTo(self).offset(-StatusTableViewCellMargin)
        }
        pictureView.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(contentLabel)
            make.top.equalTo(contentLabel.snp.bottom).offset(StatusTableViewCellMargin)
            
        }
        
        
        //  关键约束 让其转发微博的视图底部约束 = 内容底部的约束 + 间距
        self.snp.makeConstraints { (make) -> Void in
            self.retweetViewBottomConstraint = make.bottom.equalTo(pictureView).offset(StatusTableViewCellMargin).constraint
        }
        
        
    }
    
    
    
}
