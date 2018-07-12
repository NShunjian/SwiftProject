//
//  SUPStatusPictureView.swift
//  SwiftProject
//
//  Created by NShunJian on 2018/7/7.
//  Copyright © 2018年 superMan. All rights reserved.
//

import UIKit
import SDWebImage
import SnapKit
//  重用标记
private let StatusPictureViewCellIdentifier = "StatusPictureViewCellIdentifier"
//  每项之间间距
private let itemMargin: CGFloat = 5
//  每项的宽度
private let itemWidth = (ScreenWidth - 2 * StatusTableViewCellMargin - 2 * itemMargin) / 3

//  微博配图视图
class SUPStatusPictureView: UICollectionView {
     var cons : Constraint?
    //  显示配图的数据源
    var picUrls: [SUPStatusPictureInfo]? {
        didSet {
            messageLabel.text = "\(picUrls?.count ?? 0)"
            SUPLog(picUrls![0].thumbnail_pic)
            cons?.deactivate()
            //  根据配图的个数计算大小
            let size = calcSizeWithCount(count: picUrls?.count ?? 0)
            //  更新约束
            self.snp.makeConstraints { (make) -> Void in
              self.cons =  make.size.equalTo(size).constraint

            }
            //  绑定数据
            self.reloadData()
        }
    }
    
    //  显示配图个数
    private lazy var messageLabel: UILabel = UILabel(fontSize: 20, textColor: UIColor.white)
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        let flowLayout = UICollectionViewFlowLayout()
        //  设置大小
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        //  水平间距
        flowLayout.minimumInteritemSpacing = itemMargin
        //  垂直间距
        flowLayout.minimumLineSpacing = itemMargin
        
        super.init(frame: frame, collectionViewLayout: flowLayout)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //  添加控件设置约束
    private func setupUI() {
        
        //  注册cell
        register(SUPStatusPictureViewCell.self, forCellWithReuseIdentifier: StatusPictureViewCellIdentifier)
        //  设置数据代理
        dataSource = self
        
        addSubview(messageLabel)
        
        messageLabel.snp.makeConstraints { (make) -> Void in
            make.center.equalTo(self)
        }
        
    }
    
    //  通过配图的个数计算配图的大小
    private func calcSizeWithCount(count: Int) -> CGSize {
        
        
        //  列数怎么计算
        //  列数
        let cols = count > 3 ? 3 : count
        //  行数  例:count为3, 3-1 = 2, 2/3 = 0, 0+1=1 表示在第一行,以此类推
        let rows = (count - 1) / 3 + 1
        
        
        //  计算配图的大小
        //  宽度
        let currentWidth = itemWidth * CGFloat(cols) + CGFloat(cols - 1) * itemMargin
        //  高度
        let currentHeight = itemWidth * CGFloat(rows) + CGFloat(rows - 1) * itemMargin
        
        
        return CGSize(width: currentWidth, height: currentHeight)
        
    }
    
    
}

//  MARK:   - 实现UICollectionViewDataSource的协议
extension SUPStatusPictureView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return picUrls?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StatusPictureViewCellIdentifier, for: indexPath as IndexPath) as! SUPStatusPictureViewCell
        //  设置模型数据
        
        cell.picInfo = picUrls![indexPath.item]
        
        return cell
    }
}
//  自定义配图cell
class SUPStatusPictureViewCell: UICollectionViewCell {
    
    //  绑定数据
    var picInfo: SUPStatusPictureInfo? {
        didSet {
            if let url = picInfo?.thumbnail_pic {
                imageView.sd_setImage(with: NSURL(string: url)! as URL, placeholderImage: UIImage(named: "timeline_image_placeholder"))
                
                //                if url.hasSuffix(".gif") {
                //                    gifImageView.hidden = false
                //                } else {
                //                    gifImageView.hidden = true
                //                }
                
                //  判断gif图片是否显示
                gifImageView.isHidden = !url.hasSuffix(".gif")
                
                
                
            }
        }
    }
    
    //  MARK:   --懒加载控件
    private lazy var imageView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "timeline_image_placeholder"))
        //  修改显示模型为等比填充,保证图片比例不变
        view.contentMode = UIViewContentMode.scaleAspectFill
        //  多余图片剪切掉
        view.clipsToBounds = true
        return view
        
    }()
    //  gif图片视图
    private lazy var gifImageView: UIImageView = UIImageView(image: UIImage(named: "timeline_image_gif"))
    
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
        contentView.addSubview(imageView)
        contentView.addSubview(gifImageView)
        //  设置约束
        imageView.snp.makeConstraints { (make) -> Void in

        make.edges.equalTo(contentView).inset(UIEdgeInsets.zero)
//            make.edges.equalTo(contentView)
//            make.edges.equalTo(contentView).offset(UIEdgeInsetsMake(0, 0, 0, 0) as! ConstraintOffsetTarget)
            
            make.edges.equalTo(contentView).inset(UIEdgeInsetsMake(0,0,0,0))
        }
        gifImageView.snp.makeConstraints { (make) -> Void in
            make.trailing.equalTo(imageView)
            make.bottom.equalTo(imageView)
        }
    }
    

}
