//
//  SeugiListItem.swift
//  DesignSystem
//
//  Created by dgsw8th71 on 3/23/24.
//  Copyright © 2024 seugi. All rights reserved.
//

import SwiftUI

public struct SeugiListItem: View {
    
    private let isOn: Binding<Bool>?
    private let title: String
    private let description: String?
    private let icon: SeugiIconography?
    private let content: AnyView?
    private let titleColor: Color.SeugiColorSystem
    
    private init(
        title: String,
        isOn: Binding<Bool>? = nil,
        description: String? = nil,
        icon: SeugiIconography? = nil,
        content: AnyView? = nil,
        titleColor: Color.SeugiColorSystem
    ) {
        self.title = title
        self.isOn = isOn
        self.description = description
        self.icon = icon
        self.content = content
        self.titleColor = titleColor
    }
    
    public static func normal(
        title: String,
        titleColor: Color.SeugiColorSystem = .sub(.black)
    ) -> Self {
        .init(title: title, titleColor: titleColor)
    }
    
    public static func toggle(
        title: String,
        isOn: Binding<Bool>,
        titleColor: Color.SeugiColorSystem = .sub(.black)
    ) -> Self {
        .init(title: title, isOn: isOn, titleColor: titleColor)
    }
    
    public static func description(
        title: String,
        description: String,
        titleColor: Color.SeugiColorSystem = .sub(.black)
    ) -> Self {
        .init(title: title, description: description, titleColor: titleColor)
    }
    
    public static func icon(
        title: String,
        icon: SeugiIconography,
        titleColor: Color.SeugiColorSystem = .sub(.black)
    ) -> Self {
        .init(title: title, icon: icon, titleColor: titleColor)
    }
    
    public static func content<Content: View>(
        title: String,
        titleColor: Color.SeugiColorSystem = .sub(.black),
        content: @escaping () -> Content
    ) -> Self {
        .init(title: title, content: content().eraseToAnyView(), titleColor: titleColor)
    }
    
    public var body: some View {
        HStack {
            Text(title)
                .font(.subtitle(.s2))
                .seugiColor(titleColor)
                .padding(.leading, 20)
            Spacer()
            if let isOn {
                SeugiToggle(isOn: isOn)
                    .padding(.trailing, 20)
            }
            if let description {
                Text(description)
                    .font(.subtitle(.s2))
                    .seugiColor(.gray(.g500))
                    .padding(.trailing, 20)
            }
            if let icon {
                Image(icon: icon)
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 28, height: 28)
                    .seugiColor(.gray(.g400))
                    .padding(.trailing, 20)
            }
            if let content {
                content
                    .padding(.trailing, 20)
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 56)
        .background()
    }
}
