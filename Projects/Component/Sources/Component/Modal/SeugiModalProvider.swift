//
//  SeugiModalProvider.swift
//  Component
//
//  Created by hhhello0507 on 7/25/24.
//  Copyright © 2024 apeun.gidaechi. All rights reserved.
//

import SwiftUI

public struct SeugiModalProvider<C: View>: View {
    
    private let timePickerProvider: TimePickerProvider
    private let alertProvider: AlertProvider
    private let content: () -> C
    
    public init(
        alertProvider: AlertProvider,
        timePickerProvider: TimePickerProvider,
        @ViewBuilder content: @escaping () -> C
    ) {
        self.alertProvider = alertProvider
        self.timePickerProvider = timePickerProvider
        self.content = content
    }
    
    public var body: some View {
        SeugiTimePicker(provider: timePickerProvider) {
            SeugiAlertPresenter(provider: alertProvider) {
                content()
                    .environmentObject(timePickerProvider)
                    .environmentObject(alertProvider)
            }
        }
    }
}
