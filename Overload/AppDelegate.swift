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
import DynamicColor
import Then

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UIGestureRecognizerDelegate {

    var window: UIWindow?

    let navigation = UINavigationController(rootViewController: WorldTableViewController())

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        navigation.navigationBar.barTintColor = UIColor(hex: 0xF9F9F9)
        navigation.navigationBar.isTranslucent = false
        navigation.navigationBar.tintColor = UIColor.black
        navigation.interactivePopGestureRecognizer?.delegate = self


        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        window?.rootViewController = navigation
        window?.makeKeyAndVisible()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) { }
    func applicationDidEnterBackground(_ application: UIApplication) { }
    func applicationWillEnterForeground(_ application: UIApplication) { }
    func applicationDidBecomeActive(_ application: UIApplication) { }
    func applicationWillTerminate(_ application: UIApplication) { }

    // MARK: - UIGestureRecognizerDelegate

    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return navigation.viewControllers.count > 1
    }
}

