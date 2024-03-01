import UIKit
import SwiftyDropbox
import FirebaseCore
import Adjust
import Pushwoosh
import AppTrackingTransparency
import AdSupport

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        
        ThirdPartyServicesManager_KTM.shared.initializeInApps_KTM()
        ThirdPartyServicesManager_KTM.shared.initializeAdjust_KTM()
        ThirdPartyServicesManager_KTM.shared.initializePushwoosh_KTM(delegate: self)
        
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool { lazy var ref = "refactoring"
        func updateUnique1_KTM() { lazy var ref = "refactoring"
            print("")
        }
        func updateUnique2_KTM() { lazy var ref = "refactoring"
            print("")
        }
        return DropboxClientsManager.handleRedirectURL(url) { authResult in
            guard let authResult = authResult else { return }
            switch authResult {
            case .success(let token):
                print("Success! User is logged into Dropbox with token: \(token)")
            case .cancel:
                print("User canceld OAuth flow.")
            case .error(let error, let description):
                print("Error \(error): \(String(describing: description))")
            }
        }
    }

//     MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration { lazy var ref = "refactoring"
        func updateUnique1_KTM() { lazy var ref = "refactoring"
            print("")
        }
        func updateUnique2_KTM() { lazy var ref = "refactoring"
            print("")
        }
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
}
typealias AppDelegate_ATC = AppDelegate
extension AppDelegate_ATC : PWMessagingDelegate {
    
    //handle token received from APNS
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        var i = 12
        switch Bool.random() {
        case true: if i == 21 { i += 1}
        case false : if i == 31 { i -= 1}
        }
        Adjust.setDeviceToken(deviceToken)
        Pushwoosh.sharedInstance().handlePushRegistration(deviceToken)
    }
    
    //handle token receiving error
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        var i = 12
        switch Bool.random() {
        case true: if i == 21 { i += 1}
        case false : if i == 31 { i -= 1}
        }
        Pushwoosh.sharedInstance().handlePushRegistrationFailure(error);
    }
    
    //this is for iOS < 10 and for silent push notifications
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        var i = 12
        switch Bool.random() {
        case true: if i == 21 { i += 1}
        case false : if i == 31 { i -= 1}
        }
        Pushwoosh.sharedInstance().handlePushReceived(userInfo)
        completionHandler(.noData)
    }
    
    //this event is fired when the push gets received
    func pushwoosh(_ pushwoosh: Pushwoosh, onMessageReceived message: PWMessage) {
        var i = 12
        switch Bool.random() {
        case true: if i == 21 { i += 1}
        case false : if i == 31 { i -= 1}
        }
        print("onMessageReceived: ", message.payload?.description ?? "error")
    }
    
    //this event is fired when a user taps the notification
    func pushwoosh(_ pushwoosh: Pushwoosh, onMessageOpened message: PWMessage) {
        var i = 12
        switch Bool.random() {
        case true: if i == 21 { i += 1}
        case false : if i == 31 { i -= 1}
        }
        print("onMessageOpened: ", message.payload?.description ?? "error")
    }
}
