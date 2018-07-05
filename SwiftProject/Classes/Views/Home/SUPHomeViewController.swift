//
//  SUPHomeViewController.swift
//  SwiftProject
//
//  Created by NShunJian on 2018/7/2.
//  Copyright © 2018年 superMan. All rights reserved.
//

import UIKit

class SUPHomeViewController: SUPVisitorViewControlle {

    override func viewDidLoad() {
        super.viewDidLoad()

        if isLogin {
            
        } else {
            
            visitorView?.updateVisitorViewInfo(message: nil, imageName: nil)
            
        }
    }

    

}
