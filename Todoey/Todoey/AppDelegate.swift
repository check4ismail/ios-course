//
//  AppDelegate.swift
//  Todoey
//
//  Created by Ismail Elmaliki on 8/22/19.
//  Copyright © 2019 Ismail Elmaliki. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?


	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		
//		print(Realm.Configuration.defaultConfiguration.fileURL)
		do {
			_ = try Realm()
		} catch {
			print("Error intializing new realm, \(error)")
		}
		
		return true
	}
}

