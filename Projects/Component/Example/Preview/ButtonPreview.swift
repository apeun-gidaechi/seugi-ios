//
//  ButtonPreview.swift
//  Seugi
//
//  Created by dgsw8th71 on 3/23/24.
//  Copyright © 2024 seugi. All rights reserved.
//

import SwiftUI
import Component
import SwiftUtil

struct Role: SegmentedButtonProtocol {
    var label: String
}

private let data: [Role] = [
    .init(label: "선생님"),
    .init(label: "학생")
]

struct ButtonPreview: View {
    
    @State var selection: Role = data[0]
    
    init() {}
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(SeugiButtonType.allCases, id: \.self) { type in
                    SeugiButton.large("계속하기", type: type) {
                        Log.info("\(type) large")
                    }
                    SeugiButton.small("계속하기", type: type) {
                        Log.info("\(type) small")
                    }
                    SeugiButton.large("계속하기", type: type, isLoading: true) {
                        Log.info("\(type) large")
                    }
                    SeugiButton.small("계속하기", type: type, isLoading: true) {
                        Log.info("\(type) small")
                    }
                }
                SeugiToggle(isOn: .constant(true))
                SeugiToggle(isOn: .constant(false))
                ForEach(ToggleSize.allCases, id: \.self) {
                    SeugiToggle(isOn: .constant(true), type: .checkbox(size: $0))
                    SeugiToggle(isOn: .constant(false), type: .checkbox(size: $0))
                }
                
                SeugiSegmentedButton(
                    data,
                    selection: $selection
                )
            }
            .padding(.horizontal, 20)
        }
    }
}
