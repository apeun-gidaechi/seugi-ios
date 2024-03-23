//
//  ButtonPreview.swift
//  Seugi
//
//  Created by dgsw8th71 on 3/23/24.
//  Copyright © 2024 seugi. All rights reserved.
//

import SwiftUI
import DesignSystem

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
                }
            }
            .padding(.horizontal, 20)
        }
    }
}
