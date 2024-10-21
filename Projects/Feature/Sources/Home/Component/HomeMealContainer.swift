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
    private let meals: Flow<[Meal]>
    @State private var maxHeight: CGFloat?
    @State private var selection: Int = 0
    @Namespace private var animation
    private let action: () -> Void
    
    init(
        for meals: Flow<[Meal]>,
        action: @escaping () -> Void
    ) {
        self.meals = meals
        self.action = action
    }
    
    var body: some View {
        VStack(spacing: 12) {
            Button(action: action) {
                HStack(spacing: 8) {
                    HomeHeadlineIcon(icon: .utensilsLine)
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
                .padding(4)
            }
            .scaledButtonStyle()
            meals.makeView {
                ProgressView()
            } success: { meals in
                if meals.isEmpty {
                    SeugiError("급식이 없어요", image: .sadButRelievedFace)
                } else {
                    TabView(selection: $selection) {
                        ForEach(meals.indices, id: \.self) { mealIndex in
                            HomeMealContainerCell(for: meals[mealIndex])
                                .padding(.horizontal, 4)
                                .onReadSize { size in
                                    self.maxHeight = max(size.height, self.maxHeight ?? 0)
                                }
                        }
                    }
                    .animation(.spring(duration: 0.4), value: selection)
                    .frame(height: maxHeight ?? 300)
                    .tabViewStyle(.page(indexDisplayMode: .never))
                    Rectangle()
                        .frame(width: 36, height: 6)
                        .seugiColor(.gray(.g300))
                        .cornerRadius(3, corners: .allCorners)
                        .overlay {
                            let width = 36.0 / CGFloat(meals.count)
                            Rectangle()
                                .seugiColor(.primary(.p500))
                                .frame(width: width)
                                .frame(maxHeight: .infinity)
                                .cornerRadius(3, corners: .allCorners)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .offset(x: width * CGFloat(selection))
                                .animation(.spring(duration: 0.4), value: selection)
                                .matchedGeometryEffect(id: "indicator", in: animation)
                        }
                }
            } failure: { _ in
                Text("학교를 등록하고 급식을 확인하세요")
                    .seugiColor(.gray(.g600))
                    .font(.body(.b2))
                    .padding(.vertical, 12)
            }
            // Indicator
        }
        .applyCardEffect()
    }
}
