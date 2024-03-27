//
//  SelectingJob.swift
//  Feature
//
//  Created by dgsw8th71 on 3/26/24.
//  Copyright © 2024 seugi. All rights reserved.
//

import SwiftUI
import DesignSystem
import BaseFeature

public struct SelectingJobView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject private var navController: NavigationController
    @State private var selectedTab: JobType? = nil
    
    public init() {}
    
    public var body: some View {
        VStack {
            Spacer()
            VStack {
                Text("학생이신가요?\n아니면 선생님이신가요?")
                    .font(.seugi(.subtitle1))
                    .toLeading()
                    .padding(.leading, 4)
                HStack {
                    ForEach(JobType.allCases, id: \.self) { tab in
                        Button {
                            selectedTab = tab
                        } label: {
                            JobCell(jobType: tab, isActive: selectedTab == tab)
                        }
                    }
                }
            }
            .padding(.horizontal, 16)
            Spacer()
            SeugiButton("계속하기", type: .primary) {
                // TODO: email, oauth에 따라 다른 view로 이동하기
                navController.path.append(.emailSignUp)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 16)
        }
        .seugiToolbar("회원가입") {
            dismiss()
        }
    }
}
