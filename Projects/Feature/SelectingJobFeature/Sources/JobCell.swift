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
        VStack {
            Group {
                if isActive {
                    jobType.activeImage
                        .resizable()
                } else {
                    jobType.disableImage
                        .resizable()
                }
            }
            .aspectRatio(contentMode: .fill)
            .frame(width: 120, height: 120)
            let textColor: Color.SeugiColorSystem = isActive ? .sub(.black) : .gray(.g500)
            Text(jobType.rawValue)
                .font(.seugi(.subtitle2))
                .seugiColor(textColor)
        }
        .padding(16)
        .frame(maxWidth: .infinity)
        .background(Color.seugi(.gray(.g100)))
        .cornerRadius(12, corners: .allCorners)
        .stroke(12, color: isActive ? .seugi(.primary(.p500)) : .seugi(.gray(.g300)), lineWidth: isActive ? 2 : 1)
    }
}
