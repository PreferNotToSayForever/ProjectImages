//
//  AppDelegate.swift
//  ProjectImage
//
//  Created by Quang Le Nguyen on 29/8/18.
//  Copyright © 2018 Quang Le Nguyen. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    
 lazy var coreDataStack = CoreDataStack(modelName: "ChainageConversion")

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        guard let navigationController = window?.rootViewController as? UINavigationController, let vc = navigationController.topViewController as? ViewController else { return true }
        
            vc.coreDataStack = coreDataStack
    
     
    
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        coreDataStack.saveContext()
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        coreDataStack.saveContext()
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        coreDataStack.saveContext()
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        coreDataStack.saveContext()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        coreDataStack.saveContext()
    }
    
    func loadDataFirstTime(){
       let defaults = UserDefaults.standard
       var chainage = Chainage(
        
        
       
    }


}

