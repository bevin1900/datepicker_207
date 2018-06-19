//
//  AppDelegate.swift
//  Picker
//
//  Created by MAC193 on 6/19/18.
//  Copyright © 2018 MAC193. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
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
class WeekOpenClose: NSObject{
    var dayName     : String;
    var openTime    : String;
    var closeTime   : String;
    var isClosed    : Bool;
    
    init(dayName : String, openTime : String, closedTime : String, isClosed : Bool) {
        self.dayName    =   dayName;
        self.openTime   =   openTime;
        self.closeTime  =   closedTime;
        self.isClosed   =   isClosed;
    }
}
extension UIView{
    func dropShadowForCell(shadowRadius : CGFloat) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.15
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowOffset = CGSize(width: 0, height:2)
    }
}
extension Date{
    //------------------------------------------------------------------------------------------------------
    private static var formatterhhmma : DateFormatter?;
    static func appFormaterStandard()->DateFormatter{
        if formatterhhmma == nil {
            formatterhhmma = DateFormatter();
            formatterhhmma?.dateFormat = "h:mm a"
            formatterhhmma?.amSymbol = "am"
            formatterhhmma?.pmSymbol = "pm"
            formatterhhmma?.locale = Locale(identifier: "en_US_POSIX")
        }
        return formatterhhmma!;
    }
    //------------------------------------------------------------------------------------------------------
    func roundOFDate()->Date{
        var components      =   Calendar.current.dateComponents([.year,.month,.day,.hour,.minute], from: self)
        if components.minute! > 0 && components.minute! <= 15{
            components.minute = 15
        }
        else if components.minute! > 15 && components.minute! <= 30{
            components.minute = 30
        }
        else if components.minute! > 30 && components.minute! <= 45{
            components.minute = 45
        }
        else if components.minute! > 45 && components.minute! <= 59 {
            components.minute = 00
            components.hour   = components.hour! + 1;
        }
        return Calendar.current.date(from: components)!;
    }
    //------------------------------------------------------------------------------------------------------
    func dayOfWeek(date : Date) -> String? {
        if self.dayFromDate() == date.dayFromDate(){
            return "Today"
        }
        else{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEEE"
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            return dateFormatter.string(from: self)
        }
    }
    //------------------------------------------------------------------------------------------------------
    func dayFromDate() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        return dateFormatter.string(from: self).capitalized
    }
    //------------------------------------------------------------------------------------------------------
}
extension UIColor{
    class func disableButtonColor()->UIColor{
        return UIColor.init(red: 51.0/255.0, green: 63.0/255.0, blue: 72.0/255.0, alpha: 0.5);
    }
    class func searchhBarBorderColor()->UIColor{
        return UIColor.init(red: 51.0/255.0, green: 63.0/255.0, blue: 72.0/255.0, alpha: 0.1)
    }
    class func appGreenColor()->UIColor{
        return UIColor.init(red: 0.0/255.0, green: 179.0/255.0, blue: 152.0/255.0, alpha: 1.0);
    }
    class func appErrorColor()->UIColor{
        return UIColor.init(red: 233.0/255.0, green: 101.0/255.0, blue: 101.0/255.0, alpha: 1.0);
    }
    class func appStarYellowColor()->UIColor{
        return UIColor.init(red: 247.0/255.0, green: 209.0/255.0, blue: 102.0/255.0, alpha: 1.0);
    }
    class func appFilterBlueColor()->UIColor{
        return UIColor.init(red: 13.0/255.0, green: 27.0/255.0, blue: 112.0/255.0, alpha: 1.0);
    }
    class func appCloseRedColor()->UIColor{
        return UIColor.init(red: 252.0/255.0, green: 28.0/255.0, blue: 76.0/255.0, alpha: 1.0);
    }
    class func appBlackColor373737()->UIColor{
        return UIColor.init(red: 37.0/255.0, green: 37.0/255.0, blue: 37.0/255.0, alpha: 1.0);
    }
    class func appBlackColor252525() -> UIColor {
        return UIColor.init(red: 25.0/255.0, green: 25.0/255.0, blue: 25.0/255.0, alpha: 1.0);
    }
    class func appSegmentColor140140140()->UIColor{
        return UIColor.init(red: 140.0/255.0, green: 140.0/255.0, blue: 140.0/255.0, alpha: 1.0)
    }
    class func appBorderGrayColor718088()->UIColor {
        return UIColor(red: 71.0/255.0, green: 80.0/255.0, blue: 88.0/255.0, alpha: 0.20)
    }
}
