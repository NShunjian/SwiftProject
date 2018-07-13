//
//  SUPStatusTableViewCell.swift
//  SwiftProject
//
//  Created by NShunJian on 2018/7/6.
//  Copyright © 2018年 superMan. All rights reserved.
//

import UIKit
import SnapKit

//  子控件之间的间距
let StatusTableViewCellMargin: CGFloat = 10
//  自定义首页微博数据的cell
class SUPStatusTableViewCell: UITableViewCell {
    //  toolbar底部约束记录
    var toolBarTopConstraint: Constraint?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    //  处理微博数据的ViewModel
    var statusViewModel: SUPStatusViewModel? {
        
        didSet {
            //  设置数据
            originView.statusViewModel = statusViewModel
            toolBar.statusViewModel = statusViewModel
            SUPLog(statusViewModel?.status?.retweeted_status?.pic_urls as Any)
            //  卸载上一次约束
            toolBarTopConstraint?.deactivate()
            
            //  判断是否有转发微博对象
            if statusViewModel?.status?.retweeted_status != nil {
                //  有转发微博
                
                //  显示转发微博视图
                retweetView.isHidden = false
                
                //  更新约束
                toolBar.snp.makeConstraints({ (make) -> Void in
                    self.toolBarTopConstraint = make.top.equalTo(retweetView.snp.bottom).constraint
                })
                
                //  绑定转发微博数据
                retweetView.statusViewModel = statusViewModel
                
            } else {
                //  没有转发微博
                //  隐藏转发微博视图
                retweetView.isHidden = true
                //  更新约束
                
                toolBar.snp.makeConstraints({ (make) -> Void in
                    self.toolBarTopConstraint = make.top.equalTo(originView.snp.bottom).constraint
                })
            }
            
        }
    }
    
    
    //  MARK: --懒加载控件
    //  原创微博视图
    private lazy var originView: SUPStatusOriginView = {
        let view = SUPStatusOriginView()
//        view.backgroundColor = RandomColor()
         view.backgroundColor = UIColor.white
        return view
    }()
    //  转发微博的视图
    private lazy var retweetView: SUPStatusRetweetView = {
        let view = SUPStatusRetweetView()
        return view
    }()
    
    //  toolbar
    private lazy var toolBar: SUPStatusToolBar = {
        let bar = SUPStatusToolBar()
        bar.height = 35
        return bar
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //  添加控件,设置约束
    private func setupUI() {
        //  修改contentView的背景色
        contentView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        
        //  添加控件
        contentView.addSubview(originView)
        contentView.addSubview(retweetView)
        contentView.addSubview(toolBar)
//        contentView.translatesAutoresizingMaskIntoConstraints = false
        //  设置约束
        originView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(contentView).offset(8)
            make.leading.equalTo(contentView)
            make.trailing.equalTo(contentView)
            
        }
        retweetView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(originView.snp.bottom)
            make.leading.equalTo(originView)
            make.trailing.equalTo(originView)
        }
        toolBar.snp.makeConstraints { (make) -> Void in
            self.toolBarTopConstraint = make.top.equalTo(retweetView.snp.bottom).constraint
            
           let bottom =  make.bottom.equalTo(contentView).constraint
            bottom.layoutConstraints.first?.priority = UILayoutPriority.defaultLow//将你设置的约束的优先级降低
            make.leading.equalTo(contentView)
            make.trailing.equalTo(contentView)
//            make.height.equalTo(35)
        }
        //  非常关键的约束, contentView的底部约束 = toolbar底部约束 + 间距
        //  约束要建立完整
//        contentView.snp.makeConstraints { (make) -> Void in
//            make.bottom.equalTo(toolBar)
//            make.top.equalTo(self)
//            make.leading.equalTo(self)
//            make.trailing.equalTo(self)
//        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        //SUPLog(selected)
        
        
        // Configure the view for the selected state
    }

}
