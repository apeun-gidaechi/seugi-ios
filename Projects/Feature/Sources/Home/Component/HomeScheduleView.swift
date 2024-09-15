//
//  HomeScheduleView.swift
//  Feature
//
//  Created by hhhello0507 on 9/15/24.
//  Copyright © 2024 apeun-gidaechi. All rights reserved.
//

import Component
import SwiftUI

struct HomeScheduleContainer: View {
    
    private let schedule: HomeFetchFlow // TODO: dummy
    
    init(for schedule: HomeFetchFlow) {
        self.schedule = schedule
    }
    
    var body: some View {
        VStack(spacing: 12) {
            HStack(spacing: 8) {
                HomeHeadlineIcon(icon: .calendarLine)
                Text("다가오는 일정")
                    .seugiColor(.sub(.black))
                    .font(.subtitle(.s2))
                Spacer()
                Image(icon: .expandRightLine)
                    .resizable()
                    .renderingMode(.template)
                    .seugiColor(.gray(.g500))
                    .frame(width: 24, height: 24)
            }
            .padding(4)
            switch schedule {
            case .fetching:
                ProgressView()
            case .failure:
                Text("학교를 등록하고 일정을 확인하세요")
                    .seugiColor(.gray(.g600))
                    .font(.body(.b2))
                    .padding(.vertical, 12)
            case .success:
                VStack(spacing: 16) {
                    ForEach(0..<3, id: \.self) { _ in
                        HStack(spacing: 0) {
                            Text("7/21")
                                .font(.body(.b1))
                                .seugiColor(.primary(.p500))
                            Text("체육대회")
                                .font(.body(.b2))
                                .seugiColor(.sub(.black))
                                .padding(.leading, 10)
                            Spacer()
                            Text("D-3")
                                .font(.caption(.c1))
                                .seugiColor(.gray(.g600))
                        }
                    }
                }
            }
        }
        .applyCardEffect()
    }
}
