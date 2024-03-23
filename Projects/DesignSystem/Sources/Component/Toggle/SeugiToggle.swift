//
//  AlimoSwitch.swift
//  App
//
//  Created by dgsw8th71 on 1/7/24.
//  Copyright © 2024 b8nd. All rights reserved.
//

import SwiftUI

//public struct SeugiToggle: View {
//    
//    @Binding var isOn: Bool
//    
//    public init(isOn: Binding<Bool>) {
//        self._isOn = isOn
//    }
//    
//    public var body: some View {
//        Toggle("", isOn: $isOn)
//            .labelsHidden()
//            .seugiForeground(.primary(.p300))
//            .tint(.seugi(.primary(.p500)))
//            .frame(width: 54, height: 28)
//    }
//}
//
//  Toggle.swift
//  Sui
//
//  Created by dgsw8th71 on 3/7/24.
//

import SwiftUI

public struct SeugiToggle: View {
    
    @Binding var isOn: Bool
    var type: ToggleType
    
    public init(isOn: Binding<Bool>,
                type: ToggleType = .default) {
        self._isOn = isOn
        self.type = type
    }
    
    public var body: some View {
        Group {
            switch type {
            case .default:
                Toggle("", isOn: $isOn)
            case .checkbox(let size):
                Toggle("", isOn: $isOn)
                    .toggleStyle(SeugiCheckboxStyle(size: size))
            }
        }
        .tint(isOn ? Color.seugi(.primary(.p500)) : Color.seugi(.gray(.g200)))
        .fixedSize()
    }
}

struct SeugiCheckboxStyle: ToggleStyle {
    
    var size: ToggleSize
    
    func makeBody(configuration: Configuration) -> some View {
        Button {
            configuration.isOn.toggle()
        } label: {
            HStack {
                (configuration.isOn ? DesignSystemAsset.checkFill.swiftUIImage : DesignSystemAsset.checkLine.swiftUIImage)
                    .renderingMode(.template)
                    .resizable()
                    .frame(width: size.rawValue, height: size.rawValue)
                    .seugiForeground(configuration.isOn ? .primary(.p500) : .gray(.g500))
                configuration.label
            }
        }
    }
}
