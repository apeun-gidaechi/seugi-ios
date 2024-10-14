import UIKit
import AuthenticationServices
import FirebaseCore
import FirebaseMessaging
import DIContainer
import Domain

public final class AppDelegate: NSObject, UIApplicationDelegate {
    
    @Inject private var keyValueRepo: KeyValueRepo
    
    private let gcmMessageIDKey: String = "gcm.message_id"

    public func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        
        // 세로방향 고정
        return UIInterfaceOrientationMask.portrait
    }
    
    // 앱이 켜졌을 때
    public func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        // remove Constraint warning
        UserDefaults.standard.set(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
        
        // 파이어베이스 설정
        FirebaseApp.configure()
        
        Messaging.messaging().delegate = self
        Messaging.messaging().isAutoInitEnabled = true
        
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { _, _ in }
        
        if let allowAlarm = keyValueRepo.load(key: .allowAlarm) as? Bool {
            if allowAlarm {
                UIApplication.shared.registerForRemoteNotifications()
            } else {
                UIApplication.shared.unregisterForRemoteNotifications()
            }
        } else {
            UIApplication.shared.registerForRemoteNotifications()
        }
        
        return true
    }
    
    // 백그라운드에서 푸시 알림을 탭했을 때 실행
    public func application(
        _ application: UIApplication,
        didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
    ) {
        print("✅ AppDelegate.didRegisterForRemoteNotificationsWithDeviceToken - fcm token registed")
        Messaging.messaging().apnsToken = deviceToken
    }
    
    public func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("✅ AppDelegate.didFailToRegisterForRemoteNotificationsWithError : \(error)")
    }
}

extension AppDelegate: MessagingDelegate {
    
    public func messaging(
        _ messaging: Messaging,
        didReceiveRegistrationToken fcmToken: String?
    ) {
        guard let fcmToken else {
            print("❌ AppDelegate.messaging - FCM is nil")
            return
        }
        let dataDict: [String: String] = ["token": fcmToken]
        print("✅ AppDelegate.messaging - token \(fcmToken)")
        keyValueRepo.save(key: .fcmToken, value: fcmToken)
        NotificationCenter.default.post(
          name: Notification.Name("FCMToken"),
          object: nil,
          userInfo: dataDict
        )
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    public func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification) async -> UNNotificationPresentationOptions {
        let userInfo = notification.request.content.userInfo
        if let messageID = userInfo[gcmMessageIDKey] {
            print("MessageId: \(messageID)")
        }
        Messaging.messaging().appDidReceiveMessage(userInfo)
        return if #available(iOS 14.0, *) {
            [[.list, .banner, .sound]]
        } else {
            [[.alert, .sound]]
        }
    }

    // 푸시메세지를 받았을 때
    public func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse) async {
        print("✅ AppDelegate.userNotificationCenter - \(response)")
    }
}
