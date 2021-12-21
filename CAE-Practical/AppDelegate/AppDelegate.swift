//
//  AppDelegate.swift
//  CAE-Practical
//
//  Created by Nirzar Gandhi on 20/12/21.
//

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    //MARK: - Variable Declaration
    var window: UIWindow?
    var navhomeViewController : UINavigationController?
    
    //MARK: - AppDelegate Methods
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //IQKeyboard Integration
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = true
        
        //Copying Database to Document Directory
        Utility().copyFile(fileName: "RosterDuties.sqlite")
        
        //Set Root ViewController Integration
        Utility().setRootRosterDutiesVC()
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        UIPasteboard.general.items = [[String: Any]()]
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
    }
}

