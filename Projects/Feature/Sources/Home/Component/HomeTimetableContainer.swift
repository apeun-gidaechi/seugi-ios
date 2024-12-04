//
//  HomeTimetableContainer.swift
//  Feature
//
//  Created by hhhello0507 on 9/11/24.
//  Copyright © 2024 apeun-gidaechi. All rights reserved.
//

import SwiftUI
import Domain
import Component
import ScopeKit

struct HomeTimetableContainer: View {
    enum Id {
        case current
    }
    
    @State private var nowTime = Date()

    var selectedPeriod: Int {
        let totalInterval = timeSize + freeTimeSize
        let duration = Calendar.current.dateComponents([.minute], from: startTime, to: nowTime).minute ?? 0
        return duration / totalInterval
    }
    
    private let timetable: Flow<[Timetable]>
    private let action: () -> Void
    
    init(
        for timetable: Flow<[Timetable]>,
        action: @escaping () -> Void
    ) {
        self.action = action
        self.timetable = timetable
    }
    
    var body: some View {
        VStack(spacing: 12) {
            Button(action: action) {
                HStack(spacing: 8) {
                    HomeHeadlineIcon(icon: .bookFill)
                    Text("오늘의 시간표")
                        .font(.subtitle(.s2))
                        .seugiColor(.sub(.black))
                    Spacer()
                    HomeArrowIcon()
                }
                .padding(4)
            }
            .scaledButtonStyle()
            timetable.makeView {
                ProgressView()
            } success: { data in
                if data.isEmpty {
                    SeugiError("시간표가 없어요", image: .faceWithDiagonalMouth)
                } else {
                    ScrollViewReader { proxy in
                        ScrollView(.horizontal) {
                            LazyHStack(spacing: 0) {
                                ForEach(Array(data.enumerated()), id: \.offset) { idx, subject in
                                    let now = selectedPeriod == idx
                                    VStack(spacing: 0) {
                                        Text("\(idx + 1)")
                                            .font(.body(.b1))
                                            .frame(maxWidth: .infinity)
                                            .seugiColor(now ? .primary(.p500) : .primary(.p300))
                                            .padding(.vertical, 8)
                                        Text(subject.subject)
                                            .font(.body(.b1))
                                            .seugiColor(now ? .sub(.white) : selectedPeriod < idx ? .primary(.p200) : .primary(.p300))
                                            .padding(8)
                                            .lineLimit(1)
                                            .frame(maxWidth: .infinity)
                                            .if(selectedPeriod >= idx) { view in
                                                view.seugiBackground(.primary(.p500))
                                            }
                                            .if(now) { view in
                                                view.cornerRadius(16, corners: [.topRight, .bottomRight])
                                            }
                                            .content { view in
                                                ZStack {
                                                    Color.seugi(.primary(.p100))
                                                    view
                                                }
                                            }
                                            .if(idx == 0) { view in
                                                view.cornerRadius(16, corners: [.topLeft, .bottomLeft])
                                            }
                                            .if(idx == data.count - 1) { view in
                                                view.cornerRadius(16, corners: [.topRight, .bottomRight])
                                            }
                                    }
                                    .if(now) {
                                        $0.id(Id.current)
                                    }
                                    .frame(width: 80)
                                }
                            }
                        }
                        .scrollIndicators(.hidden)
                        .onChange(of: selectedPeriod) { _ in
                            proxy.scrollTo(Id.current, anchor: .center)
                        }
                        .onAppear {
                            proxy.scrollTo(Id.current, anchor: .center)
                        }
                    }
                }
            } failure: { _ in
                Text("학교를 등록하고 시간표를 확인하세요")
                    .seugiColor(.gray(.g600))
                    .font(.body(.b2))
                    .padding(.vertical, 12)
            }
        }
        .applyCardEffect()
    }
}

private let startTime: Date = run {
    var components = Calendar.current.dateComponents([.year, .month, .day], from: Date())
    components.hour = 8
    components.minute = 50
    return Calendar.current.date(from: components)!
}
private let freeTimeSize = 10
private let timeSize = 50
