//
//  TextFieldPreview.swift
//  Seugi
//
//  Created by dgsw8th71 on 3/23/24.
//  Copyright © 2024 seugi. All rights reserved.
//

import SwiftUI
import Component

struct TextFieldPreview: View {
    @State var tf1 = ""
    var body: some View {
        ScrollView {
            VStack {
                SeugiTextField("하이", text: $tf1)
                SeugiTextField("하이", text: $tf1, type: .none(hasXMark: false))
                SeugiTextField("하이", text: $tf1, type: .password)
                SeugiTextField("하이", text: $tf1, type: .password)
                    .disabled(true)
                SeugiTextFieldForm("하이잉", text: $tf1, label: "하이", isForcedLabel: false)
                SeugiTextFieldForm("하이잉", text: $tf1, label: "하이")
                SeugiChatTextField("하이", text: $tf1) {} sendButtonTapped: {}
                SeugiCodeTextField(text: $tf1, length: 6)
                SeugiCodeTextField(text: $tf1, length: 6).disabled(true)
            }
        }
        .background(Color.white)
    }
}
