//
//  ButtonPreview.swift
//  Seugi
//
//  Created by dgsw8th71 on 3/23/24.
//  Copyright © 2024 seugi. All rights reserved.
//

import SwiftUI
import Component

struct ButtonPreview: View {
    var body: some View {
        ScrollView {
            VStack {
                ForEach(SeugiButtonType.allCases, id: \.self) { type in
                    SeugiButton.large("계속하기", type: type) {
                        print("\(type) large")
                    }
                    SeugiButton.small("계속하기", type: type) {
                        print("\(type) small")
                    }
                    SeugiButton.large("계속하기", type: type, isLoading: true) {
                        print("\(type) large")
                    }
                    SeugiButton.small("계속하기", type: type, isLoading: true) {
                        print("\(type) small")
                    }
                }
                SeugiToggle(isOn: .constant(true))
                SeugiToggle(isOn: .constant(false))
                ForEach(ToggleSize.allCases, id: \.self) {
                    SeugiToggle(isOn: .constant(true), type: .checkbox(size: $0))
                    SeugiToggle(isOn: .constant(false), type: .checkbox(size: $0))
                }
            }
            .padding(.horizontal, 20)
        }
    }
}
