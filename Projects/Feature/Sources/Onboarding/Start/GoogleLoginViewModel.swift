//
//  GoogleSignInViewModel.swift
//  Feature
//
//  Created by hhhello0507 on 9/4/24.
//  Copyright © 2024 apeun-gidaechi. All rights reserved.
//

import Foundation
import GoogleSignIn

final class GoogleLoginViewModel: ObservableObject {
    
    func signIn(
        successCompletion: @escaping (GIDSignInResult) -> Void,
        failureCompletion: @escaping (Error) -> Void
    ) {
        guard let rootViewController = UIApplication.shared.rootController else {
            print("GoogleLoginViewModel.signIn - rootViewController is nil")
            return
        }
        GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController) { result, error in
            if let error {
                failureCompletion(error)
                return
            }
            guard let result else { return }
            successCompletion(result)
        }
    }
}
