//
//  SUPEmoticonKeyBoard.swift
//  SwiftProject
//
//  Created by NShunJian on 2018/7/13.
//  Copyright © 2018年 superMan. All rights reserved.
//

import UIKit
//  重用标记
private let EmoticonCollectionViewCellIdentifier = "EmoticonCollectionViewCellIdentifier"

class SUPEmoticonKeyBoard: UIView {

   
    //  MARK: -- 懒加载控件
    private lazy var toolBar: SUPEmoticonToolBar = {
        let toolBar = SUPEmoticonToolBar(frame: CGRect.zero)
        return toolBar
    }()
    
    //  表情视图
    private lazy var emoticonCollectionView: UICollectionView = {
        
        let flowLayout = UICollectionViewFlowLayout()
        //  设置水平方向滚动
        flowLayout.scrollDirection = .horizontal
        
        
        let view = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        view.backgroundColor = RandomColor()
        //  设置水平和垂直方向的滚动指示器不显示
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = false
        //  开启分页
        view.isPagingEnabled = true
        //  不开启弹簧效果
        view.bounces = false
        
        //  注册cell
        view.register(SUPEmoticonCollectionViewCell.self, forCellWithReuseIdentifier: EmoticonCollectionViewCellIdentifier)
        //  数据源代理
        view.dataSource = self as UICollectionViewDataSource
        
        return view
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        
        backgroundColor = UIColor(patternImage: UIImage(named: "emoticon_keyboard_background")!)
        addSubview(emoticonCollectionView)
        //  添加控件
        addSubview(toolBar)
        
        //  设置约束
        
        emoticonCollectionView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self)
            make.leading.equalTo(self)
            make.trailing.equalTo(self)
            make.bottom.equalTo(toolBar.snp.top)
        }
        
        
        
        toolBar.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(self)
            make.leading.equalTo(self)
            make.trailing.equalTo(self)
            make.height.equalTo(35)
        }
        
        toolBar.didSeletedButtonClosure = { [weak self] (type: SUPEmoticonToolBarButtonType) in
            
            switch type {
            case .Normal:
                print("默认")
                print(self)
            case .Emoji:
                print("emoji")
            case .LXH:
                print("LXH")
                
                
            }
            
        }
        
    }
    
    //  设置子控件布局方式
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let flowLayout = emoticonCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        //  设置每项的大小
        flowLayout.itemSize = emoticonCollectionView.size
        //  设置水平间距和垂直间距
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 0
    }
    
    
    
}


extension SUPEmoticonKeyBoard: UICollectionViewDataSource {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EmoticonCollectionViewCellIdentifier, for: indexPath) as! SUPEmoticonCollectionViewCell
        
        cell.backgroundColor = RandomColor()
        cell.indexPath = indexPath as NSIndexPath
        return cell
    }
    
    
    
}


