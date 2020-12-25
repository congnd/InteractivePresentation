//
//  AppDelegate.swift
//  CustomPresentation
//
//  Created by Nguyen, Cong on 2020/12/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    let window = UIWindow()
    window.rootViewController = ViewController()
    window.makeKeyAndVisible()
    self.window = window

    UIWindow.swiizzle()

    return true
  }
}

