//
//  AppDelegate.swift
//  vk-donations
//
//  Created by Александр on 11.09.2020.
//  Copyright © 2020 AlexBugatti. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
        
        let attributes = [NSAttributedString.Key.font: UIFont.getTTCommonsFont(type: .demibold, size: 21)]
        UINavigationBar.appearance().titleTextAttributes = attributes
        UINavigationBar.appearance().tintColor = Pallete.main
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
        
        for family in UIFont.familyNames {

            let sName: String = family as String
            print("family: \(sName)")
                    
            for name in UIFont.fontNames(forFamilyName: sName) {
                print("name: \(name as String)")
            }
        }
        
        return true
    }

}

