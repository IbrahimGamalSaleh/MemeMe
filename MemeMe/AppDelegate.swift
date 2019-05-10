//
//  AppDelegate.swift
//  MemeMe
//
//  Created by IbrahimGamal on 6/16/1440 AH.
//  Copyright © 1440 AH IbrahimGamal. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var memes = [Meme]()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

}

