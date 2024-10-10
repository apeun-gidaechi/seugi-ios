import Foundation
import SwiftUI
import Component
import Domain

enum JobType: String, CaseIterable {
    case student = "학생"
    case teacher = "선생님"
    
    var image: SeugiImage {
        switch self {
        case .student: .student
        case .teacher: .teacher
        }
    }
    
    func toWorkspaceRole() -> WorkspaceRole {
        switch self {
        case .student:
                .student
        case .teacher:
                .teacher
        }
    }
}
