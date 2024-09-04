//
//  GoogleSignInViewModel.swift
//  Feature
//
//  Created by hhhello0507 on 9/4/24.
//  Copyright © 2024 apeun-gidaechi. All rights reserved.
//

import Foundation
import AppAuth

let clientId = Bundle.main.object(forInfoDictionaryKey: "GoogleClientId") as? String ?? ""

final class GoogleLoginViewModel: ObservableObject {
    
    func authorize() {
        let issuer = URL(string: "https://accounts.google.com")!
        let redirectURI = URL(string: "com.hhhello0507.booster:/oauth2redirect/google")! // Use your actual redirect URI

        // Discovery document 가져오기
        OIDAuthorizationService.discoverConfiguration(forIssuer: issuer) { configuration, error in
            guard let config = configuration else {
                print("Error retrieving discovery document: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            // Authorization Request 생성
            let request = OIDAuthorizationRequest(
                configuration: config,
                clientId: clientId, // Google API Console에서 생성한 클라이언트 ID
                clientSecret: nil,
                scopes: [OIDScopeOpenID, OIDScopeProfile],
                redirectURL: redirectURI,
                responseType: OIDResponseTypeCode,
                additionalParameters: nil
            )

            // Authorization request 실행
            
            guard let rootViewController = UIApplication.shared.connectedScenes
                .filter({ $0.activationState == .foregroundActive })
                .compactMap({ $0 as? UIWindowScene })
                .compactMap({ $0.keyWindow })
                .first?.rootViewController else {
                print("rootv not")
                return
            }
            
            OIDAuthState.authState(
                byPresenting: request, presenting: rootViewController) { authState, error in
                    if let authState = authState {
//                        self.authState = authState
//                        self.authorizationCode = authState.lastAuthorizationResponse.authorizationCode // wow
//                        print("Got authorization code: \(self.authorizationCode ?? "No code")")
                    } else {
                        print("Authorization error: \(error?.localizedDescription ?? "Unknown error")")
                    }
                }
        }
    }
}
