//
//  UIImage+Extension.swift
//  SwiftProject
//
//  Created by NShunJian on 2018/7/13.
//  Copyright © 2018年 superMan. All rights reserved.
//

import UIKit
extension UIImage {
    
    //  等比压缩图片
    //  根据指定压缩宽度,生成等比压缩后的图片
    func scaleImageWithScaleWidth(scaleWidth: CGFloat) -> UIImage {
        //  原始的宽度 100 , 高亮 200 , 压缩后的宽度50 高度 100
        //  计算等比压缩后的高度
        let scaleHeight = scaleWidth / self.size.width * self.size.height
        
        let size = CGSize(width: scaleWidth, height: scaleHeight)
        //  开启图片上下文
        UIGraphicsBeginImageContext(size)
        
        //  图片绘制到指定区域内
        self.draw(in: CGRect(origin: CGPoint.zero, size: size))
        //  通过上下文获取压缩后的图片
        let scaleImage = UIGraphicsGetImageFromCurrentImageContext()
        
        //  关闭图片上下文
        UIGraphicsEndImageContext()
        
        return scaleImage!
        
    }
    
}
