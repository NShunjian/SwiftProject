//
//  SUPEmoticonCollectionViewCell.swift
//  SwiftProject
//
//  Created by NShunJian on 2018/7/13.
//  Copyright © 2018年 superMan. All rights reserved.
//

import UIKit

class SUPEmoticonCollectionViewCell: UICollectionViewCell {
    var indexPath: NSIndexPath? {
        didSet {
            
            guard let index = indexPath else {
                return
            }
            
            
            messageLabel.text = "当前显示的是第\(index.section + 1)组第\(index.item + 1)页"
            
            
        }
    }
    
    //  MARK:   --懒加载控件
    private lazy var messageLabel: UILabel = {
        let label = UILabel(fontSize: 20, textColor: UIColor.black)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(messageLabel)
        
        messageLabel.snp.makeConstraints { (make) -> Void in
            make.center.equalTo(contentView)
        }
        
        
    }
    
}
