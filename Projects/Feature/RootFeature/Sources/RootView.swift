import SwiftUI
import BaseFeature
import OnboardingFeature
import JoinSchoolFeature
import MainFeature

public struct RootView: View {
    
    @State private var authType: AuthType = .unAuthorized
    
    public init() {}
    
    public var body: some View {
        switch authType {
        case .unAuthorized:
            OnboardingView()
        case .notFoundJoinedSchool:
            JoinSchoolView()
        case .authorized:
            MainView()
        }
    }
}
