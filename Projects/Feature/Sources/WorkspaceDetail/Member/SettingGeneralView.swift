//
//  SettingGeneralView.swift
//  Feature
//
//  Created by hhhello0507 on 9/11/24.
//  Copyright © 2024 apeun-gidaechi. All rights reserved.
//

import SwiftUI
import Component

struct SettingGeneralView: View {
    @EnvironmentObject private var alert: AlertProvider
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                SeugiListItem.icon(title: "학교 나가기", titleColor: .red(.r500))
                    .button {
                        alert.present(
                            .init(title: "정말 학교를 나가시겠습니까?")
                            .message("나간 후에는\n다시 정보를 되돌릴 수 없습니다")
                            .primaryButton("나가기") {
                                // TODO: Implemention
                            }
                            .secondaryButton("취소")
                        )
                    }
                    .scaledButtonStyle()
            }
            .padding(.top, 6)
        }
        .seugiTopBar(title: "일반")
    }
}
