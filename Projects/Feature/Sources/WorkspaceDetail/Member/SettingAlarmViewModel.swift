import UIKit
import Foundation
import DIContainer
import Domain
import Combine

final class SettingAlarmViewModel: ObservableObject {
    var subscriptions = Set<AnyCancellable>()
    
    @Inject private var keyValueRepo: KeyValueRepo
    
    @Published var allowAlarm: Bool = true
    
    init() {
        if let allowAlarm = keyValueRepo.load(key: .allowAlarm) as? Bool {
            self.allowAlarm = allowAlarm
        }
        $allowAlarm.sink { allowAlarm in
            self.keyValueRepo.save(key: .allowAlarm, value: allowAlarm)
            if allowAlarm {
                UIApplication.shared.registerForRemoteNotifications()
            } else {
                UIApplication.shared.unregisterForRemoteNotifications()
            }
//            self.fetchAllowAlarm()
        }.store(in: &subscriptions)
    }
    
    func fetchAllowAlarm() {
        // TODO: Implemention
    }
}
