import UIKit
import AuthenticationServices
import FirebaseCore
import FirebaseMessaging
import DIContainer
import Domain

public final class AppDelegate: NSObject, UIApplicationDelegate, ObservableObject {
    
    @Inject private var keyValueRepo: KeyValueRepo
    
    private let gcmMessageIDKey = "gcm.message_id"

    // 앱이 켜졌을 때
    public func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        // remove Constraint warning
        UserDefaults.standard.set(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
        return true // TODO: Remove return true
        
        // 파이어베이스 설정
        FirebaseApp.configure()
        
        // Setting Up Notifications...
        // 원격 알림 등록
        let authOption: UNAuthorizationOptions = [.alert, .badge, .sound]
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOption,
                completionHandler: { _, _ in }
            )
        } else {
            let settings: UIUserNotificationSettings =
            UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        application.registerForRemoteNotifications()
        
        // Setting Up Cloud Messaging...
        Messaging.messaging().delegate = self
        return true
    }
    
    // fcm 토큰이 등록 되었을 때
    public func application(
        _ application: UIApplication,
        didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
    ) {
        print("✅ AppDelegate.application - fcm token registed")
        Messaging.messaging().apnsToken = deviceToken
    }
}


extension AppDelegate: MessagingDelegate {
    
//    @Inject private var
    
    public func messaging(
        _ messaging: Messaging,
        didReceiveRegistrationToken fcmToken: String?
    ) {
        guard let fcmToken else {
            print("❌ AppDelegate.messaging - FCM is nil")
            return
        }
        print("✅ AppDelegate.messaging - token \(fcmToken)")
        keyValueRepo.save(key: .fcmToken, value: fcmToken)
        Task {
            do {
//                _ = try await NotificationApi.shared.postFcmToken(req: .init(fcmToken: fcmToken ?? ""))
            } catch {
                print("❌ AppDelegate.messaging - post fcm token failure")
                print(error)
            }
        }
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    // 푸시 메세지가 앱이 켜져있을 때 나올때
    public func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        
        let userInfo = notification.request.content.userInfo
        
        // Do Something With MSG Data...
        if let messageID = userInfo[gcmMessageIDKey] {
            print("✅ AppDelegate.userNotificationCenter - MessageID \(messageID)")
        }
        print("✅ AppDelegate.userInfo - MessageID \(userInfo)")
        completionHandler([[.banner, .badge, .sound]])
    }
    
    // 푸시메세지를 받았을 때
    public func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void
    ) {
        print("✅ AppDelegate.userNotificationCenter - \(response)")
        completionHandler()
    }
}
