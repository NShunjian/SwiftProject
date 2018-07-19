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
        view.backgroundColor = UIColor.init(patternImage: UIImage.init(named: "emoticon_keyboard_background")!)
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
        //  设置代理
        view.delegate = self as UICollectionViewDelegate
        return view
        
    }()
    
    //  页数指示器
    private lazy var pageControl: UIPageControl = {
        
        let pageCtr = UIPageControl()
        pageCtr.currentPageIndicatorTintColor = UIColor(patternImage: UIImage(named: "compose_keyboard_dot_selected")!)
        pageCtr.pageIndicatorTintColor = UIColor(patternImage: UIImage(named: "compose_keyboard_dot_normal")!)
        
        return pageCtr
        
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    //这个方法告诉外界不支持 xib/sb
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        
        backgroundColor = UIColor(patternImage: UIImage(named: "emoticon_keyboard_background")!)
        //  默认页数数据绑定
        let defaultIndexPath: NSIndexPath = NSIndexPath.init(item: 0, section: 0)
        //  设置数据
        setPageControlDataForIndexPath(indexPath: defaultIndexPath)
        
        addSubview(emoticonCollectionView)
        //  添加页数指示控件
        addSubview(pageControl)
        //  添加控件
        addSubview(toolBar)
        
        //  设置约束
        
        emoticonCollectionView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self)
            make.leading.equalTo(self)
            make.trailing.equalTo(self)
            make.bottom.equalTo(toolBar.snp.top)
        }
        
        pageControl.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(emoticonCollectionView)
            make.centerX.equalTo(emoticonCollectionView)
            make.height.equalTo(10)
        }
        
        toolBar.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(self)
            make.leading.equalTo(self)
            make.trailing.equalTo(self)
            make.height.equalTo(35)
        }
        
        toolBar.didSeletedButtonClosure = { [weak self] (type: SUPEmoticonToolBarButtonType) in
            //  滚动到的indexPath
            let indexPath: NSIndexPath
            switch type {
            case .Normal:
                SUPLog("默认")
                //表示第几组第几行(item)
                 indexPath = NSIndexPath(item: 0, section: 0)
            case .Emoji:
                SUPLog("emoji")
                indexPath = NSIndexPath(item: 0, section: 1)
            case .LXH:
                SUPLog("LXH")
                indexPath = NSIndexPath(item: 0, section: 2)

            }
            //  滚动到指定位置,不需要开启动画
            self?.emoticonCollectionView.scrollToItem(at: indexPath as IndexPath, at: UICollectionViewScrollPosition.left, animated: false)
            
            self?.setPageControlDataForIndexPath(indexPath: indexPath)
        }
        
    }
    //  通过indexPath绑定页数控件的数据
    private func setPageControlDataForIndexPath(indexPath: NSIndexPath) {
        pageControl.numberOfPages = SUPEmoticonTools.sharedTools.allEmoticonArray[indexPath.section].count
        pageControl.currentPage = indexPath.item
        
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


extension SUPEmoticonKeyBoard: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return SUPEmoticonTools.sharedTools.allEmoticonArray.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return SUPEmoticonTools.sharedTools.allEmoticonArray[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EmoticonCollectionViewCellIdentifier, for: indexPath) as! SUPEmoticonCollectionViewCell
        
//        cell.backgroundColor = RandomColor()
//        cell.indexPath = indexPath as NSIndexPath
        
        //  设置绑定数据
        cell.emoticons = SUPEmoticonTools.sharedTools.allEmoticonArray[indexPath.section][indexPath.item]
        
        
        return cell
    }
    //  监听collectionView的滚动
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //        print(scrollView.contentOffset.x)
        //  获取当前屏幕显示的cell, 获取的cell不会对其进行x坐标排序,随机返回的
        let cells = emoticonCollectionView.visibleCells.sorted { (firstCell, secondCell) -> Bool in
             return firstCell.x < secondCell.x
        }
//        SUPLog(cells.count)
//        let cells = emoticonCollectionView.visibleCells.sort { (firstCell, secondCell) -> Bool in
//
//        }
        //  判断哪个cell显示多
        if cells.count == 2 {
            //  获取第一个cell
            let firstCell = cells.first!
            //  获取第二个cell
            let secondCell = cells.last!


//                        print("第一个cell: \(firstCell)")
//                        print("第二个cell: \(secondCell)")
            //  通过差值的计算,判断哪个cell显示多
            //  第一个偏移量差值(只想关心偏移的差值多少)
            let firstContentOffSetX = abs(firstCell.x - scrollView.contentOffset.x)
            //  第二个偏移量差值
            let secondContentOffSetX = secondCell.x - scrollView.contentOffset.x
//                        print("第一个差值\(firstContentOffSetX)")
//                        print("第二个差值\(secondContentOffSetX)")
            //  记录哪个cell显示的多
            let cell: UICollectionViewCell
            if firstContentOffSetX < secondContentOffSetX {
//                                print("第一个cell显示多")
                cell = firstCell
            } else {
//                                print("第二个cell显示多")
                cell = secondCell
            }

            //  根据cell获取对应的indexPath
            let indexPath = emoticonCollectionView.indexPath(for: cell)!

            //  获取indexPath对应的是哪个一组
            let section = indexPath.section
            //  选中指定这组数据
            toolBar.selectedButtonWithSection(section: section)
            
            setPageControlDataForIndexPath(indexPath: indexPath as NSIndexPath)
        }
    }
}


