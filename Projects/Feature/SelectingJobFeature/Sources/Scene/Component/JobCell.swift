//
//  JobCell.swift
//  Feature
//
//  Created by dgsw8th71 on 3/26/24.
//  Copyright © 2024 seugi. All rights reserved.
//

import SwiftUI
import DesignSystem
import SwiftUIUtil

struct JobCell: View {
    
    var jobType: JobType
    var isActive: Bool
    
    var body: some View {
        VStack(spacing: 5) {
            let textColor: Color.SeugiColorSystem = isActive ? .sub(.black) : .gray(.g500)
            HStack(spacing: 4) {
                Text(jobType.rawValue)
                    .font(.subtitle(.s2))
                    .seugiColor(textColor)
                if isActive {
                    Image(icon: .checkLine)
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: 24, height: 24)
                        .seugiColor(.primary(.p500))
                }
            }
            .padding(.top, 17)
            Image(image: jobType.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 120, height: 120)
                .offset(y: 20)
        }
        .frame(height: 189)
        .frame(maxWidth: .infinity)
        .background(Color.seugi(.gray(.g100)))
        .cornerRadius(12, corners: .allCorners)
        .stroke(12, color: isActive ? .seugi(.primary(.p500)) : .seugi(.gray(.g300)), lineWidth: isActive ? 2 : 1)
        .if(isActive) {
            $0
                .shadow(.evPrimary(.ev3))
        }
    }
}
