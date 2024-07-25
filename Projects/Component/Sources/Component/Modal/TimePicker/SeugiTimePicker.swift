//
//  SeugiTimePicker.swift
//  Component
//
//  Created by hhhello0507 on 7/25/24.
//  Copyright © 2024 apeun.gidaechi. All rights reserved.
//

import SwiftUI

public struct SeugiTimePicker<C: View>: ModalViewProtocol {
    
    typealias P = TimePickerProvider
    
    @StateObject var provider: TimePickerProvider
    var content: () -> C
    
    init(
        provider: TimePickerProvider = .init(),
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
            provider: provider,
            modalContent: {
                Text("반값다 나다")
                    .onTapGesture {
                        dismiss()
                    }
                    .padding(10)
            },
            content: content
        )
    }
}
