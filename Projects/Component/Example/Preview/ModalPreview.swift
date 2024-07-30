//
//  AlertPreview.swift
//  Component
//
//  Created by hhhello0507 on 7/25/24.
//  Copyright © 2024 apeun.gidaechi. All rights reserved.
//

import SwiftUI
import Component

struct ModalPreview: View {
    
    @EnvironmentObject private var alertProvider: AlertProvider
    @EnvironmentObject private var timePickerProvider: TimePickerProvider
    @State var show = false
    var body: some View {
        
        VStack {
            Button("Alert") {
                alertProvider.present("제목을 입력해주세요")
                    .message("본문을 입력해주세요")
//                    .secondaryButton("취소") {
//                        //
//                    }
                    .primaryButton("확인") {}
                    .show()
            }
            Button("Norma Alert") {
                show = true
            }
            Button("Time Picker") {
                timePickerProvider.present("wow") {
                    debugPrint("selected")
                }
            }
        }
        .alert("제목을 입력해주세요", isPresented: $show) {
            Button("확인") {}
        } message: {
            Text("본문을 입력해주세요")
        }
    }
}
