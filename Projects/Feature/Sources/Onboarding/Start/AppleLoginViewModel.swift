import Foundation
import AuthenticationServices
import DIContainer
import Domain
import ScopeKit

enum AppleLoginError: Error {
    case notFoundCredential
    case notFoundIdToken
    case error(Error)
}

struct AppleLoginResult: Equatable {
    let code: String
}

final class AppleLoginViewModel: NSObject, ObservableObject {
    @Inject private var keyValueRepo: KeyValueRepo
    
    @Published var loginFlow: Flow<AppleLoginResult> = .idle
}

extension AppleLoginViewModel {
    func signIn() {
        let request = ASAuthorizationAppleIDProvider().createRequest().apply {
            $0.requestedScopes = [.fullName, .email]
        }
//        request.nonce = encodeNonce
        
        ASAuthorizationController(authorizationRequests: [request]).let {
            $0.delegate = self
            $0.presentationContextProvider = self
            $0.performRequests()
        }
    }
}

extension AppleLoginViewModel: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        guard let credential = authorization.credential as? ASAuthorizationAppleIDCredential else {
            print("AppleSignInObservable - credential not found")
            self.loginFlow = .failure(AppleLoginError.notFoundCredential)
            return
        }
        guard let authorizationCode = credential.authorizationCode,
              let authorizationCodeString = String(data: authorizationCode, encoding: .utf8) else {
            print("AppleSignInObservable - identityToken not found")
            self.loginFlow = .failure(AppleLoginError.notFoundIdToken)
            return
        }
        
        let fullName = credential.fullName
        let nickname: String? = fullName?.let {
            if $0.familyName == nil && $0.givenName == nil {
                nil
            } else {
                ($0.familyName ?? "") + ($0.givenName ?? "")
            }
        }
        if let nickname {
            self.keyValueRepo.save(key: .appleNickname, value: nickname)
        }
        self.loginFlow = .success(
            .init(
                code: authorizationCodeString
            )
        )
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: any Error) {
        print("AppleSignInObservable - failure \(error)")
        self.loginFlow = .failure(AppleLoginError.error(error))
    }
}

extension AppleLoginViewModel: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        guard let window = UIApplication.shared.window else {
            fatalError("No window found")
        }
        return window
    }
}

extension PersonNameComponents: Scope {}
