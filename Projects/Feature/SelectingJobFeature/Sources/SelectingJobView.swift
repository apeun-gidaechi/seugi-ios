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
    
    @State private var selectedTab: JobType?
    
    var navigateToEmailSignUp: () -> Void
    var navigateToOAuthSignUp: () -> Void
    
    public init(
        navigateToEmailSignUp: @escaping () -> Void,
        navigateToOAuthSignUp: @escaping () -> Void
    ) {
        self.navigateToEmailSignUp = navigateToEmailSignUp
        self.navigateToOAuthSignUp = navigateToOAuthSignUp
    }
    
    public var body: some View {
        VStack {
            Spacer()
            VStack {
                Text("학생이신가요?\n아니면 선생님이신가요?")
                    .font(.subtitle(.s1))
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
            SeugiButton.large("계속하기", type: .primary) {
                navigateToEmailSignUp()
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 16)
        }
        .seugiTopBar("회원가입")
    }
}
