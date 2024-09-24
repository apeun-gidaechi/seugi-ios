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
    
    private var successCompletion: ((_ code: String, _ nickname: String) -> Void)?
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
        guard let authorizationCode = credential.authorizationCode,
              let authorizationCodeString = String(data: authorizationCode, encoding: .utf8) else {
            print("AppleSignInObservable - identityToken not found")
            failureCompletion?()
            return
        }
        
        let fullName = credential.fullName
        let nickname = (fullName?.familyName ?? "") + (fullName?.givenName ?? "")
        
        successCompletion?(authorizationCodeString, nickname)
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: any Error) {
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
