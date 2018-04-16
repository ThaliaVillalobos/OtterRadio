//
//  AppDelegate.swift
//  OtterRadio
//
//  Created by Thalia  on 3/23/18.
//  Copyright © 2018 Thalia . All rights reserved.
//

import UIKit
import Parse
import GoogleSignIn

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
        GIDSignIn.sharedInstance().clientID = "936707679375-4c4kp9babhhfvmhisasqs8i6g189e6la.apps.googleusercontent.com"
        
        Parse.initialize(
            with: ParseClientConfiguration(block: { (configuration: ParseMutableClientConfiguration) -> Void in
                configuration.applicationId = "csumbradio"
                configuration.clientKey = "3098ruijfmsdoif0999e9ru"  // set to nil assuming you have not set clientKey
                configuration.server = "https://otterradio.herokuapp.com/parse"
            })
        )
        
        // check if user is logged in.
        if PFUser.current() != nil {
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            // view controller currently being set in Storyboard as default will be overridden
            if PFUser.current()?.value(forKey: "type") as! String == "admin" {
                window?.rootViewController = storyboard.instantiateViewController(withIdentifier: "adminPage")
            } else if PFUser.current()?.value(forKey: "type") as! String == "host" {
                window?.rootViewController = storyboard.instantiateViewController(withIdentifier: "hostPage")
            }else {
                window?.rootViewController = storyboard.instantiateViewController(withIdentifier: "homePage")
            }
        }
        
        
        //Called when the user is login out
        NotificationCenter.default.addObserver(forName: Notification.Name("didLogout"), object: nil, queue: OperationQueue.main) { (Notification) in
            print("Logout notification received")
            self.logOut()
        }
        return true
    }
    
    func logOut() {
        // Logout the current user
        PFUser.logOutInBackground(block: { (error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("Successful loggout")
                // Load and show the login view controller
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let loginViewController = storyboard.instantiateViewController(withIdentifier: "loginView")
                self.window?.rootViewController = loginViewController
            }
        })
    }
    
    // Google Calendar Methods
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        
        return GIDSignIn.sharedInstance().handle(url, sourceApplication: sourceApplication, annotation: annotation)
    }
    
    @available(iOS 9.0, *)
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any]) -> Bool {
        
        let sourceApplication = options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String
        let annotation = options[UIApplicationOpenURLOptionsKey.annotation]
        return GIDSignIn.sharedInstance().handle(url, sourceApplication: sourceApplication, annotation: annotation)
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

