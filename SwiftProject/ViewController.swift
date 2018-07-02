//
//  ViewController.swift
//  SwiftProject
//
//  Created by NShunJian on 2018/6/29.
//  Copyright © 2018年 superMan. All rights reserved.
//

import UIKit
// MARK:- <#注释>
class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SUPLog(message: "jkdjfkdjfkdjfkdjfkdj")
        
        SUPLog(message: "jkdjfkdjfkdjfkdjfkdj")
        
        
        let str = "hello"
        
        
        let result = (str as NSString).substring(with: NSMakeRange(1, str.characters.count - 2))
        print(result)
        
        
    }
 
    

}

