//
//  AppDelegate.swift
//  Overload
//
//  Created by Draveness on 11/10/16.
//  Copyright © 2016 Draveness. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage
import SnapKit
import MBProgressHUD
import SVPullToRefresh

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        window?.rootViewController = WebViewController(url: "http://baidu.com")
        window?.makeKeyAndVisible()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) { }
    func applicationDidEnterBackground(_ application: UIApplication) { }
    func applicationWillEnterForeground(_ application: UIApplication) { }
    func applicationDidBecomeActive(_ application: UIApplication) { }
    func applicationWillTerminate(_ application: UIApplication) { }
}

