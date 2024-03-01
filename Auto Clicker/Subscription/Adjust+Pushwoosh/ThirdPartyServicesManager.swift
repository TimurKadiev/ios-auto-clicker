//
//  ThirdPartyServicesManager.swift
//  Auto Clicker
//
//  Created by Timur Kadiev on 24.01.2024.
//

import Foundation
import UIKit
import Adjust
import Pushwoosh
import AppTrackingTransparency
import AdSupport


class ThirdPartyServicesManager_KTM {

    static let shared = ThirdPartyServicesManager_KTM()
    
    func initializeAdjust_KTM() {  lazy var ref = "refactoring"
        let yourAppToken = Config_KTM.adjustToken
        #if DEBUG
        let environment = (ADJEnvironmentSandbox as? String)!
        #else
        let environment = (ADJEnvironmentProduction as? String)!
        #endif
        let adjustConfig = ADJConfig(appToken: yourAppToken, environment: environment)
        
        adjustConfig?.logLevel = ADJLogLevelVerbose

        Adjust.appDidLaunch(adjustConfig)
    }
    
    func initializePushwoosh_KTM(delegate: PWMessagingDelegate) {  lazy var ref = "refactoring"
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            Pushwoosh.sharedInstance().delegate = delegate;
            PushNotificationManager.initialize(withAppCode: Config_KTM.pushwooshToken, appName: Config_KTM.pushwooshAppName)
            PWInAppManager.shared().resetBusinessCasesFrequencyCapping()
            PWGDPRManager.shared().showGDPRDeletionUI()
            Pushwoosh.sharedInstance().registerForPushNotifications()
            UIApplication.shared.applicationIconBadgeNumber = 0
        }
    }

        //set custom delegate for push handling, in our case AppDelegate
    
    func initializeInApps_KTM() { lazy var ref = "refactoring"
        IAPManager_MFTW.shared.setup_MFTW(completion: { isSuceess in
        })
    }
    
    func makeATT() {
            if #available(iOS 14, *) {
                ATTrackingManager.requestTrackingAuthorization { status in
                    switch status {
                    case .authorized:
                        print("Authorized")
                        let idfa = ASIdentifierManager.shared().advertisingIdentifier
                        print("Пользователь разрешил доступ. IDFA: ", idfa)
                        let authorizationStatus = Adjust.appTrackingAuthorizationStatus()
                        Adjust.updateConversionValue(Int(authorizationStatus))
                        Adjust.checkForNewAttStatus()
                        print(ASIdentifierManager.shared().advertisingIdentifier)
                    case .denied:
                        print("Denied")
                    case .notDetermined:
                        print("Not Determined")
                    case .restricted:
                        print("Restricted")
                    @unknown default:
                        print("Unknown")
                    }
                }
        }
    }
}


