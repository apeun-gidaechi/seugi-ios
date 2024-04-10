//
//  EmailSignUpViewModel.swift
//  Feature
//
//  Created by dgsw8th71 on 3/26/24.
//  Copyright © 2024 seugi. All rights reserved.
//

import DesignSystem
import Foundation

public class EmailSignUpViewModel: ObservableObject {
    
    @Published var name = ""
    @Published var email = ""
    @Published var password = ""
    @Published var passwordCheck = ""
    
    public init() {}
}
