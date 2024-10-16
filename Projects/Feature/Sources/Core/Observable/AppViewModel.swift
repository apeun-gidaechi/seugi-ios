import Foundation
import SwiftUI
import Combine

import DIContainer
import Domain
import SwiftUtil

public final class AppViewModel: ObservableObject {
    var subscriptions = Set<AnyCancellable>()
    
    @Inject private var keyValueRepo: KeyValueRepo
    @Inject private var keychainRepo: KeychainRepo
    @Inject private var memberRepo: MemberRepo
    
    @Published var logoutFlow: Flow<BaseVoid> = .idle
}

extension AppViewModel {
    func setToken(
        accessToken: String? = nil,
        refreshToken: String? = nil
    ) {
        if let accessToken {
            keyValueRepo.save(key: .accessToken, value: accessToken)
        } else {
            keyValueRepo.delete(key: .accessToken)
        }
        if let refreshToken {
            keychainRepo.save(key: .refreshToken, value: refreshToken)
        } else {
            keychainRepo.delete(key: .refreshToken)
        }
    }
    
    public func logout() {
        if let fcmToken = keyValueRepo.load(key: .fcmToken) as? String {
            memberRepo.logout(
                .init(fcmToken: fcmToken)
            )
            .flow(\.logoutFlow, on: self)
            .silentSink()
            .store(in: &subscriptions)
        }
        keyValueRepo.delete(key: .accessToken)
        keychainRepo.delete(key: .refreshToken)
        keyValueRepo.delete(key: .selectedWorkspaceId)
    }
}
