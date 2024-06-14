//
//  SeugiListItem.swift
//  DesignSystem
//
//  Created by dgsw8th71 on 3/23/24.
//  Copyright © 2024 seugi. All rights reserved.
//

import SwiftUI

public struct SeugiListItem: View {
    
    var isOn: Binding<Bool>?
    var title: String
    var description: String?
    var icon: SeugiIconography?
    var content: AnyView?
    
    private init(
        title: String,
        isOn: Binding<Bool>? = nil,
        description: String? = nil,
        icon: SeugiIconography? = nil,
        content: AnyView? = nil
    ) {
        self.title = title
        self.isOn = isOn
        self.description = description
        self.icon = icon
        self.content = content
    }
    
    public static func normal(
        title: String
    ) -> Self {
        .init(title: title)
    }
    
    public static func toggle(
        title: String,
        isOn: Binding<Bool>
    ) -> Self {
        .init(title: title, isOn: isOn)
    }
    
    public static func description(
        title: String,
        description: String
    ) -> Self {
        .init(title: title, description: description)
    }
    
    public static func icon(
        title: String,
        icon: SeugiIconography
    ) -> Self {
        .init(title: title, icon: icon)
    }
    
    public static func content<Content: View>(
        title: String,
        content: @escaping () -> Content
    ) -> Self {
        .init(title: title, content: content().eraseToAnyView())
    }
    
    public var body: some View {
        HStack {
            Text(title)
                .font(.subtitle(.s2))
                .seugiColor(.sub(.black))
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
                    .seugiColor(.gray(.g600))
                    .padding(.trailing, 20)
            }
            if let content {
                content
                    .padding(.trailing, 20)
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 56)
    }
}
