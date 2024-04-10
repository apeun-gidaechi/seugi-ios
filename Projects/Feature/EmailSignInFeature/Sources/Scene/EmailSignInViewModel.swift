//
//  EmailSignInViewModel.swift
//  Feature
//
//  Created by dgsw8th71 on 3/26/24.
//  Copyright © 2024 seugi. All rights reserved.
//

import Foundation

public class EmailSignInViewModel: ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    
    public init() {}
    
    func signIn() {
        // TODO: handle sign in
    }
}
