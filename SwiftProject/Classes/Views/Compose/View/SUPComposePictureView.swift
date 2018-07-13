//
//  SUPComposePictureView.swift
//  SwiftProject
//
//  Created by NShunJian on 2018/7/12.
//  Copyright © 2018年 superMan. All rights reserved.
//

import UIKit
//  重用标记
private let SUPComposePictureViewCellIdentifier = "CZComposePictureViewCellIdentifier"
//  发微博配图
class SUPComposePictureView: UICollectionView {

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
        //  注册cell
        register(UICollectionViewCell.self, forCellWithReuseIdentifier: SUPComposePictureViewCellIdentifier)
        //  设置数据源代理
        dataSource = self
        
    }
    
    //  添加图片方法
    func addImage(image: UIImage) {
        
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
extension SUPComposePictureView: UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        <#code#>
//    }
//
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SUPComposePictureViewCellIdentifier, for: indexPath)
        
        cell.backgroundColor = RandomColor()
        
        return cell
    }


}
