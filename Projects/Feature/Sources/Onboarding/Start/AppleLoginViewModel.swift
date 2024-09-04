//
//  AppleLoginViewModel.swift
//  Feature
//
//  Created by hhhello0507 on 9/4/24.
//  Copyright © 2024 apeun-gidaechi. All rights reserved.
//

import Foundation
import AuthenticationServices
import Then

final class AppleLoginViewModel: NSObject, ObservableObject {
    
    @Published var error: Error?
    
    private var successCompletion: ((_ idToken: String, _ nickname: String) -> Void)?
    private var failureCompletion: (() -> Void)?
    
    func signIn(
        successCompletion: @escaping (String, String) -> Void,
        failureCompletion: @escaping () -> Void
    ) {
        self.successCompletion = successCompletion
        self.failureCompletion = failureCompletion
        
        let request = ASAuthorizationAppleIDProvider().createRequest().then {
            $0.requestedScopes = [.fullName, .email]
        }
//        request.nonce = encodeNonce
        
        ASAuthorizationController(authorizationRequests: [request]).do {
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
            failureCompletion?()
            return
        }
        guard let identityToken = credential.identityToken,
              let identityTokenString = String(data: identityToken, encoding: .utf8) else {
            print("AppleSignInObservable - identityToken not found")
            failureCompletion?()
            return
        }
        
        let fullName = credential.fullName
        let nickname = (fullName?.familyName ?? "") + (fullName?.givenName ?? "")
        
        successCompletion?(identityTokenString, nickname)
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: any Error) {
        self.error = error
        print("AppleSignInObservable - failure \(error)")
        failureCompletion?()
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
