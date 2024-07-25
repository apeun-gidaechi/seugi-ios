//
//  AlertPreview.swift
//  Component
//
//  Created by hhhello0507 on 7/25/24.
//  Copyright © 2024 apeun.gidaechi. All rights reserved.
//

import SwiftUI
import Component

struct AlertPreview: View {
    
    @EnvironmentObject private var alertProvider: AlertProvider
    
    var body: some View {
        
        VStack {
            Button("Alert") {
                alertProvider.present("제목을 입력해주세요")
                    .message("본문을 입력해주세요")
//                    .secondaryButton("취소") {
//                        //
//                    }
                    .primaryButton("확인") {
                        //
                    }
                    .show()
            }
        }
    }
}
