import Foundation
import Domain
import DIContainer
import Combine
import SwiftUI
import SwiftUtil

final class LoginEmailViewModel: ObservableObject {
    var subscriptions = Set<AnyCancellable>()
    
    @Inject private var memberRepo: MemberRepo
    @Inject private var keyValueRepo: KeyValueRepo
    
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var signInFlow: Flow<Token> = .idle
}

extension LoginEmailViewModel {
    func signIn() {
        guard let fcmToken = keyValueRepo.load(key: .fcmToken) as? String else {
            print("LoginEmailViewModel.signIn - fcmToken is nil")
            return
        }
        memberRepo.login(
            .init(
                email: email,
                password: password,
                token: fcmToken
            )
        )
        .map(\.data)
        .flow(\.signInFlow, on: self)
        .silentSink()
        .store(in: &subscriptions)
    }
}
