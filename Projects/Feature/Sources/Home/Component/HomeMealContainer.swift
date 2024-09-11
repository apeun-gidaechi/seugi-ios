//
//  HomeMealContainer.swift
//  Feature
//
//  Created by hhhello0507 on 9/11/24.
//  Copyright © 2024 apeun-gidaechi. All rights reserved.
//

import SwiftUI
import Domain
import Component

struct HomeMealContainer: View {
    
    private let flow: FetchFlow<[Meal]>
    
    init(flow: FetchFlow<[Meal]>) {
        self.flow = flow
    }
    
    var body: some View {
        switch flow {
        case .fetching:
            VStack(spacing: 12) {
                HStack(spacing: 8) {
                    HeadlineIcon(icon: .utensilsLine)
                    Text("오늘의 급식")
                        .font(.subtitle(.s2))
                        .seugiColor(.sub(.black))
                    Spacer()
                }
                ProgressView()
            }
            .applyCardEffect()
        case .failure:
            VStack(spacing: 12) {
                HStack(spacing: 8) {
                    HeadlineIcon(icon: .utensilsLine)
                    Text("오늘의 급식")
                        .font(.subtitle(.s2))
                        .seugiColor(.sub(.black))
                    Spacer()
                }
                Text("학교를 등록하고 급식을 확인하세요")
                    .seugiColor(.gray(.g600))
                    .font(.body(.b2))
                    .padding(.vertical, 12)
            }
            .applyCardEffect()
        case .success(let data):
            VStack(spacing: 12) {
                HStack(spacing: 8) {
                    HeadlineIcon(icon: .utensilsLine)
                    Text("오늘의 급식")
                        .font(.subtitle(.s2))
                        .seugiColor(.sub(.black))
                    Spacer()
                    Image(icon: .expandRightLine)
                        .resizable()
                        .renderingMode(.template)
                        .seugiColor(.gray(.g500))
                        .frame(width: 24, height: 24)
                }
                HStack(spacing: 0) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("""
                             오리훈제볶음밥
                             간장두부조립
                             배추김치
                             초코첵스시리얼+우유
                             오렌지
                             """)
                        .multilineTextAlignment(.leading)
                        .font(.body(.b2))
                        .seugiColor(.gray(.g700))
                        Text("872kcal")
                            .font(.caption(.c1))
                            .seugiColor(.sub(.white))
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .seugiBackground(.primary(.p500))
                            .cornerRadius(100)
                    }
                    Spacer()
                    VStack(spacing: 4) {
                        Image(image: .apple1)
                            .resizable()
                            .frame(width: 94, height: 94)
                        Text("아침")
                            .font(.caption(.c1))
                            .seugiColor(.gray(.g500))
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .applyCardEffect()
        }
    }
}
