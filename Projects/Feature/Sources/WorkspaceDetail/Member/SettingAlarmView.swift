//
//  SettingAlarmView.swift
//  Feature
//
//  Created by hhhello0507 on 9/11/24.
//  Copyright © 2024 apeun-gidaechi. All rights reserved.
//

import SwiftUI
import Component
import DIContainer
import Domain

struct SettingAlarmView: View {
    
    @StateObject private var viewModel = SettingAlarmViewModel()
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                SeugiListItem.content(title: "전체 알림 허용") {
                    SeugiToggle(isOn: $viewModel.allowAlarm)
                }
            }
            .padding(.top, 6)
        }
        .seugiTopBar("알림 설정")
    }
}
