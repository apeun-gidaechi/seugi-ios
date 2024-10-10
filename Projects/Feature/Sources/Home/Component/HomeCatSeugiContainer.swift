//
//  HomeCatSeugiContainer.swift
//  Feature
//
//  Created by hhhello0507 on 9/12/24.
//  Copyright © 2024 apeun-gidaechi. All rights reserved.
//

import SwiftUI
import Component
import SwiftUIUtil

struct HomeCatSeugiContainer: View {
    
    enum Action {
        case clicked
    }
    
    private let flow: HomeFetchFlow
    private let action: (Action) -> Void
    
    init(
        for flow: HomeFetchFlow,
        action: @escaping (Action) -> Void
    ) {
        self.flow = flow
        self.action = action
    }
    
    var body: some View {
        VStack(spacing: 16) {
            HStack(spacing: 8) {
                SeugiAppIcon(type: .extraSmall)
                Text("캣스기")
                    .seugiColor(.sub(.black))
                    .font(.subtitle(.s2))
                Spacer()
            }
            .padding(4)
            switch flow {
            case .fetching:
                ProgressView()
            case .empty:
                Text("학교를 등록하고 캣스기와 대화해 보세요")
                    .seugiColor(.gray(.g600))
                    .font(.body(.b2))
                    .padding(.vertical, 12)
            case .finished:
                Button {
                    action(.clicked)
                } label: {
                    HStack {
                        Text("2학년 4반에서 아무나 한명 뽑아줘...")
                            .font(.subtitle(.s2))
                            .seugiColor(.gray(.g500))
                        Spacer()
                        Image(icon: .searchLine)
                            .renderingMode(.template)
                            .resizable()
                            .foregroundStyle(SeugiGradientSystem.primary)
                            .frame(width: 28, height: 28)
                    }
                    .padding(.horizontal, 12)
                    .frame(height: 52)
                    .overlay {
                        RoundedCornerShape(radius: 26)
                            .stroke(SeugiGradientSystem.primary, lineWidth: 1.5)
                    }
                }
                .scaledButtonStyle()
                
                //                VStack(alignment: .leading, spacing: 4) {
                //                    Text("지난주")
                //                        .padding(.leading, 4)
                //                        .seugiColor(.gray(.g600))
                //                        .font(.body(.b2))
                //                    makeAIHistory()
                //                    makeAIHistory()
                //                }
            }
        }
        .applyCardEffect()
    }
    
    private func makeAIHistory() -> some View {
        HStack {
            Text("급식에 복어가 나오는 날이 언제...")
                .font(.body(.b1))
                .seugiColor(.sub(.black))
            Spacer()
            Text("6월 21일")
                .font(.body(.b2))
                .seugiColor(.gray(.g600))
        }
        .padding(12)
        .seugiBackground(.gray(.g200))
        .cornerRadius(4)
    }
}
