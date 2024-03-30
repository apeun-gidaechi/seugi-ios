import SwiftUI
import DesignSystem
import BaseFeature
import SchoolCodeFeature
import JoinSuccessFeature

public struct JoinSchoolView: View {
    
    @StateObject private var navController = JoinSchoolNavigationController()
    
    public init() {}
    
    public var body: some View {
        NavigationStack(path: $navController.path) {
            SchoolCodeView { navController.navigateTo(.joinSuccess) }
                .navigationDestination(for: ViewType.JoinSchool.self) { viewType in
                    switch viewType {
                    case .joinSuccess: JoinSuccessView()
                    }
                }
        }
    }
}
