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
    
    private init(
        title: String,
        isOn: Binding<Bool>? = nil,
        description: String? = nil
    ) {
        self.title = title
        self.isOn = isOn
        self.description = description
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
    
    public var body: some View {
        HStack {
            Text(title)
                .font(.seugi(.subtitle2))
                .seugiForeground(.sub(.black))
                .padding(.leading, 20)
            Spacer()
            if let isOn {
                SeugiToggle(isOn: isOn)
                    .padding(.trailing, 20)
            }
            if let description {
                Text(description)
                    .font(.seugi(.subtitle2))
                    .seugiForeground(.gray(.g500))
                    .padding(.trailing, 20)
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 56)
    }
}
