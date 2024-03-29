//
//  RoundedCirclePreview.swift
//  DesignSystemExample
//
//  Created by dgsw8th71 on 3/29/24.
//  Copyright © 2024 apeun.gidaechi. All rights reserved.
//

import SwiftUI
import DesignSystem

public struct RoundedCirclePreview: View {
    
    public var body: some View {
        ScrollView {
            VStack {
                SeugiRoundedCircleImage.large(type: .add)
                SeugiRoundedCircleImage.large(type: .school)
                SeugiRoundedCircleImage.large(type: .image)
                SeugiRoundedCircleImage.large(type: .fill(image: DesignSystemAsset.studentActive.swiftUIImage))
                
                SeugiRoundedCircleImage.small(type: .add)
                SeugiRoundedCircleImage.small(type: .school)
                SeugiRoundedCircleImage.small(type: .image)
                SeugiRoundedCircleImage.small(type: .fill(image: DesignSystemAsset.studentActive.swiftUIImage))
            }
        }
    }
}
