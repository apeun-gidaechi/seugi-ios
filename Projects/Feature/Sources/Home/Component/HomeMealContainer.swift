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
    
    private let meals: FetchFlow<[Meal]>
    @State private var maxHeight: CGFloat?
    @State private var selection = 0
    
    init(for meals: FetchFlow<[Meal]>) {
        self.meals = meals
    }
    
    var body: some View {
        VStack(spacing: 12) {
            HStack(spacing: 8) {
                HomeHeadlineIcon(icon: .utensilsLine)
                Text("오늘의 급식")
                    .font(.subtitle(.s2))
                    .seugiColor(.sub(.black))
                Spacer()
            }
            switch meals {
            case .fetching:
                ProgressView()
            case .failure:
                Text("학교를 등록하고 급식을 확인하세요")
                    .seugiColor(.gray(.g600))
                    .font(.body(.b2))
                    .padding(.vertical, 12)
            case .success(let meals):
                if meals.isEmpty {
                    SeugiError("급식이 없어요", image: .sadButRelievedFace)
                } else {
                    TabView(selection: $selection) {
                        ForEach(meals.indices, id: \.self) { mealIndex in
                            let meal = meals[mealIndex]
                            VStack(spacing: 8) {
                                HStack {
                                    Text(meal.mealType.rawValue)
                                        .font(.caption(.c1))
                                        .padding(.horizontal, 10)
                                        .seugiColor(.sub(.white))
                                        .frame(height: 24)
                                        .seugiBackground(.primary(.p500))
                                        .cornerRadius(12, corners: .allCorners)
                                    Spacer()
                                    Text(meal.calorie)
                                        .font(.caption(.c1))
                                        .seugiColor(.gray(.g500))
                                }
                                VStack(spacing: 0) {
                                    ForEach(meal.menu.indices, id: \.self) { index in
                                        Text(meal.menu[index])
                                            .font(.body(.b2))
                                            .seugiColor(.gray(.g700))
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                    }
                                }
                            }
                            .onReadSize { size in
                                self.maxHeight = max(size.height, self.maxHeight ?? 0)
                            }
                        }
                    }
                    .animation(.spring(duration: 0.4), value: selection)
                    .frame(height: maxHeight ?? 300)
                    .tabViewStyle(.page(indexDisplayMode: .never))
                }
                // Indicator
            }
        }
        .padding(.horizontal, 4)
        .applyCardEffect()
    }
}
