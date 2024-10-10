import Combine
import Foundation
import Domain
import DIContainer
import SwiftUtil

public final class StartViewModel: ObservableObject {
    var subscriptions = Set<AnyCancellable>()
    
    @Inject private var oauthRepo: OAuthRepo
    @Inject private var keyValueRepo: KeyValueRepo
    
    @Published var signInFlow: Flow<Token> = .idle
}

extension StartViewModel {
    func signIn(code: String, provider: OAuth2Provider) {
        guard let token = keyValueRepo.load(key: .fcmToken) as? String else {
            print("StartViewModel.signIn - fcmtoken이 없어요")
            return
        }
        switch provider {
        case .google:
            oauthRepo.authenticateGoogle(
                .init(
                    code: code,
                    token: token
                )
            )
            .map(\.data)
            .flow(\.signInFlow, on: self)
            .silentSink()
            .store(in: &subscriptions)
        case .apple:
            break
        }
    }
}
