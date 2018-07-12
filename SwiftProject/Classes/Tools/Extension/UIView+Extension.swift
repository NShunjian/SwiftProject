//
//  UIView+Extension.swift
//  Weibo30
//
//  Created by apple on 16/8/8.
//  Copyright © 2016年 itcast. All rights reserved.
//

import UIKit

extension UIView {
    //  不能提供存储属性
    
    //  x坐标
    var x: CGFloat {
        get {
            return frame.origin.x
        } set {
            frame.origin.x = newValue
        }
    }
    
    //  y坐标
    var y: CGFloat {
        get {
            return frame.origin.y
        } set {
            frame.origin.y = newValue
        }
    }
    
    //  宽度
    
    var width: CGFloat {
    
        get {
            return frame.size.width
        } set {
        
            frame.size.width = newValue
        }
    }
    
    //  高度
    
    var height: CGFloat {
        
        get {
            return frame.size.height
        } set {
            
            frame.size.height = newValue
        }
    }
    
    
    //  size
    var size: CGSize {
        get {
            return frame.size
        } set {
            frame.size = newValue
        }
    
    }
    
    //  中心x
    var centerX: CGFloat {
        get {
            return center.x
        } set {
            center.x = newValue
        }
    }
    
    //  中心y
    var centerY: CGFloat {
        get {
            return center.y
        } set {
            center.y = newValue
        }
    }
    

}

