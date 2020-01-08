//
//  AppDelegate.swift
//  SwifUITest
//
//  Created by Tomas Green on 2019-10-08.
//  Copyright © 2019 Evry AB. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        UITableView.appearance().separatorColor = .clear
        UITableView.appearance().separatorStyle = .none
        //UITableView.appearance().backgroundColor = .systemGroupedBackground
//        OpenGraph.fetch(url: URL(string: "https://www.svt.se/nyheter/utrikes/turkiets-offensiv-i-syrien-fortsatter")!) { result in
//            switch result {
//            case .success(let og):
//                print(og[.title]) // => og:title of the web site
//                print(og[.type])  // => og:type of the web site
//                print(og[.image]) // => og:image of the web site
//                print(og[.url])   // => og:url of the web site
//            case .failure(let error):
//                print(error)
//            }
//        }
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

