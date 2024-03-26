//
//  SelectingJobType.swift
//  Feature
//
//  Created by dgsw8th71 on 3/26/24.
//  Copyright © 2024 seugi. All rights reserved.
//

import Foundation
import SwiftUI
import DesignSystem

enum JobType: String, CaseIterable {
    case student = "학생"
    case teacher = "선생님"
    
    var activeImage: Image {
        switch self {
        case .student: DesignSystemAsset.studentActive.swiftUIImage
        case .teacher: DesignSystemAsset.teacherActive.swiftUIImage
        }
    }
    
    var disableImage: Image {
        switch self {
        case .student: DesignSystemAsset.studentDisable.swiftUIImage
        case .teacher: DesignSystemAsset.teacherDisable.swiftUIImage
        }
    }
}
