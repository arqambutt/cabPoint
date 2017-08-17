




import UIKit
import SDWebImage
import GoogleMaps
import GooglePlaces
import Firebase
import FirebaseMessaging
import UserNotifications
import NotificationCenter



@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate ,UNUserNotificationCenterDelegate, MessagingDelegate

{
    
    var window: UIWindow?
    let object = Signin()
     let gcmMessageIDKey = "gcm.message_id"
  
    
    let reachability = Reachability()!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        
        
        GMSServices.provideAPIKey("AIzaSyBGUYwBUwXu6rLrS3T4BRvjSqBXKGoHkI0")
        GMSPlacesClient.provideAPIKey("AIzaSyBv_lNOo0xHiY0RAMJuHF5IDdlYKv96OKU")
        
       Messaging.messaging().delegate = self
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        application.registerForRemoteNotifications()
        
 
        UIApplication.shared.setMinimumBackgroundFetchInterval(UIApplicationBackgroundFetchIntervalMinimum)
        Authantication()
        
        PreInstallEnviiornmentForPaypal()
        FirebaseApp.configure()
        
        
        
        if let token = Messaging.messaging().fcmToken {
            
            
            SendFcmToken.object.SendFcmTokenFun(token: "\(token)") { (RES) in
                
            }
            
        }
        
        
      
      
        
        NotificationCenter.default.addObserver(self, selector: #selector(refresh), name: NSNotification.Name.InstanceIDTokenRefresh, object: nil)
    
        

        return true
    }
    
    func refresh(notification: NSNotification){
        
        print("Token refresh")
        
    }
  
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        // If you are receiving a notification message while your app is in the background,
        // this callback will not be fired till the user taps on the notification launching the application.
        // TODO: Handle data of notification
        
        // With swizzling disabled you must let Messaging know about the message, for Analytics
         Messaging.messaging().appDidReceiveMessage(userInfo)
        
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        
        // Print full message.
        print(userInfo)
    }
    
  

    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo as! [String: Any]
        
        print(userInfo)
        
        completionHandler([.alert, .badge, .sound])
        
    }
    
    
  
    
    // Receive data message on iOS 10 devices.
    @objc(applicationReceivedRemoteMessage:)
    func application(received remoteMessage: MessagingRemoteMessage) {
        print("%@", remoteMessage.appData)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
   
    
    func messaging(_ messaging: Messaging, didRefreshRegistrationToken fcmToken: String) {
        print("Firebase registration token: \(fcmToken)")
    }
    
    
    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
        
        
        print(remoteMessage)
        
        
    }
    
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        print(deviceToken)
        Messaging.messaging().apnsToken = deviceToken
        
        
    }
    
   
    
    
    
    func PreInstallEnviiornmentForPaypal(){
        
        PayPalMobile.initializeWithClientIds(forEnvironments: [PayPalEnvironmentProduction:  "cabigate@nhzglobal.com.uk",
                                                               PayPalEnvironmentSandbox: "ATRb25Q4OGYjWQwj-8BEuit084UnDVnUFEPkI56xC72RtbhY8xfMZZtMgunS8cohfvJfAbujD2yV_85W"])
        
        contectUs.object.contectUsFun { (res) in
            
            if(res == ""){
                print(contectUsModal.object.paypal_email)
                PayPalMobile.initializeWithClientIds(forEnvironments: [PayPalEnvironmentProduction:  "cabigate@nhzglobal.com.uk",
                                                                       PayPalEnvironmentSandbox: "ATRb25Q4OGYjWQwj-8BEuit084UnDVnUFEPkI56xC72RtbhY8xfMZZtMgunS8cohfvJfAbujD2yV_85W"])
            }
            
        }
        
        
        
    }
    

 
    func makeSegue(Name:String)->UIViewController {
        
        let storyBord = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyBord.instantiateViewController(withIdentifier: "\(Name)")
        return controller
        
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
    
    
    func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        
        print("im running")
        
    }
    
    
    func registerForPushNotifications() {
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) {
                (granted, error) in
                print("Permission granted: \(granted)")
                guard granted else { return }
                self.getNotificationSettings()
            }
        } else {
            // Fallback on earlier versions
        }
    }
    
    func getNotificationSettings() {
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().getNotificationSettings { (settings) in
                print("Notification settings: \(settings)")
                
                guard settings.authorizationStatus == .authorized else { return }
                UIApplication.shared.registerForRemoteNotifications()
            }
        } else {
            // Fallback on earlier versions
        }
    }
    
    
    

    
     func application(application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken as Data
    }
    
    
    func Authantication() {
        
        let result = UserDefaults.standard.value(forKey: "token")
        let UID = UserDefaults.standard.value(forKey: "UID")
        
        if(result != nil){
            
            
            
            if(String(describing: result!) != "" ){
                
                userDetail.object.token = String(describing: result!)
                userDetail.object.userid = String(describing: UID!)
                
                let result = UserDefaults.standard.value(forKey: "State")
                
                
                if let temp = result as? NSDictionary{
                    
                    let u  = (temp["status"] as? String)!
                    
                    
                    
                    if(u == ""){
                        
                        //Map
                        
                        
                        let result = UserDefaults.standard.value(forKey: "slide")
                        
                        
                        if(result != nil){
                            let controller = self.makeSegue(Name: "Map")
                            self.window?.rootViewController = controller
                            self.window?.makeKeyAndVisible()
                            
                            
                        }
                        else {
                            
                            let controller = self.makeSegue(Name: "pager")
                            self.window?.rootViewController = controller
                            self.window?.makeKeyAndVisible()
                            
                        }
                        
                        
                    }else {
                        
                        let controller = self.makeSegue(Name: "waiting")
                        self.window?.rootViewController = controller
                        self.window?.makeKeyAndVisible()
                        
                    }
                    
                }else {
                    //Map
                    let controller = self.makeSegue(Name: "Login")
                    self.window?.rootViewController = controller
                    self.window?.makeKeyAndVisible()
                    
                }
                
                
            }else{
                
                let result = UserDefaults.standard.value(forKey: "slide")
                
                
                if(result != nil){
                    
                    let controller = self.makeSegue(Name: "Login")
                    self.window?.rootViewController = controller
                    self.window?.makeKeyAndVisible()
                    
                    
                }
                else {
                    
                    let controller = self.makeSegue(Name: "pager")
                    self.window?.rootViewController = controller
                    self.window?.makeKeyAndVisible()
                    
                }
                
            }
            
        }else {
            
            
            let result = UserDefaults.standard.value(forKey: "slide")
            
            
            if(result != nil){
                
                let controller = self.makeSegue(Name: "Login")
                self.window?.rootViewController = controller
                self.window?.makeKeyAndVisible()
                
                
            }
            else {
                
                let controller = self.makeSegue(Name: "pager")
                self.window?.rootViewController = controller
                self.window?.makeKeyAndVisible()
                
            }
            
            
        }
    }
    
}


