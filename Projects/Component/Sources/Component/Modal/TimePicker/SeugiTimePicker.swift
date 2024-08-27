//
//  SeugiTimePicker.swift
//  Component
//
//  Created by hhhello0507 on 7/25/24.
//  Copyright © 2024 apeun.gidaechi. All rights reserved.
//

import SwiftUI
import SwiftUIUtil

public struct SeugiTimePicker<C: View>: ModalViewProtocol {
    
    typealias P = TimePickerProvider
    
    @StateObject private var provider: TimePickerProvider
    let content: () -> C
    
    init(
        provider: TimePickerProvider,
        @ViewBuilder content: @escaping () -> C
    ) {
        self._provider = .init(wrappedValue: provider)
        self.content = content
    }
    
    func dismiss() {
        provider.isPresent = false
    }
    
    public var body: some View {
        BaseModal(
            isPresent: $provider.isPresent,
            modalContent: {
                VStack(spacing: 16) {
                    if let title = provider.title {
                        Text(title)
                            .font(.subtitle(.s1))
                            .seugiColor(.sub(.black))
                            .toLeading()
                    }
                    DatePicker("", selection: .constant(.now))
                        .datePickerStyle(.wheel)
                    SeugiButton.large("선택", type: .primary) {
                        provider.action?()
                        dismiss()
                    }
                }
                .padding(24)
                .frame(width: 336)
            },
            content: content
        )
    }
}
