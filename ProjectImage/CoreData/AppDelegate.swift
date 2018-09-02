//
//  AppDelegate.swift
//  Maliban Milk Product
//
//  Created by Quang Le Nguyen on 22/8/18.
//  Copyright © 2018 Quang Le Nguyen. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    lazy var coreDataStack = CoreDataStack(modelName: "Model")

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        guard let nv = window?.rootViewController as? UINavigationController, let vc = nv.topViewController as? ViewController else { return true }
        vc.coreDataStack = coreDataStack
        loadDataifNeed()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
        coreDataStack.saveContext()
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        coreDataStack.saveContext()
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
           coreDataStack.saveContext()
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
           coreDataStack.saveContext()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
           coreDataStack.saveContext()
    }
    
    func loadDataifNeed(){
        if ifNeeded() {
            loadData()
        }
    }
    
    func ifNeeded()->Bool{
        let fectchRequest: NSFetchRequest<Sale> = Sale.fetchRequest()
        let count = try! coreDataStack.managedContext.count(for: fectchRequest)
        return count == 0
    }
    
    func loadData(){
        guard let filePath = Bundle.main.path(forResource: "Changed Activities", ofType: "csv") else { return }
     
        do {
            let contents = try String(contentsOfFile: filePath)
            let contentArray = contents.components(separatedBy: "\n").dropLast()
            for content in contentArray {
                let sale = Sale(context: coreDataStack.managedContext)
                let product = Product(context: coreDataStack.managedContext)
                let singleData = content.components(separatedBy: ",")
                sale.nameOfAgent = singleData[0]
                sale.agentCode = singleData[1]
                sale.modeOfSettlement = singleData[2]
                sale.dateOfOrder = NSDate()
                let products = singleData[4]
                let produc = products.components(separatedBy: ";")
                    product.product = produc[0]
                    product.weight = produc[1]
                    product.quantity = (produc[2] as NSString).doubleValue
                    product.unitPrice = (produc[3] as NSString).doubleValue
                sale.addToProducts(product)
                coreDataStack.saveContext()
                print("Data saved")
            }
        } catch let error as NSError {
            print(error.userInfo)
        }
        
        
    }

}

