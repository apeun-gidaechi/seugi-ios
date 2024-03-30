import SwiftUI
import BaseFeature
import OnboardingFeature
import MainFeature

public struct RootView: View {
    
    private var isAuthed = false
    
    public init() {}
    
    public var body: some View {
        if !isAuthed {
            OnboardingView()
        } else {
            MainView()
        }
    }
}
