//
//  AppDelegate.swift
//  SwiftProject
//
//  Created by NShunJian on 2018/6/29.
//  Copyright © 2018年 superMan. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
         //  注册监听的通知
         NotificationCenter.default.addObserver(self, selector: #selector(AppDelegate.switchRootVC), name: NSNotification.Name.init(rawValue: SwitchRootVCNotification), object: nil)
        
        //  测试解档
        let userAccount = SUPUserAccount.loadUserAccount()
        SUPLog(userAccount)
        
        
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let rootVC = SUPMainViewController()
        window?.rootViewController = rootVC
        window?.makeKeyAndVisible()
        return true
    }
    //  监听通知的方法
    @objc private func switchRootVC(noti: NSNotification) {
        
        let object = noti.object
        //  如果登陆页面进入欢迎页面
        if object is SUPOAuthViewController {
            window?.rootViewController = SUPWelComeViewController()
        } else {
            window?.rootViewController = SUPMainViewController()
        }
        
        
        
    }
    
    
    deinit {
         NotificationCenter.default.removeObserver(self)
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

func SUPLog<T>(_ message:T,file:String = #file,funcName:String = #function,lineNum:Int = #line){
     #if DEBUG
    //        // 1.获取打印所在的文件
    let filename = (file as NSString).lastPathComponent
    //
    //        // 2.获取打印所在的方法
    //        let funcName = funcName
    //
    //        // 3.获取打印所在行数
    //        let lineNum = lineNum
    //
        print("\(filename):[\(funcName)](\(lineNum))>>>>>>: \(message)")
    
    #endif
}
