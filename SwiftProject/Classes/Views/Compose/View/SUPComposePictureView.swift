//
//  SUPComposePictureView.swift
//  SwiftProject
//
//  Created by NShunJian on 2018/7/12.
//  Copyright © 2018年 superMan. All rights reserved.
//

import UIKit
//  重用标记
private let SUPComposePictureViewCellIdentifier = "SUPComposePictureViewCellIdentifier"
//  发微博配图
class SUPComposePictureView: UICollectionView {
    //  点击加号按钮执行的闭包
    var didSeletedAddImageViewClosure: (()->())?
    //  图片数据源
    lazy var images: [UIImage] = [UIImage]()
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        
        let flowLayout = UICollectionViewFlowLayout()
        
        super.init(frame: frame, collectionViewLayout: flowLayout)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = RandomColor()
        //  默认状态当前配图隐藏
        isHidden = true
        //  注册cell
        register(SUPComposePictureViewCell.self, forCellWithReuseIdentifier: SUPComposePictureViewCellIdentifier)
        //  设置数据源代理
        dataSource = self
        //  设置代理
        delegate = self
    }
    
    //  添加图片方法
    func addImage(image: UIImage) {
        //  最多显示9张图片
        if images.count >= 9 {
            return
        }
        
        //  显示配图
        isHidden = false
        //  添加图片
        images.append(image)
        
        //  重写加载数据
        self.reloadData()
        
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //  设置每项的间距
        let itemMargin: CGFloat = 5
        //  计算每项的大小
        let itemWidth = (width - 2 * itemMargin) / 3
        //  获取布局方式
        let flowLayout = self.collectionViewLayout as! UICollectionViewFlowLayout
        
        //  设置大小
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        //  设置水平间距
        flowLayout.minimumInteritemSpacing = itemMargin
        //  设置垂直间距
        flowLayout.minimumLineSpacing = itemMargin
        
    }
}

//  MARK:   - UICollectionViewDataSource实现数据源代理方法
extension SUPComposePictureView: UICollectionViewDataSource, UICollectionViewDelegate {

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //  如果是0张或者9张图片,那么不需要多显示一个单元格
        if images.count == 0 || images.count == 9 {
            return images.count
        } else {
            //  否则要多显示一个加号的cell
            return images.count + 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SUPComposePictureViewCellIdentifier, for: indexPath) as! SUPComposePictureViewCell
        //  indexPath.item索引等于数组的个数表示最后一个cell
        if indexPath.item == images.count {
            cell.image = nil
        } else {
            //  绑定图片
            cell.image = images[indexPath.item]
            
            //  设置删除图片闭包
            cell.deleteButtonClosure = { [weak self] in
                
                //  通过数据源删除指定图片
                self?.images.remove(at: indexPath.item)
                
                //  判断数据源是否为0
                if self?.images.count == 0 {
                    //  隐藏当前配图
                    self?.isHidden = true
                }
                
                self?.reloadData()
                
            }
            
        }
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //  如果索引等于我们数组的个数表示最后一个cell
        if indexPath.item == images.count {
            //  取消选中
            collectionView.deselectItem(at: indexPath as IndexPath, animated: true)
            //  执行闭包
            didSeletedAddImageViewClosure?()
            
        }
        
        
    }

}

//  自定义发微博图片cell

class SUPComposePictureViewCell: UICollectionViewCell {
    //  点击删除按钮执行的闭包
    var deleteButtonClosure: (()->())?
    
    var image: UIImage? {
        didSet {
            if image == nil {
                //  添加加号按钮图片
                imageView.image = UIImage(named: "compose_pic_add")
                //  添加高亮图片
                imageView.highlightedImage = UIImage(named: "compose_pic_add_highlighted")
                //  如果是设置加号图片那么隐藏删除按钮
                deleteButton.isHidden = true
            } else {
                //  设置绑定的图片
                imageView.image = image
                //  显示删除按钮
                deleteButton.isHidden = false
                //  删除高亮图片
                imageView.highlightedImage = nil
            }
            
            
        }
    }
    
    
    //  MARK: --懒加载控件
    //  显示图片
    private lazy var imageView: UIImageView = UIImageView()
    
    //  删除按钮
    private lazy var deleteButton: UIButton = {
        let button = UIButton()
        //  添加点击事件
        button.addTarget(self, action: #selector(SUPComposePictureViewCell.deleteButtonAction), for: .touchUpInside)
        button.setImage(UIImage(named: "compose_photo_close"), for: .normal)
        return button
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
        contentView.addSubview(imageView)
        contentView.addSubview(deleteButton)
        imageView.snp.makeConstraints { (make) -> Void in
            make.edges.equalTo(contentView).inset(UIEdgeInsets.zero)
        }
        deleteButton.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(imageView)
            make.trailing.equalTo(imageView)
        }
        
    }
    
    //  MARK: --监听点击事件
    @objc private func deleteButtonAction() {
        
        print("哈哈")
        //  执行删除图片的闭包
        deleteButtonClosure?()
    }
    
    
}

