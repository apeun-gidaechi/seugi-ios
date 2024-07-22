//
//  SelectingJobType.swift
//  Feature
//
//  Created by dgsw8th71 on 3/26/24.
//  Copyright © 2024 seugi. All rights reserved.
//

import Foundation
import SwiftUI
import Component

enum JobType: String, CaseIterable {
    case student = "학생"
    case teacher = "선생님"
    
    var image: SeugiImage {
        switch self {
        case .student: .student
        case .teacher: .teacher
        }
    }
}
