//
//  SeugiMenu.swift
//  DesignSystem
//
//  Created by dgsw8th71 on 4/3/24.
//  Copyright © 2024 apeun.gidaechi. All rights reserved.
//

import SwiftUI
import SwiftUIUtil

public struct SeugiDropdown<T: Hashable & CustomStringConvertible>: View {
    
    // MARK: - parameters
    let hint: String
    var pickerOptions: [T]
    @Binding var selection: T
    
    public init(
        _ hint: String,
        pickerOptions: [T],
        selection: Binding<T>
    ) {
        self.hint = hint
        self.pickerOptions = pickerOptions
        self._selection = selection
    }
    
    // MARK: - View
    public var body: some View {
        Menu {
            Picker(hint, selection: $selection) {
                ForEach(pickerOptions, id: \.self) { option in
                    Text("\(option.description)")
                }
            }
        } label: {
            HStack {
                Text(hint)
                    .seugiColor(.gray(.g500))
                    .font(.seugi(.subtitle2))
                Spacer()
                Image(icon: .expandDownLine)
                    .resizable()
                    .renderingMode(.template)
                    .seugiColor(.gray(.g500))
                    .frame(width: 24, height: 24)
            }
        }
        .menuStyle(SeugiDropdownStyle())
    }
}

struct SeugiDropdownStyle: MenuStyle {
    
    @Environment(\.isEnabled) var isEnabled
    
    func makeBody(configuration: Configuration) -> some View {
        let strokeColor: Color = .seugi(.gray(.g300))
        
        Menu(configuration)
            .frame(maxWidth: .infinity)
            .frame(height: 52)
            .background(Color.seugi(.sub(.white)))
            .padding(.horizontal, 16)
            .cornerRadius(12, corners: .allCorners)
            .font(.seugi(.subtitle2))
            .accentColor(.seugi(.primary(.p500)))
            .seugiColor(isEnabled ? .sub(.black) : .gray(.g400))
            .overlay(
                RoundedCornerShape(radius: 12)
                    .stroke(isEnabled ? strokeColor : .seugi(.gray(.g200)), lineWidth: 1)
            )
    }
}
