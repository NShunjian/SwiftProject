//
//  SUPStatusToolBar.swift
//  SwiftProject
//
//  Created by NShunJian on 2018/7/6.
//  Copyright © 2018年 superMan. All rights reserved.
//

import UIKit
//  微博toolbar
class SUPStatusToolBar: UIView {

    //  转发按钮
    var retweetButton: UIButton?
    //  评论按钮
    var commentButton: UIButton?
    //  赞按钮
    var unlikeButton: UIButton?
    
    var statusViewModel: SUPStatusViewModel? {
        didSet {
            
            //            let retweetCount = statusViewModel?.status?.reposts_count ?? 0
            //            let commentCount = statusViewModel?.status?.comments_count ?? 0
            //            let unlikeCount = statusViewModel?.status?.attitudes_count ?? 0
            //
            //            retweetButton?.setTitle("\(retweetCount)", forState: .Normal)
            //            commentButton?.setTitle("\(commentCount)", forState: .Normal)
            //            unlikeButton?.setTitle("\(unlikeCount)", forState: .Normal)
            
            
            retweetButton?.setTitle(statusViewModel?.retweetCountContent, for: .normal)
            commentButton?.setTitle(statusViewModel?.commentCountContent, for: .normal)
            unlikeButton?.setTitle(statusViewModel?.unlikeCountContent, for: .normal)
            
            
            
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //  添加控件设置约束
    private func setupUI() {
        
        //  添加按钮
        retweetButton = addChildButton(imageName: "timeline_icon_retweet", title: "转发")
        commentButton = addChildButton(imageName: "timeline_icon_comment", title: "评论")
        unlikeButton = addChildButton(imageName: "timeline_icon_unlike", title: "赞")
        //  添加竖线
        let firstLineView = addChildLineView()
        let secondLineView = addChildLineView()
        
        retweetButton!.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(self)
            make.top.equalTo(self)
            make.bottom.equalTo(self)
            make.width.equalTo(commentButton!)
        }
        
        commentButton!.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(retweetButton!.snp.trailing)
            make.top.equalTo(self)
            make.bottom.equalTo(self)
            make.width.equalTo(unlikeButton!)
        }
        
        unlikeButton!.snp.makeConstraints { (make) -> Void in
            make.trailing.equalTo(self)
            make.top.equalTo(self)
            make.bottom.equalTo(self)
            make.leading.equalTo(commentButton!.snp.trailing)
        }
        
        firstLineView.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(retweetButton!.snp.trailing)
            make.centerY.equalTo(self)
        }
        secondLineView.snp.makeConstraints { (make) -> Void in
            make.centerY.equalTo(self)
            make.centerX.equalTo(commentButton!.snp.trailing)
        }
        
    }
    //  添加子按钮的通用方法
    private func addChildButton(imageName: String, title: String) -> UIButton {
        let button = UIButton()
        //  设置图片
        button.setImage(UIImage(named: imageName), for: .normal)
        //  设置背景图片
        button.setBackgroundImage(UIImage(named: "timeline_card_bottom_background"), for: .normal)
        //  设置文字与颜色
        button.setTitle(title, for: .normal)
        button.setTitleColor(UIColor.darkGray, for: .normal)
        
        //  设置字体
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        
        addSubview(button)
        
        return button
    }
    
    //  添加子竖线的通用方法
    private func addChildLineView() -> UIImageView {
        let imageView = UIImageView(image: UIImage(named: "timeline_card_bottom_line"))
        addSubview(imageView)
        return imageView
    }
    
    
}
