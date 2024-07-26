//
//  TimePickerProvider.swift
//  Component
//
//  Created by hhhello0507 on 7/25/24.
//  Copyright © 2024 apeun.gidaechi. All rights reserved.
//

import Foundation

public final class TimePickerProvider: ModalProvider {
    @Published var isPresent = false
    
    var title: String?
    var action: (() -> Void)?
    
    public init() {}
    
    public func present(
        _ title: String,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.action = action
        isPresent = true
    }
}
